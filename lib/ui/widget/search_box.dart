import 'package:flutter/material.dart';

class SearchBox extends StatefulWidget {
  const SearchBox({
    super.key,
    required this.searchItem,
  });

  final Function(String) searchItem;

  @override
  State<SearchBox> createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return SearchBar(
      onSubmitted: ((value) => widget.searchItem(value)),
      onChanged: (value) {
        if (value.isEmpty) widget.searchItem(value);
      },
      padding: const WidgetStatePropertyAll(
        EdgeInsets.symmetric(vertical: 2.0, horizontal: 12.0),
      ),
      trailing: [Icon(Icons.search, size: 28, color: colorScheme.outlineVariant)],
      backgroundColor: WidgetStatePropertyAll(colorScheme.tertiary),
      side: WidgetStatePropertyAll(BorderSide(color: colorScheme.outlineVariant, width: 1)),
      shape: const WidgetStatePropertyAll(
        RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.all(Radius.circular(30.0)),
        ),
      ),
      elevation: const WidgetStatePropertyAll(0.0),
      textStyle: WidgetStatePropertyAll(
        textTheme.bodyMedium!.copyWith(color: colorScheme.onPrimary)
      ),
      hintText: "상품명 검색",
      hintStyle: WidgetStatePropertyAll(
        textTheme.bodyMedium!.copyWith(color: colorScheme.onTertiary)
      ),
    );
  }
}
