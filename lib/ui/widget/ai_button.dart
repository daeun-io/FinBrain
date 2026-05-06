import 'package:finbrain/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AiButton extends StatelessWidget{
  const AiButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      width: 80,
      child: FloatingActionButton(
        onPressed: (){},
        backgroundColor: primary900,
        splashColor: Colors.transparent,
        shape: const CircleBorder(), 
        elevation: 0.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset("assets/images/ai_assist.svg"),
            Text(
              "AI 도우미",
              style: TextStyle(
                color: textTertiary,
                fontSize: 12.0,
                fontWeight: FontWeight.w600
              ),
            )
          ],
        ),
      ),
    );
  }
}