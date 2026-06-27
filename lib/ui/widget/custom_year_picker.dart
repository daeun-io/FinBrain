import 'package:finbrain/themes/colors.dart';
import 'package:flutter/material.dart';

class CustomYearPicker extends StatefulWidget {
  CustomYearPicker({Key? key, required this.selectedYear, required this.onYearChanged}) : super(key: key);

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
    yearList = List.generate(
      (thisYear - 2021 + 1),
      (index) => 2021 + index,
    );
    _scrollController = FixedExtentScrollController(initialItem: yearList.length - 1);
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: ListWheelScrollView.useDelegate(
        key: ValueKey(widget.selectedYear),
        controller: _scrollController,
        itemExtent: 30.0,
        physics: const FixedExtentScrollPhysics(),
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
                child: Card(
                  key: ValueKey('Selected: ${yearList[index]}'),
                  margin: EdgeInsets.zero,
                  color: primary100,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.all(Radius.circular(10.0)),
                  ),
                  child: Center(
                    child: Text(
                      "${yearList[index]}년",
                      style: const TextStyle(
                        color: black,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              );
            } else {
              return Center(
                key: ValueKey('Unselected: ${yearList[index]}'),
                child: Text(
                  "${yearList[index]}년",
                  style: const TextStyle(
                    color: textSecondary,
                    fontSize: 18.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
