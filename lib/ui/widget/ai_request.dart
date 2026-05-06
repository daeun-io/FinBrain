import 'package:finbrain/themes/colors.dart';
import 'package:flutter/material.dart';

class AiRequest extends StatelessWidget{
  const AiRequest({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
      child: Card(
        color: primary400,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.all(Radius.circular(20.0)),
        ),
        child: Column(
          children: [
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