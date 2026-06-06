import 'package:finbrain/data/model/entities/financial_product.dart';
import 'package:finbrain/ui/product_categories.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'product_provider.dart';
part 'liked_provider.g.dart';

@riverpod
class LikedNotifier extends _$LikedNotifier {
  @override
  List<FinancialProduct> build() {
    final allProducts = ref.watch(productNotifierProvider);
    return allProducts
        .where((element) => element.commonInfo.isLiked == true)
        .toList();
  }

  void filterByCategory(List<String> filters) {
    final categories = (filters[0] == "모든 상품")
        ? []
        : [
            for (final item in filters)
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
    state = state.where((e) => categories.contains(e.commonInfo.category)).toList();
  }
}
