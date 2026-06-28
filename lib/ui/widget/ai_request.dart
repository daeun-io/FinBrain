import 'package:finbrain/themes/colors.dart';
import 'package:flutter/material.dart';

class AiRequest extends StatelessWidget {
  const AiRequest({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: 0,
        maxWidth: MediaQuery.of(context).size.width * 0.8
      ),
      child: Card(
        color: const Color(0xFFF4F4F4),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.all(Radius.circular(20.0)),
        ),
        elevation: 0.0,
        shadowColor: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                text,
                style: TextStyle(
                  color: black,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
