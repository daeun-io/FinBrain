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


  void resetSelectedList(){
    state = [];
    print("reset state: $state");
  }
}