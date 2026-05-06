import 'package:finbrain/themes/colors.dart';
import 'package:finbrain/ui/widget/ai_button.dart';
import 'package:flutter/material.dart';

class ProductDetailScreen extends StatelessWidget{
  const ProductDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: primary100,
        title: const Text(
          "우리웰리치 주거래예금",
          style: TextStyle(
            color: textPrimary,
            fontSize: 20.0,
            fontWeight: FontWeight.w600
          ),
        ),
        actions: [
          IconButton(
            onPressed: (){},
            icon: const Icon(
              Icons.favorite,
              color: white,
              size: 32.0,
            )
          )
        ],
      ),
      body: Expanded(
        child: Column(
          children: [
            const Text("Example"),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 20.0),
                    color: primary300,
                    alignment: Alignment.center,
                    child: Text(
                      "금융 계산기",
                      style: TextStyle(
                        color: textPrimary,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w400
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
                        fontWeight: FontWeight.w400
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        )
      ),
      // todo: change later
      floatingActionButton: AiButton(),
    );
  }
}