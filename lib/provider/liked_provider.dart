import 'package:finbrain/data/model/entities/financial_product.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'product_provider.dart';

final likedProvider = Provider<List<FinancialProduct>>((ref){
  final allProducts = ref.watch(productProvider);
  return allProducts.where((element) => element.commonInfo.isLiked == true,).toList();
});