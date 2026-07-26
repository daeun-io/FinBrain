import 'package:finbrain/ui/viewmodel/text_theme_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 연도 선택 피커
// Year Picker
class CustomYearPicker extends ConsumerStatefulWidget {
  const CustomYearPicker({
    super.key,
    required this.selectedYear,
    required this.onYearChanged,
  });

  // 현재 선택된 년도
  // Currently selected year
  final int selectedYear;
  // 선택 년도 변경 시 실행할 함수
  // Funciton to be executed when selected year is changed   
  final ValueChanged<int> onYearChanged;
  @override
  ConsumerState<CustomYearPicker> createState() {
    return _YearPickerPageState();
  }
}

class _YearPickerPageState extends ConsumerState<CustomYearPicker> {
  final thisYear = DateTime.now().year;
  // 피커에서 선택된 년도
  // Selected year in picker
  late int _localSelected;
  late FixedExtentScrollController _scrollController;
  late List<int> yearList;

  @override
  void initState() {
    super.initState();
    // 받아온 년도를 피커에 적용
    // Apply selected year parameter to local
    _localSelected = widget.selectedYear;
    // 2021 - 올해(2021 - this year)
    yearList = List.generate((thisYear - 2021 + 1), (index) => 2021 + index);

    int initialIndex = yearList.indexOf(_localSelected);
    if (initialIndex == -1) initialIndex = yearList.length - 1;
    // 스크롤 컨트롤러 설정
    // Set scroll controller 
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
    final textTheme = ref.watch(textThemeViewmodelProvider);

    return SizedBox(
      height: 130,
      child: CupertinoPicker(
        scrollController: _scrollController,
        itemExtent: 50.0,
        squeeze: 0.95,
        diameterRatio: 2.0,
        // 선택 항목 오버레이
        selectionOverlay: Container(
          decoration: BoxDecoration(
            border: Border.symmetric(
              horizontal: BorderSide(color: colorScheme.onTertiary, width: 1.0),
            ),
          ),
        ),
        // 선택년도 변경 시 함수
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
