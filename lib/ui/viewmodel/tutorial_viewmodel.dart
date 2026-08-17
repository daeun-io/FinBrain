import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'tutorial_viewmodel.g.dart';

@Riverpod(keepAlive: true)
class DetailTutorialViewmodel extends _$DetailTutorialViewmodel {
  @override
  int build() => 1;

  void updatePhase([int? phase]) {
    if (phase == null) {
      state = state + 1;
    } else {
      state = phase;
    }
  }

  void resetPhase() => state = 0;
}
