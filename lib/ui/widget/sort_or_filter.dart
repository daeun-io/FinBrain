import 'package:finbrain/provider/sort_or_filter_provider.dart';
import 'package:finbrain/themes/colors.dart';
import 'package:finbrain/ui/product_categories.dart';
import 'package:finbrain/ui/widget/year_picker_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class SortOrFilterText extends ConsumerStatefulWidget {
  const SortOrFilterText({
    super.key,
    required this.category,
    required this.onSortCriteriaChanged,
  });

  final FilterTextCategory category;
  final Function(String) onSortCriteriaChanged;
  @override
  ConsumerState<SortOrFilterText> createState() => _FilterTextState();
}

class _FilterTextState extends ConsumerState<SortOrFilterText> {
  late int selectedYear;
  late List<int> years;
  late String text;

  @override
  void initState() {
    super.initState();
    selectedYear = DateTime.now().year;
    years =
        (List.generate(25, (index) => DateTime.now().year - index) +
              List.generate(25, (index) => DateTime.now().year + index))
          ..removeAt(0)
          ..sort();
  }

  @override
  Widget build(BuildContext context) {
    final filter = ref.watch(sortOrFilterTextNotifierProvider(widget.category));
    String selectedOption = (widget.category == FilterTextCategory.liked) ? (filter.$1 as List<String>).join(", "): filter.$1.toString();
    List<String> selectedOptions = (widget.category == FilterTextCategory.liked) ? filter.$1 as List<String> : [];
    String text = (widget.category == FilterTextCategory.isa)
        ? "$selectedYear 기준, $selectedOption"
        : selectedOption;

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
                      itemCount: filter.$2.length,
                      itemBuilder: (context, index) {
                        return Row(
                          children: [
                            Text(
                              filter.$2[index],
                              style: const TextStyle(fontSize: 16.0),
                            ),
                            const Spacer(),
                            if (widget.category == FilterTextCategory.liked)
                              IconButton(
                                onPressed: () {
                                  setModalState(() {
                                    if (index == 0) {
                                      selectedOptions = [filter.$2[0]];
                                    } else if (selectedOptions.contains(
                                      filter.$2[index],
                                    )) {
                                      selectedOptions.remove(
                                        filter.$2[index],
                                      );
                                    } else {
                                      selectedOptions.add(filter.$2[index]);
                                      selectedOptions.remove(filter.$2[0]);
                                    }
                                  });
                                  setState(() {
                                    text = "";
                                    for (final option in selectedOptions) {
                                      text = "$text $option,";
                                    }
                                    if (text.isNotEmpty) {
                                      widget.onSortCriteriaChanged(text);
                                    }
                                  });
                                  ref
                                      .read(
                                        sortOrFilterTextNotifierProvider(
                                          widget.category,
                                        ).notifier,
                                      )
                                      .changeCriteria(selectedOptions);
                                },
                                icon:
                                    (selectedOptions.contains(
                                      filter.$2[index],
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
                                    selectedOption = filter.$2[index];
                                  });
                                  setState(() {
                                    if (widget.category ==
                                        FilterTextCategory.isa) {
                                      text =
                                          "$selectedYear년 기준, ${filter.$2[index]}";
                                    } else {
                                      text = filter.$2[index];
                                    }
                                    if (text.isNotEmpty) {
                                      widget.onSortCriteriaChanged(text);
                                    }
                                  });
                                  ref
                                      .read(
                                        sortOrFilterTextNotifierProvider(
                                          widget.category,
                                        ).notifier,
                                      )
                                      .changeCriteria(selectedOption);
                                },

                                icon: (selectedOption == filter.$2[index])
                                    ? const Icon(
                                        Icons.radio_button_checked,
                                        size: 24.0,
                                        color: primary500,
                                      )
                                    : const Icon(
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
                                  const SizedBox(height: 16.0),
                                  SmoothPageIndicator(
                                    controller: pageController,
                                    count: 2,
                                    effect: ScrollingDotsEffect(
                                      spacing: 10.0,
                                      dotWidth: 8.0,
                                      dotHeight: 8.0,
                                      dotColor: primary300,
                                      activeDotColor: primary700,
                                    ),
                                  ),
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
