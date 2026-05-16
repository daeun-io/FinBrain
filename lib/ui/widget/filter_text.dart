import 'package:finbrain/themes/colors.dart';
import 'package:finbrain/ui/product_categories.dart';
import 'package:finbrain/ui/widget/year_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class FilterText extends StatefulWidget {
  const FilterText({super.key, required this.category});

  final FilterTextCategory category;

  @override
  State<FilterText> createState() => _FilterTextState();
}

class _FilterTextState extends State<FilterText> {
  late List<String> optionList;
  late String selectedOption;
  late List<String> selectedOptions;
  late int selectedYear;
  late List<int> years;
  late String text;

  @override
  void initState() {
    super.initState();

    optionList = switch (widget.category) {
      FilterTextCategory.savings => ["최고 금리", "기본 금리"],
      FilterTextCategory.loan => ["최저 금리", "최고 금리", "평균 금리"],
      FilterTextCategory.annuity => [
        "평균 수익률",
        "전년도 수익률",
        "전전년도 수익률",
        "전전전년도 수익률",
      ],
      FilterTextCategory.isa => ["최신순", "오래된 순"],
      FilterTextCategory.liked => [
        "모든 상품",
        "정기예금",
        "적금",
        "ISA",
        "주택담보대출",
        "전세자금대출",
        "개인신용대출",
        "연금 저축",
      ],
    };

    selectedOption = optionList[0];
    selectedOptions = [optionList[0]];

    selectedYear = DateTime.now().year;
    years =
        (List.generate(25, (index) => DateTime.now().year - index) +
              List.generate(25, (index) => DateTime.now().year + index))
          ..removeAt(0)
          ..sort();

    text = switch (widget.category) {
      FilterTextCategory.savings => "최고 금리",
      FilterTextCategory.loan => "최저 금리",
      FilterTextCategory.annuity => "평균 수익률",
      FilterTextCategory.isa => "$selectedYear년 기준, 최신순",
      FilterTextCategory.liked => "모든 상품"
    };
  }
  
  @override
  Widget build(BuildContext context) {

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Flexible(
          child: Text(
            text,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 14.0, fontWeight: FontWeight.w400),
          ),
        ),
        IconButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              backgroundColor: Colors.white,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
              ),
              builder: (BuildContext context) {
                return StatefulBuilder(
                  builder: (BuildContext context, StateSetter setModalState) {
                    final pageController = PageController();

                    Widget optionView = ListView.builder(
                      itemCount: optionList.length,
                      itemBuilder: (context, index) {
                        return Row(
                          children: [
                            Text(
                              optionList[index],
                              style: const TextStyle(fontSize: 16.0),
                            ),
                            const Spacer(),
                            if (widget.category == FilterTextCategory.liked)
                              IconButton(
                                onPressed: () {
                                  // selecedOption 변경되는 지 확인
                                  setModalState(() {
                                    if (index == 0) {
                                      selectedOptions = [optionList[0]];
                                    } else if (selectedOptions.contains(
                                      optionList[index],
                                    )) {
                                      selectedOptions.remove(optionList[index]);
                                    } else {
                                      selectedOptions.add(optionList[index]);
                                      selectedOptions.remove(optionList[0]);
                                    }
                                  });
                                  setState(() {
                                    text = "";
                                    for(final option in selectedOptions){
                                      text = "$text $option,";
                                    }
                                  });
                                },
                                icon:
                                    (selectedOptions.contains(
                                      optionList[index],
                                    ))
                                    ? const Icon(
                                        Icons.check_circle,
                                        size: 24.0,
                                        color: primary500,
                                      )
                                    : const Icon(
                                        Icons.circle_outlined,
                                        size: 24.0,
                                        color: primary300,
                                      ),
                              )
                            else
                              IconButton(
                                onPressed: () {
                                  setModalState(() {
                                    selectedOption = optionList[index];
                                  });
                                  setState(() {
                                    if(widget.category == FilterTextCategory.isa){
                                      text = "$selectedYear년 기준, ${optionList[index]}";
                                    }else{
                                      text = optionList[index];
                                    }
                                  });
                                },
                                icon: (selectedOption == optionList[index])
                                    ? SvgPicture.asset(
                                        "assets/images/radio_button.svg",
                                      )
                                    : Icon(
                                        Icons.circle_outlined,
                                        size: 24.0,
                                        color: primary300,
                                      ),
                              ),
                          ],
                        );
                      },
                    );

                    return Container(
                      height: 300,
                      padding: const EdgeInsets.symmetric(
                        vertical: 20.0,
                        horizontal: 32.0,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            (widget.category == FilterTextCategory.liked)
                                ? "선택 상품"
                                : "정렬 기준",
                            style: const TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.w600,
                              color: textPrimary,
                            ),
                          ),
                          const SizedBox(height: 28.0),
                          if (widget.category == FilterTextCategory.isa)
                            Expanded(
                              child: Column(
                                children: [
                                  Expanded(
                                    child: PageView(
                                      controller: pageController,
                                      children: [
                                        YearPickerPage(
                                          selectedYear: selectedYear,
                                          yearsList: years,
                                          onYearChanged: (value) {
                                            selectedYear = value;
                                          },
                                        ),
                                        optionView,
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 16.0,),
                                  SmoothPageIndicator(
                                    controller: pageController, 
                                    count: 2,
                                    effect: ScrollingDotsEffect(
                                      spacing: 10.0,
                                      dotWidth: 8.0,
                                      dotHeight: 8.0,
                                      dotColor: primary300,
                                      activeDotColor: primary700
                                    ),
                                  )
                                ],
                              ),
                            )
                          else
                            Expanded(child: optionView),
                        ],
                      ),
                    );
                  },
                );
              },
            );
          },
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
          visualDensity: VisualDensity.compact,
          icon: const Icon(Icons.keyboard_arrow_down, size: 24),
        ),
      ],
    );
  }
}