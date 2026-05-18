import 'package:finbrain/themes/colors.dart';
import 'package:flutter/material.dart';

class SearchBox extends StatefulWidget {
  const SearchBox({
    super.key,
    required this.searchItem,
    required this.searchedList,
  });

  final List<String> searchedList;
  final Function(String) searchItem;

  @override
  State<SearchBox> createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> {
  @override
  Widget build(BuildContext context) {
    return SearchAnchor(
      viewOnSubmitted: (value) {
        widget.searchItem(value);
        Navigator.pop(context);
      },
      builder: (context, controller) {
        return SearchBar(
          onTap: () => controller.openView(),
          padding: const WidgetStatePropertyAll(
            EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
          ),
          trailing: [const Icon(Icons.search, size: 24, color: textPrimary)],
          controller: controller,
          backgroundColor: const WidgetStatePropertyAll(primary100),
          shape: const WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadiusGeometry.all(Radius.circular(10.0)),
            ),
          ),
          elevation: const WidgetStatePropertyAll(0.0),
          textStyle: const WidgetStatePropertyAll(
            TextStyle(
              color: textPrimary,
              fontSize: 12.0,
              fontWeight: FontWeight.w400,
            ),
          ),
          hintText: "상품명 검색",
          hintStyle: const WidgetStatePropertyAll(
            TextStyle(
              color: textSecondary,
              fontSize: 12.0,
              fontWeight: FontWeight.w400,
            ),
          ),
        );
      },
      suggestionsBuilder: (context, controller) {
        return List.generate(widget.searchedList.length, (int index) {
          return ListTile(
            title: Text(
              widget.searchedList[index],
              style: const TextStyle(
                color: textPrimary,
                fontSize: 14.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            onTap: () {
              setState(() {
                controller.closeView(widget.searchedList[index]);
              });
            },
          );
        });
      },
      viewBackgroundColor: white,
    );
  }
}
