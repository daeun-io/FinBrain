import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'selected_topFinGrpNo_viewmodel.g.dart';

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
    if (state.keys.contains(category)) {
      state = {...state, category: topFinGrp};
    }
  }
}
