import 'package:finbrain/themes/colors.dart';
import 'package:flutter/material.dart';

class SearchBox extends StatelessWidget{
  SearchBox({super.key});
  
  final _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        color: primary100,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _searchController,
                onSubmitted: (value){},
                decoration: const InputDecoration(
                  hintText: "상품명 검색",
                  hintStyle: TextStyle(
                    color: textSecondary,
                    fontSize: 12.0,
                    fontWeight: FontWeight.w400
                  ),
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  isDense: true,
                  contentPadding: EdgeInsets.zero
                ),
              ),
            ),
            IconButton(
              onPressed: (){},
              icon: Icon(Icons.search, size: 24, color: textPrimary,)
            )
          ],
        )
      )
    );
  }
}