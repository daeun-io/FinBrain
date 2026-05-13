import 'package:finbrain/provider/product_provider.dart';
import 'package:finbrain/themes/colors.dart';
import 'package:finbrain/ui/screen/calculator_screen.dart';
import 'package:finbrain/ui/widget/ai_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductDetailScreen extends ConsumerWidget {
  const ProductDetailScreen({
    super.key,
    required this.productName
  });

  final String productName;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final product = ref.watch(productProvider).firstWhere(
      (p) => p.commonInfo.productName == productName
    );

    return Scaffold(
      backgroundColor: white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: primary100,
        leading: IconButton(
          onPressed: (){
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: textPrimary,
          ),
        ),
        title: Text(
          productName,
          style: TextStyle(
            color: textPrimary,
            fontSize: 20.0,
            fontWeight: FontWeight.w600,
          ),
        ),
        titleSpacing: -6.0,
        actions: [
          IconButton(
            onPressed: () {
              ref.read(productProvider.notifier).toggleLiked(productName);
            },
            icon: product.commonInfo.isLiked ? const Icon(Icons.favorite, color: likedColor, size: 32.0):const Icon(Icons.favorite, color: unlikedColor, size: 32.0) ,
          ),
        ],
      ),
      body: SizedBox.expand(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 24.0,
                    horizontal: 20.0,
                  ),
                  child: Column(
                    children: [
                      Text(
                        product.commonInfo.submittedDay.toString(),
                      ), 
                      SizedBox(height: 80.0)],
                  ),
                ),
              ),
            ),
            Positioned(
              right: 20,
              bottom: 100,
              child: const AiButton()
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (ctx) => const CalculatorScreen(),
                          ),
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 20.0),
                        color: primary300,
                        alignment: Alignment.center,
                        child: Text(
                          "금융 계산기",
                          style: TextStyle(
                            color: textPrimary,
                            fontSize: 18.0,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 20.0),
                      color: primary100,
                      alignment: Alignment.center,
                      child: Text(
                        "공식 홈페이지로 이동",
                        style: TextStyle(
                          color: textPrimary,
                          fontSize: 18.0,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}