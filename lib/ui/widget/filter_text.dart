import 'package:flutter/material.dart';

class FilterText extends StatelessWidget{
  const FilterText({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        const Text(
          "정렬 기준", 
          style: TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.w400
          ),
        ),
        IconButton(
          // todo: implement later
          onPressed: (){},
          padding: EdgeInsets.zero,
          constraints: BoxConstraints(),
          visualDensity: VisualDensity.compact,
          icon: Icon(Icons.keyboard_arrow_down, size: 24,)
        )
      ],
    );
  }
}