import 'package:finbrain/data/google_auth_service.dart';
import 'package:finbrain/data/model/entities/financial_product.dart';
import 'package:finbrain/data/repository/liked_repository.dart';
import 'package:finbrain/ui/viewmodel/sort_or_filter_viewmodel.dart';
import 'package:finbrain/product_categories.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'liked_product_viewmodel.g.dart';

@riverpod
class LikedProductViewmodel extends _$LikedProductViewmodel {
  final repository = LikedRepository();

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

  void filterByCategory(String criteria) {
    final criteriaList = criteria.split(",").map((e) => e.trim()).toList();
    print("criteriaList : $criteriaList");
    final categories = (criteriaList.first == "모든 상품")
        ? [
            ProductCategory.deposit,
            ProductCategory.installment,
            ProductCategory.isa,
            ProductCategory.mortage,
            ProductCategory.rent,
            ProductCategory.credit,
            ProductCategory.annuity,
          ]
        : [
            for (final item in criteriaList)
              if (item == "정기예금")
                ProductCategory.deposit
              else if (item == "적금")
                ProductCategory.installment
              else if (item == "ISA")
                ProductCategory.isa
              else if (item == "주택담보대출")
                ProductCategory.mortage
              else if (item == "전세자금대출")
                ProductCategory.rent
              else if (item == "개인신용대출")
                ProductCategory.credit
              else
                ProductCategory.annuity,
          ];
    state = AsyncData(
      (state.value ?? [])
          .where((e) => categories.contains(e.commonInfo.category))
          .toList(),
    );
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
