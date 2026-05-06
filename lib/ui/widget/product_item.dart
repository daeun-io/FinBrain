import 'package:finbrain/themes/colors.dart';
import 'package:flutter/material.dart';

class ProductItem extends StatefulWidget{
  const ProductItem({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ProductItemState();
  }
}

class _ProductItemState extends State<ProductItem>{
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        color: primary100,
      ),
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Row(children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Text(
              "아이템 이름",
              style: const TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.w600,
                color: textPrimary
              ),
            ),
            const SizedBox(height: 6.0,),
            Text(
              "은행 이름",
              style: const TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.w400,
                color: textSecondary
              ),
            ),
          ],),
          const Spacer(),
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
              "금리",
              style: const TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.w600,
                color: textPrimary,
              ),
            ),
          ],),
          const SizedBox(width: 3.0,),
          IconButton(
            onPressed: (){}, 
            icon: const Icon(Icons.favorite, color: white, size: 32.0,),
          )
        ],),
      ),
    );
  }
}