import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'ai_screen_viewmodel.g.dart';

@riverpod
class AiScreenViewmodel extends _$AiScreenViewmodel{
  @override
  Map<String, String> build(String tag) => {};

  void addRequest(String newRequest, String newResponse){
    state = {
      ...state,
      newRequest: newResponse
    };
  }
}