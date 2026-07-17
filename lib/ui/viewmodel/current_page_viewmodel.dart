import 'package:finbrain/product_categories.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'current_page_viewmodel.g.dart';

@riverpod
class CurrentPageViewmodel extends _$CurrentPageViewmodel{
  @override
  int build(ProductCategory ctg) => 1;

  void setCurrentPage(int nPage) => state = nPage;
}