import 'package:finbrain/product_categories.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'current_page_viewmodel.g.dart';

// 카테고리 별 현재 페이지
// Current page by product category
@riverpod
class CurrentPageViewmodel extends _$CurrentPageViewmodel{
  @override
  int build(ProductCategory ctg) => 1;

  void setCurrentPage(int nPage) => state = nPage;
}