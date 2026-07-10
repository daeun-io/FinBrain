import 'package:finbrain/ui/viewmodel/sort_or_filter_viewmodel.dart';
import 'package:finbrain/product_categories.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SortOrFilterText extends ConsumerStatefulWidget {
  const SortOrFilterText({
    super.key,
    required this.category,
    required this.onSortCriteriaChanged,
  });

  final ProductCategory category;
  final Function(String) onSortCriteriaChanged;
  @override
  ConsumerState<SortOrFilterText> createState() => _FilterTextState();
}

class _FilterTextState extends ConsumerState<SortOrFilterText> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final filter = ref.watch(
      sortOrFilterTextViewModelProvider(widget.category),
    );
    String selectedOption = switch (widget.category) {
      ProductCategory.liked => (filter.$1 as List<String>).join(", "),
      _ => filter.$1.toString(),
    };
    List<String> selectedOptions = (widget.category == ProductCategory.liked)
        ? filter.$1 as List<String>
        : [];
    String text = selectedOption;

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Flexible(
          child: Text(
            text,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: colorScheme.onSecondary,
              fontSize: 14.0,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        IconButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              backgroundColor: colorScheme.surfaceContainer,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
              ),
              builder: (BuildContext context) {
                return StatefulBuilder(
                  builder: (BuildContext context, StateSetter setModalState) {
                    Widget optionView = ListView.builder(
                      itemCount: filter.$2.length,
                      itemBuilder: (context, index) {
                        return Row(
                          children: [
                            Text(
                              filter.$2[index],
                              style: TextStyle(color: colorScheme.onSecondary,fontSize: 16.0),
                            ),
                            const Spacer(),
                            if (widget.category == ProductCategory.liked)
                              IconButton(
                                onPressed: () {
                                  setModalState(() {
                                    if (index == 0) {
                                      selectedOptions = [filter.$2[0]];
                                    } else if (selectedOptions.contains(
                                      filter.$2[index],
                                    )) {
                                      selectedOptions.remove(filter.$2[index]);
                                      if (selectedOptions.isEmpty) {
                                        selectedOptions = [filter.$2[0]];
                                      }
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
                                        sortOrFilterTextViewModelProvider(
                                          widget.category,
                                        ).notifier,
                                      )
                                      .changeCriteria(selectedOptions);
                                },
                                icon:
                                    (selectedOptions.contains(filter.$2[index]))
                                    ? Icon(
                                        Icons.check_circle,
                                        size: 24.0,
                                        color: colorScheme.onTertiaryFixed,
                                      )
                                    : Icon(
                                        Icons.circle_outlined,
                                        size: 24.0,
                                        color: colorScheme.outline,
                                      ),
                              )
                            else
                              IconButton(
                                onPressed: () {
                                  setModalState(() {
                                    selectedOption = filter.$2[index];
                                  });
                                  setState(() {
                                    text = filter.$2[index];
                                    if (selectedOption.isNotEmpty) {
                                      widget.onSortCriteriaChanged(
                                        selectedOption,
                                      );
                                    }
                                  });
                                  ref
                                      .read(
                                        sortOrFilterTextViewModelProvider(
                                          widget.category,
                                        ).notifier,
                                      )
                                      .changeCriteria(selectedOption);
                                },
                                icon: (selectedOption == filter.$2[index])
                                    ? Icon(
                                        Icons.radio_button_checked,
                                        size: 24.0,
                                        color: colorScheme.onTertiaryFixed,
                                      )
                                    : Icon(
                                        Icons.circle_outlined,
                                        size: 24.0,
                                        color: colorScheme.outline,
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
                            (widget.category == ProductCategory.liked)
                                ? "선택 상품"
                                : "정렬 기준",
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.w600,
                              color: colorScheme.onPrimary,
                            ),
                          ),
                          const SizedBox(height: 28.0),
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
          icon: Icon(Icons.keyboard_arrow_down, size: 24, color: colorScheme.onSecondary,),
        ),
      ],
    );
  }
}
