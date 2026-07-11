import 'package:finbrain/themes/text_style.dart';
import 'package:flutter/material.dart';

class CustomYearPicker extends StatefulWidget {
  const CustomYearPicker({
    super.key,
    required this.selectedYear,
    required this.onYearChanged,
  });

  final int selectedYear;
  final ValueChanged onYearChanged;

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
    _scrollController = FixedExtentScrollController(
      initialItem: yearList.length - 1,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SizedBox(
      height: 150,
      child: ListWheelScrollView.useDelegate(
        key: ValueKey(widget.selectedYear),
        controller: _scrollController,
        itemExtent: 42.0,
        physics: const BouncingScrollPhysics(
          parent: FixedExtentScrollPhysics(),
        ),
        clipBehavior: Clip.none,
        diameterRatio: 1.5,
        perspective: 0.003,
        onSelectedItemChanged: (value) {
          setState(() {
            _localSelected = yearList[value];
          });
          widget.onYearChanged(_localSelected);
        },
        childDelegate: ListWheelChildBuilderDelegate(
          childCount: yearList.length,
          builder: (context, index) {
            if (yearList[index] == _localSelected) {
              return SizedBox(
                width: double.infinity,
                child: Container(
                  key: ValueKey('Selected: ${yearList[index]}'),
                  margin: EdgeInsets.zero,
                  decoration: BoxDecoration(
                    border: BoxBorder.symmetric(horizontal: BorderSide(color: colorScheme.onTertiary))
                  ),
                  child: Center(
                    child: Text(
                      "${yearList[index]}년",
                      style: bodySbLg.copyWith(color: colorScheme.onSecondary),
                    ),
                  ),
                ),
              );
            } else {
              return Center(
                key: ValueKey('Unselected: ${yearList[index]}'),
                child: Text(
                  "${yearList[index]}년",
                  style: bodySbLg.copyWith(color: colorScheme.onTertiary),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
