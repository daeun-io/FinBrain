import 'package:finbrain/ui/product_categories.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'sort_or_filter_provider.g.dart';

@riverpod
class SortOrFilterTextNotifier extends _$SortOrFilterTextNotifier {
  @override
  (Object, List<String>) build(FilterTextCategory category) {
    final optionList = switch (category) {
      FilterTextCategory.savings => ["최고 금리(높은 순)", "기본 금리(높은 순)"],
      FilterTextCategory.loan => ["최저 금리(낮은 순)", "최고 금리(낮은 순)", "평균 금리(낮은 순)"],
      FilterTextCategory.annuity => [
        "평균 수익률(높은 순)",
        "전년도 수익률(높은 순)",
        "전전년도 수익률(높은 순)",
        "전전전년도 수익률(높은 순)",
      ],
      FilterTextCategory.isa => ["최신순", "오래된 순"],
      FilterTextCategory.liked => [
        "모든 상품",
        "정기예금",
        "적금",
        "ISA",
        "주택담보대출",
        "전세자금대출",
        "개인신용대출",
        "연금 저축",
      ],
    };

    if(category == FilterTextCategory.liked){
      return ([optionList[0]], optionList);
    }else{
      return (optionList[0], optionList);
    }
  }

  void changeCriteria(dynamic criteria){
    state = (criteria, state.$2);
  }
}
