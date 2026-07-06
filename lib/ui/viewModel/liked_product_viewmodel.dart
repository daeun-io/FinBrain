import 'package:finbrain/data/google_auth_service.dart';
import 'package:finbrain/data/model/entities/financial_product.dart';
import 'package:finbrain/data/repository/liked_repository.dart';
import 'package:finbrain/product_categories.dart';
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
        print("No user is currently signed in.");
        return [];
      }
      final products = await repository.getLikedProducts(user.uid);
      print("liked_products $products");
      if (products.isEmpty) {
        return [];
      }
      return products;
    } catch (e) {
      print("Error fetching data in liked_products $e");
      return [];
    }
  }
}

@riverpod
class LikedProductViewmodel extends _$LikedProductViewmodel {
  @override
  Future<List<FinancialProduct>> build() async {
    final likedProducts = ref.watch(fetchLikedViewmodelProvider);
    debugPrint("liked products: $likedProducts");
    final filtered = filterByCategory("모든 상품", likedProducts.value);
    debugPrint("liked filtered products: $filtered");
    return filtered;
  }

  List<FinancialProduct> filterByCategory(
    String criteria, [
    List<FinancialProduct>? products,
  ]) {
    final criteriaList = criteria.split(",").map((e) => e.trim()).toList();
    print("liked criteriaList : $criteriaList");
    final categories = [];
    if (criteriaList.contains("모든 상품")) {
      categories.addAll(ProductCategory.values);
    } else {
      if (criteriaList.contains("정기예금"))
        categories.add(ProductCategory.deposit);
      if (criteriaList.contains("적금"))
        categories.add(ProductCategory.installment);
      if (criteriaList.contains("ISA")) categories.add(ProductCategory.isa);
      if (criteriaList.contains("주택담보대출"))
        categories.add(ProductCategory.mortage);
      if (criteriaList.contains("전세자금대출")) categories.add(ProductCategory.rent);
      if (criteriaList.contains("개인신용대출"))
        categories.add(ProductCategory.credit);
      if (criteriaList.contains("연금저축"))
        categories.add(ProductCategory.annuity);
    }

    debugPrint("liked categories: $categories");
    debugPrint("liked state: ${state.value}");

    final fetchedProducts = ref.read(fetchLikedViewmodelProvider);
    final baseProducts = products ?? fetchedProducts.value ?? [];
    
    final filtered = baseProducts
        .where((e) => categories.contains(e.commonInfo.category))
        .toList();

    debugPrint("liked filtered in func: $filtered");
    state = AsyncData(filtered);
    return filtered;
  }

  Future<void> addInLikedList(FinancialProduct product) async {
    try {
      final user = GoogleAuthService.getCurrentUser();
      if (user == null) {
        print("No user is currently signed in.");
        return;
      }
      state = AsyncData([...state.value ?? [], product]);
      await repository.saveProductAsLiked(user.uid, product);
    } catch (e) {
      print("Error checking collection existence: $e");
    }
  }

  Future<void> deleteInLikedList(FinancialProduct product) async {
    try {
      final user = GoogleAuthService.getCurrentUser();
      if (user == null) {
        print("No user is currently signed in.");
        return;
      }
      state = AsyncData(
        (state.value ?? [])
            .where(
              (e) => e.commonInfo.productName != product.commonInfo.productName,
            )
            .toList(),
      );
      await repository.deleteProductInFirestore(
        user.uid,
        product.commonInfo.productName!,
      );
    } catch (e) {
      print("Error deleting liked product: $e");
    }
  }

  void filterByKeyword(String keyword) {
    if (keyword.isNotEmpty) {
      state = AsyncData(
        (state.value ?? [])
            .where((e) => e.commonInfo.productName!.contains(keyword))
            .toList(),
      );
    }
  }
}
