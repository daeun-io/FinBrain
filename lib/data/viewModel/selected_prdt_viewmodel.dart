import 'package:finbrain/data/models/entities/financial_product.dart';
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

  bool allCategoriesSame(){
    for(int i = 0; i < state.length - 1; i++){
      if(state[i].commonInfo.category != state[i+1].commonInfo.category){
        return false;
      }
    }
    return true;
  }
}