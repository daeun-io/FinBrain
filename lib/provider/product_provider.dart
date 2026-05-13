import 'package:finbrain/data/dummy_data.dart';
import 'package:finbrain/data/model/entities/financial_product.dart';
import 'package:flutter_riverpod/legacy.dart';

class ProductNotifier extends StateNotifier<List<FinancialProduct>>{

  ProductNotifier(): super(dummyData);

  void toggleLiked(String productName){
    state = [
      for(final item in state)
        if(item.commonInfo.productName == productName)
          item.copyWith(item.commonInfo.copyWith(!item.commonInfo.isLiked))
        else
          item
    ];
  }
}

final productProvider = StateNotifierProvider<ProductNotifier, List<FinancialProduct>>((ref){
  return ProductNotifier();
});