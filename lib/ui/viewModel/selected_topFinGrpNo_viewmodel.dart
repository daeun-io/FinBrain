import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'selected_topFinGrpNo_viewmodel.g.dart';

@Riverpod(keepAlive: true)
@riverpod
class SelectedTopfingrpnoViewmodel extends _$SelectedTopfingrpnoViewmodel {
  @override
  Map<String, String> build() {
    return {
      "예적금": "020000",
      "대출": "020000",
      "연금저축": "050000"
    };
  }

  void changeTopFinGrp(String category, String topFinGrp) {
    print("=======================");
    print("🔥 changeTopFinGrp 호출됨! 넘어온 카테고리: $category, 번호: $topFinGrp");
    if (state.keys.contains(category)) {
      state = {...state, category: topFinGrp};
      print("✅ 상태 업데이트 완료: $state");
    } else {
      print("❌ 조건문 실패! state.keys에 '$category'가 없습니다.");
    }
    print("=======================");
  }
}
