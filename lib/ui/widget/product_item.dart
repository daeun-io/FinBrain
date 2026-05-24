import 'package:finbrain/provider/product_provider.dart';
import 'package:finbrain/themes/colors.dart';
import 'package:finbrain/ui/product_categories.dart';
import 'package:finbrain/ui/screen/product_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductItem extends ConsumerWidget{
  const ProductItem({
    super.key,
    required this.productName,
  });

  final String productName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final product = ref.watch(productProvider).firstWhere(
      (p) => p.commonInfo.productName == productName,
    );

    return GestureDetector(
      onTap:(){
        Navigator.of(context).push(
          MaterialPageRoute(builder:
            (ctx) => ProductDetailScreen(productName: productName, category: product.commonInfo.category,)
          )
      );
      },
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          color: primary100,
        ),
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Row(children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                Text(
                  productName,
                  style: const TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w600,
                    color: textPrimary
                  ),
                ),
                const SizedBox(height: 6.0,),
                Text(
                  product.commonInfo.companyName!,
                  style: const TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.w400,
                    color: textSecondary
                  ),
                ),
              ],),
            ),
            const SizedBox(width: 28.0,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
              Text(
                "정렬 기준",
                style: const TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w400,
                  color: textSecondary,
                ),
              ),
              const SizedBox(height: 6.0,),
              Text(
                "이자율",
                style: const TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w600,
                  color: textPrimary,
                ),
              ),
            ],),
            const SizedBox(width: 3.0,),
            IconButton(
              onPressed: (){
                ref.read(productProvider.notifier).toggleLiked(productName);
              }, 
              icon: product.commonInfo.isLiked ? const Icon(Icons.favorite, color: likedColor, size: 32.0,) : const Icon(Icons.favorite, color: unlikedColor, size: 32.0,)
            )
          ],),
        ),
      ),
    );
  }
}