import 'package:finbrain/data/google_auth_service.dart';
import 'package:finbrain/data/model/entities/financial_product.dart';
import 'package:finbrain/data/repository/liked_repository.dart';
import 'package:finbrain/product_categories.dart';
import 'package:finbrain/ui/viewmodel/sort_or_filter_viewmodel.dart';
import 'package:flutter/rendering.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'liked_product_viewmodel.g.dart';

final repository = LikedRepository();

// 관심 상품 불러오는 뷰모델
// Fetching liked product viewmodel
@riverpod
class FetchLikedViewmodel extends _$FetchLikedViewmodel {
  @override
  Future<List<FinancialProduct>> build() async {
    try {
      final user = GoogleAuthService.getCurrentUser();
      if (user == null) {
        throw Exception("[user] no user found");
      }
      // 관심 상품 불러오기
      // Fetch liked products
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

// 화면에 관심 상품 보이는 뷰모델
// Displaying liked products in screen
@riverpod
class LikedProductViewmodel extends _$LikedProductViewmodel {
  @override
  Future<List<FinancialProduct>> build() async {
    final likedProducts = ref.watch(fetchLikedViewmodelProvider);
    return getProductsFilteredByCriteria(likedProducts.value);
  }

  // 카테고리로 데이터 필터링
  // Filter liked products with category
  List<FinancialProduct> filterByCategory(
    String criteria, [
    List<FinancialProduct>? products,
  ]) {
    // 필터 불러오기
    // Fetch filter
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

    // 데이터 불러와 필터 적용하기
    // Fetch data and apply filter
    final fetchedProducts = ref.read(fetchLikedViewmodelProvider);
    final baseProducts = products ?? fetchedProducts.value ?? [];

    final filtered = baseProducts
        .where((e) => categories.contains(e.commonInfo.category))
        .toList();
    state = AsyncData(filtered);
    return filtered;
  }

  // 좋아요 상품 필터링하는 데이터
  // Filter liked products
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

  // 금융 상품 관심 리스트에 저장하기
  // Save given financial product in liked list
  Future<void> addInLikedList(FinancialProduct product) async {
    try {
      final user = GoogleAuthService.getCurrentUser();
      if (user == null) {
        throw Exception("[user] no user found");
      }

      // 서버에 적용하기
      // Apply in server
      await repository.saveProductAsLiked(user.uid, product);

      ref.invalidate(fetchLikedViewmodelProvider);

      // 데이터를 다시 불러와 필터링하기
      // Fetch data again and apply filter
      final allProducts = await ref.read(fetchLikedViewmodelProvider.future);
      state = AsyncData(getProductsFilteredByCriteria(allProducts));
    } catch (e) {
      throw Exception("[error] failed to save product as liked : $e");
    }
  }

  // 금융 상품 관심 리스트에서 삭제하기
  // Delete given financial product in liked list
  Future<void> deleteInLikedList(FinancialProduct product) async {
    try {
      final user = GoogleAuthService.getCurrentUser();
      if (user == null) {
        throw Exception("[user] no user found");
      }

      // 서버에 적용하기
      // Apply in server
      await repository.deleteProductInFirestore(
        user.uid,
        (product.commonInfo.category == ProductCategory.isaMp)
            ? product.commonInfo.productName!
            : product.commonInfo.productCode!,
      );

      ref.invalidate(fetchLikedViewmodelProvider);

      // 데이터를 다시 불러와 필터링하기
      // Fetch data again and apply filter
      final allProducts = await ref.read(fetchLikedViewmodelProvider.future);
      state = AsyncData(getProductsFilteredByCriteria(allProducts));
    } catch (e) {
      throw Exception("[error] failed to delete liked product : $e");
    }
  }

  // 검색창을 통해 키워드로 필터링하기
  // Filter by keyword using search bar
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
