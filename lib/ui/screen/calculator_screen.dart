import 'package:finbrain/ui/viewModel/text_theme_viewmodel.dart';
import 'package:finbrain/ui/viewmodel/calculator_screen_viewmodel.dart';
import 'package:finbrain/product_categories.dart';
import 'package:finbrain/ui/widget/custom_appbar.dart';
import 'package:finbrain/ui/widget/custom_snack_bar.dart';
import 'package:finbrain/ui/widget/custom_text.dart';
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

  String _money = "";                          // 원금(principal)
  late String _period;                         // 기간(period)
  late double _sliderValue;                    // 대출 금리(discount rate)
  final Map<String, String> _selectedValues = {};

  bool _isSubmitted = false;
  bool _isPrefSelected = false;
  bool _isHelpSelected = false;

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

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: CustomAppbar(screen: "calculator", title: ""),
      ),
      backgroundColor: colorScheme.primary,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    icon: Icon(
                      (_isHelpSelected) ? Icons.close : Icons.help_outline,
                      size: 24,
                      color: colorScheme.surfaceContainerHighest,
                    ),
                    onPressed: () {
                      setState(() {
                        _isHelpSelected = !_isHelpSelected;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 8.0),
                Stack(
                  children: [
                    MainCalculationScreen(ref),
                    if (_isHelpSelected) HelpScreen(ref),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Column MainCalculationScreen(WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = ref.watch(textThemeViewmodelProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 예치금 및 대출 원금 텍스트(balance or principal text)
        CustomText(
          text: switch (widget.category) {
            ProductCategory.deposit => "예치금",
            ProductCategory.installment => "월 불입액",
            _ => "대출 원금",
          },
          style: textTheme.bodyLarge!.copyWith(color: colorScheme.onPrimary)
        ),
        const SizedBox(height: 2.0),
        // 예적금/대출에 따라 필드 디스플레이
        // display fields based on savings or loan
        ..._displayDynamicWidgetList(
          widget.category,
          widget.mapOptions,
          ref
              .read(calculatorScreenViewmodelProvider.notifier)
              .returnRate(widget.category, widget.options, _selectedValues),
          textTheme,
        ),
        const SizedBox(height: 32.0),
        // 리셋 및 계산 버튼(reset and calculate button)
        Buttons(textTheme),
        // 계산 결과(calculated result)
        if (_isSubmitted)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40.0),
              CustomText(
                text: "계산 결과", 
                style: textTheme.bodyLarge!.copyWith(color: colorScheme.onPrimary)
              ),
              const SizedBox(height: 16.0),
              CalculationResult(
                // 상품 카테고리(product category)
                widget.category,
                // 계산 결과(result)
                ref
                    .read(calculatorScreenViewmodelProvider.notifier)
                    .returnResult(
                      // principal
                      int.parse(_money),
                      // rate(interest)
                      (widget.category == ProductCategory.deposit ||
                              widget.category == ProductCategory.installment)
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
                      // term(period)
                      switch (widget.category) {
                        ProductCategory.deposit => int.parse(
                          _selectedValues[widget.mapOptions.keys.first]!
                              .substring(
                                0,
                                _selectedValues[widget.mapOptions.keys.first]!
                                        .length -
                                    2,
                              ),
                        ),
                        ProductCategory.installment => int.parse(
                          _selectedValues[widget.mapOptions.keys.toList()[1]]!
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
                      // interest type
                      switch (widget.category) {
                        ProductCategory.deposit =>
                          _selectedValues[widget.mapOptions.keys.last]!,
                        ProductCategory.installment =>
                          "${_selectedValues[widget.mapOptions.keys.last]!} ${_selectedValues[widget.mapOptions.keys.first]!}",
                        _ => _selectedValues[widget.mapOptions.keys.first]!,
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
    );
  }

  Widget HelpScreen(WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = ref.watch(textThemeViewmodelProvider);

    return Container(
      color: colorScheme.primary.withOpacity(0.6),
      height: MediaQuery.of(context).size.height * 0.8,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 예치금 및 대출 원금 텍스트(balance or principal text)
          const SizedBox(height: 28),
          WordCard(switch (widget.category) {
            ProductCategory.deposit => "예치금: 정기예금을 위해 은행에 맡겨둔 금액",
            ProductCategory.installment =>
              "월 불입액: 적금 상품 가입 시 매월 납부하는 금액\n자유적립식이어도 매월 동일한 금액을 납부한다고 가정",
            _ => "대출 원금: 금융회사에 대출한 금액",
          }, textTheme.bodyMedium!.copyWith(color: colorScheme.onSecondary,)),
          SizedBox(height: (widget.category == ProductCategory.installment) ? 70 : 80),
          WordCard(switch (widget.category) {
            (ProductCategory.deposit || ProductCategory.installment) =>
              "기간: 예적금 상품 가입 기간",
            _ =>
              """
* 상환 방법 *

원리금균등상환: 대출 원금과 이자를 합한 금액을 매월 동일하게 갚는 방식
원금균등상환: 대출 원금을 매월 동일하게 나누어 갚고, 남은 원금에 대한 이자를 함께 갚는 방식
만기일시상환: 대출 기간 동안 이자만 납부하다 대출 만기일에 원금 전액을 한 번에 갚는 방식
""",
          }, textTheme.bodyMedium!.copyWith(color: colorScheme.onSecondary,)),
          SizedBox(height: (widget.category == ProductCategory.deposit || widget.category == ProductCategory.installment)? 80 : 4),
          WordCard(switch (widget.category) {
            (ProductCategory.deposit || ProductCategory.installment) =>
              "금리: 예적금 상품에 붙는 이자 또는 비율, 1년 단위로 계산",
            _ => "기간: 돈을 빌린 날부터 만기일까지의 전체 기간",
          }, textTheme.bodyMedium!.copyWith(color: colorScheme.onSecondary,)),
          if (widget.category == ProductCategory.deposit ||
              widget.category == ProductCategory.installment)
            ... [ 
              const SizedBox(height: 4,),
              WordCard(
              "단리: 원금에 대해서만 일정한 비율의 이자가 붙는 방식\n복리: 원금뿐 아니라 이전에 쌓인 기간에도 다시 이자가 붙는 방식 ",
              textTheme.bodyMedium!.copyWith(color: colorScheme.onSecondary,),
            ), ]
        ],
      ),
    );
  }

  List<Widget> _displayDynamicWidgetList(
    ProductCategory category,
    Map<String, List<String>> mapOptions,
    List<double> rates,
    TextTheme textTheme,
  ) {
    final colorScheme = Theme.of(context).colorScheme;

    final keys = mapOptions.keys.toList();
    return [
      // 예치금 및 대출 원금 텍스트 필드(balance or principal text field)
      CustomTextField(
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
      const SizedBox(height: 16.0),
      // 예치/대출 기간 및 상환 방법(대출)
      // period and method of repayment(loan)
      CustomText(
        text: switch (category) {
          (ProductCategory.deposit || ProductCategory.installment) => "기간(개월)",
          _ => "상환 방법 및 대출 기간(개월)",
        },
        style: textTheme.bodyLarge!.copyWith(color: colorScheme.onPrimary)
      ),
      const SizedBox(height: 2.0),
      // 예치 기간 드랍다운
      // saving period dropdown
      if (category == ProductCategory.deposit)
        DropdownCard(keys[0], mapOptions[keys[0]] ?? [], colorScheme, textTheme)
      else if (category == ProductCategory.installment)
        DropdownCard(keys[1], mapOptions[keys[1]] ?? [], colorScheme, textTheme)
      // 대출 상환 방법(드랍다운) 및 기간(텍스트 필드)
      // repayment method(dropdown) & period(text field)
      else
        Row(
          children: [
            Expanded(
              child: DropdownCard(
                keys[0],
                mapOptions[keys[0]] ?? [],
                colorScheme,
                textTheme,
              ),
            ),
            const SizedBox(width: 8.0),
            Expanded(
              child: CustomTextField(
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
      CustomText(
        text: switch (category) {
          ProductCategory.deposit => "예금 금리",
          ProductCategory.installment => "적금 금리",
          _ => "대출 금리",
        },
        style: textTheme.bodyLarge!.copyWith(color: colorScheme.onPrimary),
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
                checkColor: colorScheme.onSecondaryContainer,
                activeColor: colorScheme.surfaceContainerHighest,
              ),
            ),
            const SizedBox(width: 4.0),
            CustomText(
              text: "우대 금리 적용",
              style: textTheme.bodySmall!.copyWith(color: colorScheme.onTertiary,),
            ),
          ],
        ),
        const SizedBox(height: 1.0),
        Row(
          children: [
            SizedBox(
              width: 100,
              child: DropdownCard(
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
                child: CustomText(
                  text: (rates.isNotEmpty &&
                          _isPrefSelected == true &&
                          rates.last != -1.0)
                      ? rates.lastOrNull.toString()
                      : rates.firstOrNull.toString(),
                  style: textTheme.bodyLarge!.copyWith(color: colorScheme.onSecondary),
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
                  divisions: _isHelpSelected ? null : 100,
                  min: rates.firstOrNull ?? 0.0,
                  max: rates.lastOrNull ?? 20.0,
                  label: _isHelpSelected ? null : _sliderValue.toStringAsFixed(2),
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

  Widget CalculationResult(
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
          child: CustomText(
            text: "계산 결과를 제공할 수 없습니다",
            style: textTheme.bodyLarge!.copyWith(color: colorScheme.onSecondary),
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
                                  CustomText(
                                    text: e,
                                    style: textTheme.bodyLarge!.copyWith(color: colorScheme.onSecondary,),
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
                              ...map.entries.map(
                                (e) => DataCell(
                                  Center(
                                    child: CustomText(
                                      text: (e.key == "회차")
                                          ? e.value[i].toString()
                                          : "${formatter.format(e.value[i])}원",
                                      style: textTheme.bodyLarge!.copyWith(color: colorScheme.onSecondary,),
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
              CustomText(
                text: "*본 계산 결과는 매월 30일로 가정해 계산한 예상 금액이며, 실제 금액과 차이가 있을 수 있습니다. 정확한 금액은 해당 회사에 문의해주세요",
                style: textTheme.bodySmall!.copyWith(color: colorScheme.onTertiary),
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
                                child: CustomText(
                                  text: e.key,
                                  style: textTheme.bodyLarge!.copyWith(color: colorScheme.onSecondary,),
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
                                child: CustomText(
                                  text: "${formatter.format(e.value)}원",
                                  style: textTheme.bodyLarge!.copyWith(color: colorScheme.onSecondary,),
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
              CustomText(
                text: "*본 계산 결과는 월을 기준으로 계산한 예상 금액이며, 실제 금액과 차이가 있을 수 있습니다. 정확한 금액은 해당 회사에 문의해주세요",
                style: textTheme.bodySmall!.copyWith(color: colorScheme.onTertiary,),
              ),
            ],
          );
  }

  // 리셋 및 계산 버튼(reset and calculate button)
  Widget Buttons(TextTheme textTheme) {
    final colorScheme = Theme.of(context).colorScheme;
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
            child: CustomText(
              text: "리셋", 
              style: textTheme.bodyLarge!.copyWith(color: colorScheme.onPrimary,)
            ),
          ),
        ),
        const SizedBox(width: 12.0),
        TextButton(
          onPressed: () {
            setState(() {
              if (_money.trim().isEmpty || _period.trim().isEmpty) {
                if (!mounted) return;
                CustomSnackBar.show(context, ref, text: "항목이 다 채워지지 않았습니다!\n모든 항목을 기입해주세요");
                return;
              }
              if (int.tryParse(_money) == null ||
                  int.tryParse(_period) == null) {
                if (!mounted) return;
                CustomSnackBar.show(context, ref, text: "입력값에 숫자 외 값이 있습니다!\n숫자만 입력해주세요");
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
              color: colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            child: CustomText(
              text: "계산", 
              style: textTheme.titleLarge!.copyWith(color: colorScheme.onSecondaryContainer)
            ),
          ),
        ),
      ],
    );
  }

  Widget DropdownCard(
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
                    child: CustomText(
                      text: item,
                      style: textTheme.bodyLarge!.copyWith(color: colorScheme.onSecondary,)
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

  TextField CustomTextField(
    TextEditingController controller,
    FocusNode fNode,
    void Function(String) onChangedFunc,
    void Function() tapFunc,
  ) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return TextField(
      controller: controller,
      focusNode: fNode,
      onChanged: onChangedFunc,
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

  Widget WordCard(String word, TextStyle style) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        color: colorScheme.secondary,
        border: Border.all(color: colorScheme.outline),
        borderRadius: BorderRadius.circular(10.0),
      ),
      padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      child: CustomText(text: word, style: style),
    );
  }
}
