import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'tutorial_viewmodel.g.dart';

// 추후 Firestore에서 데이터 불러오는 걸로 수정
@riverpod
class DetailTutorialViewmodel extends _$DetailTutorialViewmodel {
  @override
  int build() => 0;

  void updatePhase([int? phase]) {
    if (phase == null) {
      state = state + 1;
    } else {
      state = phase;
    }
  }

  void resetPhase() => state = 0;
}
