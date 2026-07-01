import 'package:finbrain/product_categories.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'current_ctg_viewmodel.g.dart';

@riverpod
class CurrentCtgViewmodel extends _$CurrentCtgViewmodel{
  @override
  ProductCategory build() => ProductCategory.deposit;

  void setCurrentCtg(ProductCategory category) => state = category;
}