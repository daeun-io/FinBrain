import 'package:finbrain/data/models/entities/financial_product.dart';
import 'package:finbrain/data/viewModel/sort_or_filter_viewmodel.dart';
import 'package:finbrain/product_categories.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'liked_product_viewmodel.g.dart';

@riverpod
class LikedProductViewmodel extends _$LikedProductViewmodel {
  @override
  Future<List<FinancialProduct>> build() async {
    final filters = ref.watch(
      sortOrFilterTextViewModelProvider(FilterTextCategory.liked),
    );
    final categories = ((filters.$1 as List<String>).first == "모든 상품")
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
            for (final item in (filters.$1 as List<String>))
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
    // todo: change later(load db and fetch filter)
    return [];
  }

  // todo: change later(insert a product in db)
  void addLikedProduct(FinancialProduct product) {
    state = AsyncData([...state.value ?? [], product]);
  }

  void subtractLikedProduct(FinancialProduct product) {
    state = AsyncData(
      (state.value ?? [])
          .where(
            (e) => e.commonInfo.productName != product.commonInfo.productName,
          )
          .toList(),
    );
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
