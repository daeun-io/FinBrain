import 'package:finbrain/data/model/entities/financial_product.dart';
import 'package:finbrain/product_categories.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'selected_prdt_viewmodel.g.dart';

@riverpod
class SelectedProductsViewmodel extends _$SelectedProductsViewmodel{
  @override
  List<FinancialProduct> build() => [];

  void addProduct(FinancialProduct product){
    state = [...state, product];
  }

  void subtractProduct(FinancialProduct product){
    state = state.where((e) => e != product).toList();
  }

  void resetSelectedList() => state = [];

  int getNumOfProducts(){
    return state.length;
  }
  
  bool allCategoriesSame(){
    for(int i = 0; i < state.length - 1; i++){
      if(state[i].commonInfo.category != state[i+1].commonInfo.category){
        return false;
      }
    }
    return true;
  }

  ProductCategory? getCategory(){
    if(state.isEmpty) return null;
    final isCtgSame = allCategoriesSame();
    if(isCtgSame){
      return state.first.commonInfo.category;
    } else{
      return null;
    }
  }
}