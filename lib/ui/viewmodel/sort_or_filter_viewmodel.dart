import 'package:finbrain/product_categories.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'sort_or_filter_viewmodel.g.dart';

// 정렬/필터 바텀시트 뷰모델
// Sort/filter bottom sheet viewmodel
@riverpod
class SortOrFilterTextViewModel extends _$SortOrFilterTextViewModel {
  // 상품 카테고리 별 기준 생성
  // Set criteria by product category
  @override
  (Object, List<String>) build(ProductCategory category) {
    final optionList = switch (category) {
      ProductCategory.deposit ||
      ProductCategory.installment => ["최고 금리(높은 순)", "기본 금리(높은 순)"],
      ProductCategory.mortgage ||
      ProductCategory.rent ||
      ProductCategory.credit => ["최저 금리(낮은 순)", "최고 금리(낮은 순)", "평균 금리(낮은 순)"],
      ProductCategory.isaJoin => [
        "회사 수(내림차순)",
        "회사 수(오름차순)",
        "가입자 수(내림차순)",
        "가입자 수(오름차순)",
      ],
      ProductCategory.isaManagement => ["금액/비율(내림차순)", "금액/비율(오름차순)"],
      ProductCategory.isaMp => ["평균 수익률(높은 순)", "중위 수익률(높은 순)"],
      ProductCategory.liked => [
        "모든 상품",
        "정기예금",
        "적금",
        "ISA",
        "주택담보대출",
        "전세자금대출",
        "개인신용대출",
      ],
    };

    // 관심 상품만 선택 기준을 리스트로 설정
    // Use list to save selected criteria in liked product
    if (category == ProductCategory.liked) {
      return ([optionList[0]], optionList);
    } else {
      return (optionList[0], optionList);
    }
  }

  void changeCriteria(dynamic criteria) {
    state = (criteria, state.$2);
  }
}
