import 'package:finbrain/data/model/entities/financial_product.dart';
import 'package:finbrain/provider/sort_or_filter_provider.dart';
import 'package:finbrain/ui/product_categories.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'product_provider.dart';
part 'liked_provider.g.dart';

@riverpod
class LikedNotifier extends _$LikedNotifier {
  @override
  List<FinancialProduct> build() {
    final allProducts = ref.watch(productNotifierProvider);
    final filters = ref.watch(
      sortOrFilterTextNotifierProvider(FilterTextCategory.liked),
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

    return allProducts
        .where(
          (element) =>
              element.commonInfo.isLiked == true &&
              categories.contains(element.commonInfo.category),
        )
        .toList();
  }
}
