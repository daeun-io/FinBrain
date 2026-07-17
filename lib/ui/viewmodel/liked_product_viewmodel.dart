import 'package:finbrain/data/google_auth_service.dart';
import 'package:finbrain/data/model/entities/financial_product.dart';
import 'package:finbrain/data/repository/liked_repository.dart';
import 'package:finbrain/product_categories.dart';
import 'package:finbrain/ui/viewmodel/sort_or_filter_viewmodel.dart';
import 'package:flutter/rendering.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'liked_product_viewmodel.g.dart';

final repository = LikedRepository();

@riverpod
class FetchLikedViewmodel extends _$FetchLikedViewmodel {
  @override
  Future<List<FinancialProduct>> build() async {
    try {
      final user = GoogleAuthService.getCurrentUser();
      if (user == null) {
        throw Exception("[user] no user found");
      }
      final products = await repository.getLikedProducts(user.uid);

      if (products.isEmpty) {
        debugPrint("[empty] product list is empty");
        return [];
      }
      return products;
    } catch (e) {
      throw Exception("[error] failed to fetch liked products, $e");
    }
  }
}

@riverpod
class LikedProductViewmodel extends _$LikedProductViewmodel {
  @override
  Future<List<FinancialProduct>> build() async {
    final likedProducts = ref.watch(fetchLikedViewmodelProvider);
    return getProductsFilteredByCriteria(likedProducts.value);
  }

  List<FinancialProduct> filterByCategory(
    String criteria, [
    List<FinancialProduct>? products,
  ]) {
    final criteriaList = criteria.split(",").map((e) => e.trim()).toList();

    final categories = [];
    if (criteriaList.contains("모든 상품")) {
      categories.addAll(ProductCategory.values);
    } else {
      if (criteriaList.contains("정기예금")) categories.add(ProductCategory.deposit);
      if (criteriaList.contains("적금")) categories.add(ProductCategory.installment);
      if (criteriaList.contains("ISA")) categories.add(ProductCategory.isaMp);
      if (criteriaList.contains("주택담보대출")) categories.add(ProductCategory.mortgage);
      if (criteriaList.contains("전세자금대출")) categories.add(ProductCategory.rent);
      if (criteriaList.contains("개인신용대출")) categories.add(ProductCategory.credit);
    }

    final fetchedProducts = ref.read(fetchLikedViewmodelProvider);
    final baseProducts = products ?? fetchedProducts.value ?? [];

    final filtered = baseProducts
        .where((e) => categories.contains(e.commonInfo.category))
        .toList();
    state = AsyncData(filtered);
    return filtered;
  }

  List<FinancialProduct> getProductsFilteredByCriteria([
    List<FinancialProduct>? allProducts,
  ]) {
    final criteria = ref.read(
      sortOrFilterTextViewModelProvider(ProductCategory.liked),
    );
    return filterByCategory(
      (criteria.$1 as List<String>)
          .toString()
          .replaceAll("[", "")
          .replaceAll("]", ""),
      allProducts,
    );
  }

  Future<void> addInLikedList(FinancialProduct product) async {
    try {
      final user = GoogleAuthService.getCurrentUser();
      if (user == null) {
        throw Exception("[user] no user found");
      }

      await repository.saveProductAsLiked(user.uid, product);

      ref.invalidate(fetchLikedViewmodelProvider);

      final allProducts = await ref.read(fetchLikedViewmodelProvider.future);
      state = AsyncData(getProductsFilteredByCriteria(allProducts));
    } catch (e) {
      throw Exception("[error] failed to save product as liked : $e");
    }
  }

  Future<void> deleteInLikedList(FinancialProduct product) async {
    try {
      final user = GoogleAuthService.getCurrentUser();
      if (user == null) {
        throw Exception("[user] no user found");
      }

      await repository.deleteProductInFirestore(
        user.uid,
        product.commonInfo.productName!,
      );

      ref.invalidate(fetchLikedViewmodelProvider);

      final allProducts = await ref.read(fetchLikedViewmodelProvider.future);
      state = AsyncData(getProductsFilteredByCriteria(allProducts));
    } catch (e) {
      throw Exception("[error] failed to delete liked product : $e");
    }
  }

  void filterByKeyword(String keyword) {
    final products = getProductsFilteredByCriteria();
    if (keyword.isNotEmpty) {
      state = AsyncData(
        products
            .where((e) => e.commonInfo.productName!.contains(keyword))
            .toList(),
      );
    } else {
      state = AsyncData(products);
    }
  }
}
