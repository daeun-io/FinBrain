import 'package:finbrain/data/model/entities/financial_product.dart';
import 'package:flutter_riverpod/legacy.dart';

class LikedNotifier extends StateNotifier<List<FinancialProduct>>{

  LikedNotifier(): super([]);

  bool toggleLikedStatus(FinancialProduct item){
    final itemIsLiked = state.contains(item);
    if(itemIsLiked){
      state = state.where((i) => i.commonInfo.productCode != item.commonInfo.productCode).toList();
      return false;
    }else{
      state = [...state, item];
      return true;
    }
  }
  final likedProvider = StateNotifierProvider<LikedNotifier, List<FinancialProduct>>((ref){
    return LikedNotifier();
  });
}