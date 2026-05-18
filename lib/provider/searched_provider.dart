import 'package:finbrain/data/model/entities/financial_product.dart';
import 'package:finbrain/provider/liked_provider.dart';
import 'package:finbrain/provider/product_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

final searchQueryProvider = StateProvider<String>((ref) => "");

final searchedProductProvider = Provider<List<FinancialProduct> Function(bool)>((ref) {
  final allProducts = ref.watch(productProvider);
  final likedProducts = ref.watch(likedProvider);
  final query = ref.watch(searchQueryProvider);

  return (bool isLikedList) {
    if (isLikedList) {
      if(query.isEmpty){
        return likedProducts;
      }
      return likedProducts
          .where((element) => element.commonInfo.productName == query)
          .toList();
    } else {
      if(query.isEmpty){
        return allProducts;
      }
      return allProducts
          .where((element) => element.commonInfo.productName == query)
          .toList();
    }
  };
});

class SearchedListProvider extends StateNotifier<List<String>> {
  SearchedListProvider() : super([]);

  void addItem(String productName) {
    if (!state.contains(productName)) {
      state = [...state, productName];
    }
  }
}

final searchedListProvider =
    StateNotifierProvider<SearchedListProvider, List<String>>((ref) {
      return SearchedListProvider();
    });