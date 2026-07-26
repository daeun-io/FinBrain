import 'package:finbrain/ui/viewmodel/calculator_screen_viewmodel.dart';
import 'package:finbrain/product_categories.dart';
import 'package:finbrain/ui/widget/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class CalculatorScreen extends ConsumerStatefulWidget {
  const CalculatorScreen({
    super.key,
    required this.category,
    required this.mapOptions,
    required this.options,
  });

  final ProductCategory category;               // 상품 카테고리(product category)
  final Map<String, List<String>> mapOptions;   // 상품별 계산기를 위한 필드(field for categories)
  final List<Object> options;                   // 상품 옵션(financial product option)

  @override
  ConsumerState<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends ConsumerState<CalculatorScreen> {
  final _moneyController = TextEditingController();
  final _periodController = TextEditingController();
  final _moneyFocusNode = FocusNode();
  final _periodFocusNode = FocusNode();

  final formatter = NumberFormat("###,##0", "en_US");

  bool _isSubmitted = false;
  String _money = "";
  late String _period;
  final Map<String, String> _selectedValues = {};
  bool _isPrefSelected = false;
  late double _sliderValue;

  @override
  void initState() {
    super.initState();

    // 초기값을 각 옵션의 첫 값으로
    // Initial value is the first of each key
    if (widget.mapOptions.isNotEmpty) {
      widget.mapOptions.forEach((key, list) {
        _selectedValues[key] = list.first;
      });
    }
    // 예적금: 예치 기간에 해당하는 금리 반환, 대출: 최저, 평균, 최고 금리 반환
    // savings: return rate based on period, loan: return mininum, maximum and average rate
    final value = ref
        .read(calculatorScreenViewmodelProvider.notifier)
        .returnRate(widget.category, widget.options, _selectedValues);
    // 슬라이더의 초기값: 평균 금리
    // initial slider value: average rate
    _sliderValue = value.isNotEmpty ? value[1] : 0.0;
    // 예적금: 텍스트 필드 비활성화, 대출: 텍스트 필드 활성화
    // savings: enable text field, loan: disable text field
    _period =
        (widget.category == ProductCategory.deposit ||
            widget.category == ProductCategory.installment)
        ? "0"
        : "";
    
    _moneyFocusNode.addListener(() {
      // 포커스 됐다면 숫자만 표시, 포커스에서 벗어나면 숫자 포맷 + 원 붙이기
      // If focused, show digits only, else format number and add currency unit
      if (!_moneyFocusNode.hasFocus) {
        String textDigits = _moneyController.text.trim().replaceAll(
          RegExp(r'[^0-9]'),
          '',
        );
        int? strToNum = int.tryParse(textDigits);
        if (textDigits.isNotEmpty && strToNum != null) {
          String digits = formatter.format(strToNum);
          if (digits.isNotEmpty) {
            _moneyController.text = "$digits원";
          }
        }
      } else {
        String text = _moneyController.text.trim();
        String digits = text.replaceAll(RegExp(r'[^0-9]'), '');
        _moneyController.text = digits;
      }
    });

    // 포커스 됐다면 숫자만 표시, 포커스에서 벗어나면 "개월" 붙이기
    // If focused, show digits only, else add "month"
    _periodFocusNode.addListener(() {
      if (!_periodFocusNode.hasFocus) {
        String text = _periodController.text.trim();
        if (text.isNotEmpty) {
          if (!text.endsWith("개월")) {
            String digits = text.replaceAll(RegExp(r'[^0-9]'), '');
            if (digits.isNotEmpty) {
              _periodController.text = "$digits개월";
            }
          }
        }
      } else {
        String text = _periodController.text.trim();
        String digits = text.replaceAll(RegExp(r'[^0-9]'), '');
        _periodController.text = digits;
      }
    });
  }

  @override
  void dispose() {
    _moneyController.dispose();
    _moneyFocusNode.dispose();
    _periodController.dispose();
    _periodFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: CustomAppbar(screen: "calculator", title: ""),
      ),
      backgroundColor: colorScheme.primary,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 예치금 및 대출 원금 텍스트(balance or principal text)
                text(
                  switch (widget.category) {
                    (ProductCategory.deposit || ProductCategory.installment) =>
                      "예치금",
                    _ => "대출 원금",
                  },
                  colorScheme.onPrimary,
                  textTheme.bodyLarge!,
                ),
                const SizedBox(height: 2.0),
                // 예적금/대출에 따라 필드 디스플레이
                // display fields based on savings or loan
                ..._displayDynamicWidgetList(
                  widget.category,
                  widget.mapOptions,
                  ref
                      .read(calculatorScreenViewmodelProvider.notifier)
                      .returnRate(
                        widget.category,
                        widget.options,
                        _selectedValues,
                      ),
                ),
                const SizedBox(height: 32.0),
                // 리셋 및 계산 버튼(reset and calculate button)
                buttons(),
                // 계산 결과(calculated result)
                if (_isSubmitted)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 40.0),
                      text(
                        "계산 결과",
                        colorScheme.onPrimary,
                        textTheme.bodyLarge!,
                      ),
                      const SizedBox(height: 16.0),
                      _displayResult(
                        widget.category,
                        ref
                            .read(calculatorScreenViewmodelProvider.notifier)
                            .returnResult(
                              int.parse(_money),
                              (widget.category == ProductCategory.deposit ||
                                      widget.category ==
                                          ProductCategory.installment)
                                  ? ((_isPrefSelected)
                                        ? ref
                                              .read(
                                                calculatorScreenViewmodelProvider
                                                    .notifier,
                                              )
                                              .returnRate(
                                                widget.category,
                                                widget.options,
                                                _selectedValues,
                                              )
                                              .lastOrNull
                                        : ref
                                              .read(
                                                calculatorScreenViewmodelProvider
                                                    .notifier,
                                              )
                                              .returnRate(
                                                widget.category,
                                                widget.options,
                                                _selectedValues,
                                              )
                                              .firstOrNull)
                                  : _sliderValue,
                              switch (widget.category) {
                                ProductCategory.deposit => int.parse(
                                  _selectedValues[widget.mapOptions.keys.first]!
                                      .substring(
                                        0,
                                        _selectedValues[widget
                                                    .mapOptions
                                                    .keys
                                                    .first]!
                                                .length -
                                            2,
                                      ),
                                ),
                                ProductCategory.installment => int.parse(
                                  _selectedValues[widget.mapOptions.keys
                                          .toList()[1]]!
                                      .substring(
                                        0,
                                        _selectedValues[widget.mapOptions.keys
                                                    .toList()[1]]!
                                                .length -
                                            2,
                                      ),
                                ),
                                _ => int.parse(_period),
                              },
                              int.tryParse(_period),
                              switch (widget.category) {
                                ProductCategory.deposit =>
                                  _selectedValues[widget.mapOptions.keys.last]!,
                                ProductCategory.installment =>
                                  "${_selectedValues[widget.mapOptions.keys.last]!} ${_selectedValues[widget.mapOptions.keys.first]!}",
                                _ =>
                                  _selectedValues[widget
                                      .mapOptions
                                      .keys
                                      .first]!,
                              },
                              widget.category,
                              widget.options,
                              _selectedValues,
                            ),
                        int.parse(_period),
                        colorScheme,
                        textTheme,
                      ),
                      const SizedBox(height: 40.0),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _displayDynamicWidgetList(
    ProductCategory category,
    Map<String, List<String>> mapOptions,
    List<double> rates,
  ) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final keys = mapOptions.keys.toList();
    return [
      // 예치금 및 대출 원금 텍스트 필드(balance or principal text field)
      textField(
        _moneyController,
        _moneyFocusNode,
        (value) => setState(() {
          _money = value;
        }),
        () {
          if (_isSubmitted == true) {
            setState(() {
              _isSubmitted = false;
            });
          }
        },
      ),
      const SizedBox(height: 28.0),
      // 예치/대출 기간 및 상환 방법(대출)
      // period and method of repayment(loan)
      text(
        switch (category) {
          (ProductCategory.deposit || ProductCategory.installment) =>
            "예치 기간(개월)",
          _ => "상환 방법 및 대출 기간",
        },
        colorScheme.onPrimary,
        textTheme.bodyLarge!,
      ),
      const SizedBox(height: 2.0),
      // 예치 기간 드랍다운
      // saving period dropdown
      if (category == ProductCategory.deposit)
        dropdownCard(keys[0], mapOptions[keys[0]] ?? [], colorScheme, textTheme)
      else if (category == ProductCategory.installment)
        dropdownCard(keys[1], mapOptions[keys[1]] ?? [], colorScheme, textTheme)
      // 대출 상환 방법(드랍다운) 및 기간(텍스트 필드)
      // repayment method(dropdown) & period(text field)
      else
        Row(
          children: [
            Expanded(
              child: dropdownCard(
                keys[0],
                mapOptions[keys[0]] ?? [],
                colorScheme,
                textTheme,
              ),
            ),
            const SizedBox(width: 8.0),
            Expanded(
              child: textField(
                _periodController,
                _periodFocusNode,
                (value) => setState(() {
                  _period = value;
                }),
                () {
                  if (_isSubmitted == true) {
                    setState(() {
                      _isSubmitted = false;
                    });
                  }
                },
              ),
            ),
          ],
        ),
      const SizedBox(height: 32.0),
      // 금리(rate/interest)
      text(
        switch (category) {
          ProductCategory.deposit => "예치 금리",
          ProductCategory.installment => "예치 기간 및 종류",
          _ => "대출 금리",
        },
        colorScheme.onPrimary,
        textTheme.bodyLarge!,
      ),
      const SizedBox(height: 2.0),
      // 우대 조건 체크박스(preferential conditions checkbox)
      if (category == ProductCategory.deposit ||
          category == ProductCategory.installment) ...[
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
              width: 16.0,
              height: 16.0,
              child: Checkbox(
                value: _isPrefSelected,
                onChanged: (value) {
                  setState(() {
                    _isPrefSelected = value!;
                    if (_isSubmitted == true) {
                      _isSubmitted = false;
                    }
                  });
                },
                side: BorderSide(
                  color: colorScheme.surfaceContainerHighest,
                  width: 1.0,
                ),
                checkColor: colorScheme.onSurface,
                activeColor: colorScheme.surfaceDim,
              ),
            ),
            const SizedBox(width: 4.0),
            captionText(
              "우대 금리 적용",
            ),
          ],
        ),
        const SizedBox(height: 1.0),
        Row(
          children: [
            SizedBox(
              width: 100,
              child: dropdownCard(
                category == ProductCategory.deposit ? keys[1] : keys[2],
                category == ProductCategory.deposit
                    ? mapOptions[keys[1]] ?? []
                    : mapOptions[keys[2]] ?? [],
                colorScheme,
                textTheme,
              ),
            ),
            const SizedBox(width: 8.0),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: colorScheme.surfaceContainerHighest,
                  ),
                ),
                alignment: Alignment.centerRight,
                child: text(
                  (rates.isNotEmpty &&
                          _isPrefSelected == true &&
                          rates.last != -1.0)
                      ? rates.lastOrNull.toString()
                      : rates.firstOrNull.toString(),
                  colorScheme.onSecondary,
                  textTheme.bodyLarge!,
                ),
              ),
            ),
          ],
        ),
      ] else
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              (rates.firstOrNull ?? 0.0).toString(),
              style: textTheme.bodyMedium!.copyWith(
                color: colorScheme.onSecondary,
              ),
              textAlign: TextAlign.left,
            ),
            Expanded(
              child: SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  valueIndicatorTextStyle: TextStyle(
                    color: colorScheme.onSecondaryContainer,
                  ),
                  showValueIndicator: ShowValueIndicator.alwaysVisible,
                ),
                child: Slider(
                  divisions: null,
                  min: rates.firstOrNull ?? 0.0,
                  max: rates.lastOrNull ?? 20.0,
                  label: _sliderValue.toStringAsFixed(2),
                  value: _sliderValue,
                  onChanged: (value) {
                    setState(() {
                      _sliderValue = value;
                    });
                  },
                  activeColor: colorScheme.surfaceContainerHighest,
                  inactiveColor: colorScheme.surfaceBright,
                ),
              ),
            ),
            Text(
              (rates.lastOrNull ?? 20.0).toString(),
              style: textTheme.bodyMedium!.copyWith(
                color: colorScheme.onSecondary,
              ),
              textAlign: TextAlign.right,
            ),
          ],
        ),
    ];
  }

  Widget _displayResult(
    ProductCategory category,
    Map<String, dynamic> map,
    int? term,
    ColorScheme colorScheme,
    TextTheme textTheme,
  ) {
    // 결과가 없을 때(when no result)
    if (map.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: text(
            "계산 결과를 제공할 수 없습니다",
            colorScheme.onSecondary,
            textTheme.bodyLarge!,
          ),
        ),
      );
    }
    return (category == ProductCategory.mortgage ||
            category == ProductCategory.rent ||
            category == ProductCategory.credit)
        // 대출 계산 결과(loan calculation result)
        ? Column(
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Theme(
                  data: ThemeData(
                    useMaterial3: false,
                    dividerColor: colorScheme.outline,
                  ),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minWidth: MediaQuery.of(context).size.width,
                    ),
                    child: DataTable(
                      headingRowColor: WidgetStatePropertyAll(
                        colorScheme.secondary,
                      ),
                      headingRowHeight: 40.0,
                      dataRowColor: WidgetStatePropertyAll(colorScheme.surface),
                      columnSpacing: 36.0,
                      columns: [
                        ...map.keys.map(
                          (e) => DataColumn(
                            label: Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  text(
                                    e,
                                    colorScheme.onSecondary,
                                    textTheme.bodyLarge!,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                      rows: [
                        for (var i = 0; i < term!; i++)
                          DataRow(
                            cells: [
                              ...map.values.map(
                                (e) => DataCell(
                                  Center(
                                    child: text(
                                      "${formatter.format(e[i])}원",
                                      colorScheme.onSecondary,
                                      textTheme.bodyLarge!,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12.0),
              captionText(
                "*본 계산 결과는 매월 30일로 가정해 계산한 예상 금액이며, 실제 금액과 차이가 있을 수 있습니다. 정확한 금액은 해당 회사에 문의해주세요",
              ),
            ],
          )
        // 예적금 계산 결과(savings calculation result)
        : Column(
            children: [
              Table(
                border: TableBorder.all(color: colorScheme.outline, width: 1),
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                children: [
                  ...map.entries.map((e) {
                    return TableRow(
                      children: [
                        TableCell(
                          verticalAlignment: TableCellVerticalAlignment.middle,
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: colorScheme.secondary,
                              border: BoxBorder.all(color: colorScheme.outline),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Center(
                                child: text(
                                  e.key,
                                  colorScheme.onSecondary,
                                  textTheme.bodyLarge!,
                                ),
                              ),
                            ),
                          ),
                        ),
                        TableCell(
                          verticalAlignment: TableCellVerticalAlignment.middle,
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: colorScheme.surface,
                              border: BoxBorder.all(color: colorScheme.outline),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Center(
                                child: text(
                                  "${formatter.format(e.value)}원",
                                  colorScheme.onSecondary,
                                  textTheme.bodyLarge!,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }),
                ],
              ),
              const SizedBox(height: 12.0),
              captionText(
                "*본 계산 결과는 월을 기준으로 계산한 예상 금액이며, 실제 금액과 차이가 있을 수 있습니다. 정확한 금액은 해당 회사에 문의해주세요",
              ),
            ],
          );
  }

  // 리셋 및 계산 버튼(reset and calculate button)
  Widget buttons() {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          onPressed: () {
            _moneyController.clear();
            _periodController.clear();
            setState(() {
              _isSubmitted = false;
            });
          },
          style: TextButton.styleFrom(
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            minimumSize: Size.zero,
            padding: EdgeInsets.zero,
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(
              vertical: 12.0,
              horizontal: 20.0,
            ),
            decoration: BoxDecoration(
              color: colorScheme.secondary,
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            child: text("리셋", colorScheme.onPrimary, textTheme.bodyLarge!),
          ),
        ),
        const SizedBox(width: 12.0),
        TextButton(
          onPressed: () {
            setState(() {
              if (_money.trim().isEmpty || _period.trim().isEmpty) {
                if (!mounted) return;
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(snackbar("항목이 다 채워지지 않았습니다!\n모든 항목을 기입해주세요"));
                return;
              }
              if (int.tryParse(_money) == null ||
                  int.tryParse(_period) == null) {
                if (!mounted) return;
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(snackbar("입력값에 숫자 외 값이 있습니다!\n숫자만 입력해주세요"));
                return;
              }
              _isSubmitted = true;
            });
          },
          style: TextButton.styleFrom(
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            minimumSize: Size.zero,
            padding: EdgeInsets.zero,
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(
              vertical: 12.0,
              horizontal: 20.0,
            ),
            decoration: BoxDecoration(
              color: colorScheme.surfaceDim,
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            child: text("계산", colorScheme.onSurface, textTheme.bodyLarge!),
          ),
        ),
      ],
    );
  }

  // TableRow tableRow(
  //   String item,
  //   String value,
  //   Color headerColor,
  //   Color bodyColor,
  //   Color txtColor,
  //   TextStyle style,
  // ) {
  //   return TableRow(
  //     children: [
  //       Container(
  //         padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
  //         color: headerColor,
  //         child: text(item, txtColor, style),
  //       ),
  //       Container(
  //         padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
  //         color: bodyColor,
  //         child: text(value, txtColor, style),
  //       ),
  //     ],
  //   );
  // }

  Widget dropdownCard(
    String key,
    List<dynamic> items,
    ColorScheme colorScheme,
    TextTheme textTheme,
  ) {
    return Card(
      color: colorScheme.primary,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: colorScheme.surfaceContainerHighest,
          width: 1.0,
        ),
      ),
      child: ButtonTheme(
        alignedDropdown: true,
        child: DropdownButtonHideUnderline(
          child: DropdownButton(
            isExpanded: true,
            onTap: () {
              if (_isSubmitted == true) {
                setState(() {
                  _isSubmitted = false;
                });
              }
            },
            dropdownColor: colorScheme.primary,
            value: _selectedValues[key],
            items: [
              for (final item in items)
                DropdownMenuItem(
                  value: item,
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: text(
                      item,
                      colorScheme.onSecondary,
                      textTheme.bodyLarge!,
                    ),
                  ),
                ),
            ],
            onChanged: items.length == 1
                ? null
                : (value) {
                    setState(() {
                      if (value != null) {
                        _selectedValues[key] = value.toString();
                      }
                    });
                  },
          ),
        ),
      ),
    );
  }

  TextField textField(
    TextEditingController controller,
    FocusNode fNode,
    void Function(String) submitFunc,
    void Function() tapFunc,
  ) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return TextField(
      controller: controller,
      focusNode: fNode,
      onSubmitted: submitFunc,
      onTap: tapFunc,
      decoration: InputDecoration(
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: colorScheme.surfaceContainerHighest),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: colorScheme.surfaceContainerHighest),
        ),
        counterText: "",
        helperText: "숫자만 입력",
      ),
      style: textTheme.bodyMedium!.copyWith(color: colorScheme.onSecondary),
      textAlign: TextAlign.right,
      keyboardType: TextInputType.number,
    );
  }

  SnackBar snackbar(String text) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return SnackBar(
      backgroundColor: colorScheme.scrim,
      duration: const Duration(seconds: 3),
      content: Text(
        text,
        style: textTheme.bodySmall!.copyWith(color: colorScheme.onSecondary),
      ),
    );
  }

  Widget text(String text, Color color, TextStyle style) {
    return Text(text, style: style.copyWith(color: color));
  }

  Widget captionText(String text) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
   
    return Text(text, style: textTheme.bodySmall!.copyWith(color: colorScheme.onTertiary));
  }
}
