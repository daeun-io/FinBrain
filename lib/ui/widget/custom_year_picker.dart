import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomYearPicker extends StatefulWidget {
  const CustomYearPicker({
    super.key,
    required this.selectedYear,
    required this.onYearChanged,
  });

  final int selectedYear;
  final ValueChanged<int> onYearChanged;

  @override
  State<CustomYearPicker> createState() {
    return _YearPickerPageState();
  }
}

class _YearPickerPageState extends State<CustomYearPicker> {
  final thisYear = DateTime.now().year;
  late int _localSelected;
  late FixedExtentScrollController _scrollController;
  late List<int> yearList;

  @override
  void initState() {
    super.initState();
    _localSelected = widget.selectedYear;
    yearList = List.generate((thisYear - 2021 + 1), (index) => 2021 + index);
    int initialIndex = yearList.indexOf(_localSelected);
    if (initialIndex == -1) initialIndex = yearList.length - 1;
    _scrollController = FixedExtentScrollController(initialItem: initialIndex);
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return SizedBox(
      height: 130,
      child: CupertinoPicker(
        scrollController: _scrollController,
        itemExtent: 42.0,
        diameterRatio: 1.5,
        selectionOverlay: Container(
          decoration: BoxDecoration(
            border: Border.symmetric(
              horizontal: BorderSide(color: colorScheme.onTertiary, width: 1.0),
            ),
          ),
        ),
        onSelectedItemChanged: (value) {
          setState(() {
            _localSelected = yearList[value];
          });
          widget.onYearChanged(_localSelected);
        },
        children: yearList.map((year) {
          final isSelected = year == _localSelected;
          return Center(
            child: Text(
              "$year년",
              style: (isSelected)
                  ? textTheme.titleLarge!.copyWith(
                      color: colorScheme.onSecondary,
                    )
                  : textTheme.bodyLarge!.copyWith(
                      color: colorScheme.onTertiary,
                    ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
