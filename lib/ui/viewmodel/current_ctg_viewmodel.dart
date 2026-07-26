import 'package:finbrain/product_categories.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'current_ctg_viewmodel.g.dart';

// 현재 화면에 보이는 금융 상품 카테고리
// Currently selected financial products' category
@riverpod
class CurrentCtgViewmodel extends _$CurrentCtgViewmodel{
  @override
  ProductCategory build() => ProductCategory.deposit;

  void setCurrentCtg(ProductCategory category) => state = category;
}