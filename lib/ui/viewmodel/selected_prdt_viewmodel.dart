import 'package:finbrain/data/model/entities/financial_product.dart';
import 'package:finbrain/product_categories.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'selected_prdt_viewmodel.g.dart';

// AI 비교분석을 위한 상품 리스트
// Selected product list for AI comparison
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
  
  // 선택된 상품의 카테고리가 동일한가
  // Are the categories of selected products the same
  bool allCategoriesSame(){
    for(int i = 0; i < state.length - 1; i++){
      if(state[i].commonInfo.category != state[i+1].commonInfo.category){
        return false;
      }
    }
    return true;
  }
  
  // 선택된 상품의 카테고리
  // Category of selected products
  ProductCategory? getCategory(){
    if(state.isEmpty) return null;
    // 선택된 상품 카테고리가 동일한지 확인
    // Check whether products' categories are same
    final isCtgSame = allCategoriesSame();
    if(isCtgSame){
      return state.first.commonInfo.category;
    } else{
      return null;
    }
  }
}