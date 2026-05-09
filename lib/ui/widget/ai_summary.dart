import 'package:finbrain/themes/colors.dart';
import 'package:flutter/material.dart';

class AiSummary extends StatelessWidget{
  const AiSummary({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
      child: Card(
        color: primary100,
        shape: const RoundedRectangleBorder(
          side: BorderSide(
            color: primary300,
            width: 1.0
          ),
          borderRadius: BorderRadiusGeometry.all(Radius.circular(20.0)),
        ),
        child: Column(
          children: [
            const Text(
              "제목",
              style: TextStyle(
                color: textPrimary,
                fontSize: 14.0,
                fontWeight: FontWeight.w600
              ),
            ),
            const Text(
              "부제목",
              style: TextStyle(
                color: black,
                fontSize: 12.0,
                fontWeight: FontWeight.w600
              ),
            ),
            const Text(
              "내용",
              style: TextStyle(
                color: black,
                fontSize: 12.0,
                fontWeight: FontWeight.w400
              ),
            ),
          ],
        )
      ),
    );
  }
}