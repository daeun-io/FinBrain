import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'searched_viewmodel.g.dart';

@riverpod
class SearchedViewmodel extends _$SearchedViewmodel{
  @override
  List<String> build(){
    return [];
  }

  void addItem(String productName) {
  if (!state.contains(productName)) {
    state = [...state, productName];
  }
}
}