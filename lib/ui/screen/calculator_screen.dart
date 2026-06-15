import 'package:finbrain/data/viewModel/calculator_screen_viewmodel.dart';
import 'package:finbrain/themes/colors.dart';
import 'package:finbrain/ui/product_categories.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CalculatorScreen extends ConsumerStatefulWidget {
  const CalculatorScreen({
    super.key,
    required this.category,
    required this.mapOptions,
    required this.options,
  });

  final ProductCategory category;
  final Map<String, List<String>> mapOptions;
  final List<Object> options;

  @override
  ConsumerState<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends ConsumerState<CalculatorScreen> {
  final _moneyController = TextEditingController();
  final _periodController = TextEditingController();

  bool _isSubmitted = false;
  late String _money;
  late String _period;
  final Map<String, String> _selectedValues = {};
  bool _isPrefSelected = false;
  late double _sliderValue;

  @override
  void initState() {
    super.initState();

    if (widget.mapOptions.isNotEmpty) {
      widget.mapOptions.forEach((key, list) {
        _selectedValues[key] = list.first;
      });
    }
    final value = ref
        .read(calculatorScreenViewmodelProvider.notifier)
        .returnRate(widget.category, widget.options, _selectedValues);
    _sliderValue = value.isNotEmpty ? value[1] : 0.0;
    _money = (widget.category == ProductCategory.annuity) ? "0" : "";
    _period =
        (widget.category == ProductCategory.deposit ||
            widget.category == ProductCategory.annuity ||
            (widget.category == ProductCategory.installment &&
                _selectedValues[widget.mapOptions.keys.first] == "정액적립식"))
        ? "0"
        : "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: white,
        scrolledUnderElevation: 0.0,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back_ios_new, color: textPrimary),
        ),
      ),
      backgroundColor: white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              titleText(switch (widget.category) {
                ProductCategory.deposit => "예치금",
                ProductCategory.installment => "예치금",
                ProductCategory.annuity => "월 납입 금액",
                _ => "대출 원금",
              }),
              const SizedBox(height: 2.0),
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
              Row(
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
                      decoration: const BoxDecoration(
                        color: primary300,
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      child: titleText("리셋"),
                    ),
                  ),
                  const SizedBox(width: 12.0),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        if (_money.isEmpty || _period.isEmpty) {
                          showDialog(
                            context: context,
                            builder: (BuildContext ctx) => AlertDialog(
                              backgroundColor: white,
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 24.0,
                                horizontal: 16.0,
                              ),
                              content: const Text(
                                "항목이 다 채워지지 않았습니다!\n모든 항목을 기입해주세요",
                                style: TextStyle(color: black, fontSize: 16.0),
                                textAlign: TextAlign.center,
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(ctx, "ok"),
                                  style: TextButton.styleFrom(
                                    overlayColor: primary300,
                                  ),
                                  child: const Text(
                                    "OK",
                                    style: TextStyle(
                                      color: primary900,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                          return;
                        }
                        if (int.tryParse(_money) == null ||
                            int.tryParse(_period) == null) {
                          showDialog(
                            context: context,
                            builder: (BuildContext ctx) => AlertDialog(
                              backgroundColor: white,
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 24.0,
                                horizontal: 16.0,
                              ),
                              content: const Text(
                                "입력값에 숫자 외 값이 있습니다!\n숫자만 입력해주세요",
                                style: TextStyle(color: black, fontSize: 16.0),
                                textAlign: TextAlign.center,
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(ctx, "ok"),
                                  style: TextButton.styleFrom(
                                    overlayColor: primary300,
                                  ),
                                  child: const Text(
                                    "OK",
                                    style: TextStyle(
                                      color: primary900,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                          return;
                        }
                        final term = int.parse(
                          (widget.category == ProductCategory.installment)
                              ? _selectedValues[widget.mapOptions.keys
                                        .toList()[1]]!
                                    .substring(
                                      0,
                                      _selectedValues[widget.mapOptions.keys
                                                  .toList()[1]]!
                                              .length -
                                          2,
                                    )
                              : _period,
                        );
                        if (int.parse(_period) > term) {
                          showDialog(
                            context: context,
                            builder: (BuildContext ctx) => AlertDialog(
                              backgroundColor: white,
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 24.0,
                                horizontal: 16.0,
                              ),
                              content: const Text(
                                "예치 기간은 계약 기간보다 \n길 수 없습니다!\n다시 입력해주세요",
                                style: TextStyle(color: black, fontSize: 16.0),
                                textAlign: TextAlign.center,
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(ctx, "ok"),
                                  style: TextButton.styleFrom(
                                    overlayColor: primary300,
                                  ),
                                  child: const Text(
                                    "OK",
                                    style: TextStyle(
                                      color: primary900,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
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
                      decoration: const BoxDecoration(
                        color: primary400,
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      child: titleText("계산"),
                    ),
                  ),
                ],
              ),
              if (_isSubmitted)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 40.0),
                    titleText("계산 결과"),
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
                                      .firstOrNull
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
                                _selectedValues[widget.mapOptions.keys.first]!,
                            },
                            widget.category,
                            widget.options,
                            _selectedValues,
                          ),
                      int.parse(_period),
                    ),
                    const SizedBox(height: 40.0),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget titleText(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.w400,
        color: textPrimary,
      ),
    );
  }

  Widget normalText(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.w400,
        color: black,
      ),
    );
  }

  Widget dropdownCard(String key, List<dynamic> items) {
    return Card(
      color: white,
      shape: const RoundedRectangleBorder(
        side: BorderSide(color: primary900, width: 1.0),
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
            dropdownColor: white,
            value: _selectedValues[key],
            items: [
              for (final item in items)
                DropdownMenuItem(
                  value: item,
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: normalText(item),
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

  TableRow tableRow(String item, String value) {
    return TableRow(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
          color: primary100,
          child: normalText(item),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
          color: white,
          child: normalText(value),
        ),
      ],
    );
  }

  List<Widget> _displayDynamicWidgetList(
    ProductCategory category,
    Map<String, List<String>> mapOptions,
    List<double> rates,
  ) {
    final keys = mapOptions.keys.toList();
    return [
      if (category == ProductCategory.annuity)
        dropdownCard(keys[0], mapOptions[keys[0]] ?? [])
      else
        TextField(
          controller: _moneyController,
          onSubmitted: (value) => setState(() {
            _money = value;
          }),
          onTap: () {
            if (_isSubmitted == true) {
              setState(() {
                _isSubmitted = false;
              });
            }
          },
          decoration: const InputDecoration(
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: primary900),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: primary900),
            ),
            counterText: "",
            helperText: "숫자만 입력",
          ),
          keyboardType: TextInputType.number,
        ),
      const SizedBox(height: 28.0),
      titleText(switch (category) {
        ProductCategory.deposit => "예치 기간",
        ProductCategory.installment => "예치 종류 및 기간(개월)",
        ProductCategory.annuity => "연금수령 기간 및 납입 기간",
        _ => "상환 방법 및 대출 기간",
      }),
      const SizedBox(height: 2.0),
      if (category == ProductCategory.deposit)
        dropdownCard(keys[0], mapOptions[keys[0]] ?? [])
      else
        Row(
          children: [
            Expanded(
              child: dropdownCard(
                category == ProductCategory.annuity ? keys[1] : keys[0],
                category == ProductCategory.annuity
                    ? mapOptions[keys[1]] ?? []
                    : mapOptions[keys[0]] ?? [],
              ),
            ),
            const SizedBox(width: 8.0),
            if (category == ProductCategory.annuity ||
                (category == ProductCategory.installment &&
                    _selectedValues[keys[0]] == "정액적립식"))
              Expanded(
                child: dropdownCard(
                  category == ProductCategory.annuity ? keys[2] : keys[1],
                  category == ProductCategory.annuity
                      ? mapOptions[keys[2]] ?? []
                      : mapOptions[keys[1]] ?? [],
                ),
              )
            else
              Expanded(
                child: TextField(
                  controller: _periodController,
                  onSubmitted: (value) => setState(() {
                    _period = value;
                  }),
                  onTap: () {
                    if (_isSubmitted == true) {
                      setState(() {
                        _isSubmitted = false;
                      });
                    }
                  },
                  decoration: const InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: primary900),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: primary900),
                    ),
                    helperText: "숫자만 입력",
                    counterText: "",
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
          ],
        ),
      const SizedBox(height: 32.0),
      if (category == ProductCategory.installment &&
          _selectedValues[keys[0]] == "자유적립식") ...[
        titleText("계약 기간"),
        const SizedBox(height: 2.0),
        dropdownCard(keys[1], mapOptions[keys[1]] ?? []),
        const SizedBox(height: 32.0),
      ],
      titleText(switch (category) {
        ProductCategory.deposit => "예치 금리",
        ProductCategory.installment => "예치 기간 및 종류",
        ProductCategory.annuity => "가입 연령 및 개시 연령",
        _ => "대출 금리",
      }),
      const SizedBox(height: 2.0),
      if (category == ProductCategory.annuity)
        Row(
          children: [
            Expanded(child: dropdownCard(keys[3], mapOptions[keys[3]] ?? [])),
            const SizedBox(width: 8.0),
            Expanded(child: dropdownCard(keys[4], mapOptions[keys[4]] ?? [])),
          ],
        )
      else if (category == ProductCategory.deposit ||
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
                activeColor: primary900,
              ),
            ),
            const SizedBox(width: 4.0),
            const Text(
              "우대 금리 적용",
              style: TextStyle(
                color: black,
                fontSize: 14.0,
                fontWeight: FontWeight.w400,
              ),
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
              ),
            ),
            const SizedBox(width: 8.0),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
                decoration: BoxDecoration(
                  border: Border.all(color: primary900),
                ),
                alignment: Alignment.centerRight,
                child: normalText(
                  (rates.isNotEmpty &&
                          _isPrefSelected == true &&
                          rates.last != -1.0)
                      ? rates.lastOrNull.toString()
                      : rates.firstOrNull.toString(),
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
              style: const TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.w400,
                color: black,
              ),
              textAlign: TextAlign.left,
            ),
            Expanded(
              child: SliderTheme(
                data: SliderTheme.of(context).copyWith(
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
                  activeColor: primary900,
                  inactiveColor: primary300,
                ),
              ),
            ),
            Text(
              (rates.lastOrNull ?? 20.0).toString(),
              style: const TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.w400,
                color: black,
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
  ) {
    if (map.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: const Text(
            "계산 결과를 제공할 수 없습니다",
            style: TextStyle(
              color: textPrimary,
              fontSize: 18.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      );
    }
    return (category == ProductCategory.mortage ||
            category == ProductCategory.rent ||
            category == ProductCategory.credit)
        ? SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              headingRowColor: const WidgetStatePropertyAll(primary100),
              headingRowHeight: 40.0,
              dataRowColor: const WidgetStatePropertyAll(white),
              columnSpacing: 36.0,
              columns: [
                ...map.keys.map(
                  (e) => DataColumn(
                    label: Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [normalText(e)],
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
                        (e) => DataCell(normalText(e[i].toString())),
                      ),
                    ],
                  ),
              ],
            ),
          )
        : Table(
            border: TableBorder.all(color: primary300, width: 1),
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: [
              ...map.entries.map((e) {
                return TableRow(
                  children: [
                    TableCell(
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: primary100,
                          border: BoxBorder.all(color: primary300),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: TableCell(
                            verticalAlignment:
                                TableCellVerticalAlignment.middle,
                            child: Center(child: normalText(e.key)),
                          ),
                        ),
                      ),
                    ),
                    TableCell(
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: white,
                          border: BoxBorder.all(color: primary300),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: TableCell(
                            verticalAlignment:
                                TableCellVerticalAlignment.middle,
                            child: Center(
                              child: normalText(e.value.toString()),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }),
            ],
          );
  }
}
