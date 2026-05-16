import 'package:finbrain/themes/colors.dart';
import 'package:flutter/material.dart';

class YearPickerPage extends StatefulWidget {
  YearPickerPage({
    Key? key,
    required this.selectedYear,
    required this.yearsList,
    required this.onYearChanged,
  }): super(key: key);
  
  final int selectedYear;
  final List<int> yearsList;
  final ValueChanged onYearChanged;

  @override
  State<YearPickerPage> createState() {
    return _YearPickerPageState();
  }
}

class _YearPickerPageState extends State<YearPickerPage> {
  late int _localSelected;
  late FixedExtentScrollController _scrollController;
  
  @override
  void initState() {
    super.initState();
    _localSelected = widget.selectedYear;
    int initialIndex = widget.yearsList.indexOf(_localSelected);
    _scrollController = FixedExtentScrollController(
      initialItem: initialIndex
    );
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return ListWheelScrollView.useDelegate(
      key: ValueKey(widget.selectedYear),
      controller: _scrollController,
      itemExtent: 50.0,
      physics: const FixedExtentScrollPhysics(),
      onSelectedItemChanged: (value) {
        setState(() {
          _localSelected = widget.yearsList[value];
        });
        widget.onYearChanged(_localSelected);
      },
      childDelegate: ListWheelChildBuilderDelegate(
        childCount: widget.yearsList.length,
        builder: (context, index) {
          if (widget.yearsList[index] == _localSelected) {
            return SizedBox(
              width: double.infinity,
              child: Card(
                key: ValueKey('Selected: ${widget.yearsList[index]}'),
                color: primary300,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.all(Radius.circular(10.0)),
                ),
                child: Center(
                  child: Text(
                    "${widget.yearsList[index]}년",
                    style: const TextStyle(
                      color: black,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            );
          } else {
            return Center(
              key: ValueKey('Unselected: ${widget.yearsList[index]}'),
              child: Text(
                "${widget.yearsList[index]}년",
                style: const TextStyle(
                  color: black,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
