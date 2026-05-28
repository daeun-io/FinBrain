import 'package:finbrain/themes/colors.dart';
import 'package:finbrain/ui/product_categories.dart';
import 'package:flutter/material.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({
    super.key,
    required this.category,
    required this.mapOptions,
    required this.options,
  });

  final ProductCategory category;
  final Map<String, List<String>> mapOptions;
  final List<dynamic> options;

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  final _moneyController = TextEditingController();
  final _periodController = TextEditingController();

  bool isSubmitted = false;

  late String _firstValue;
  late String _secondValue;
  late String _thirdValue;
  late String _forthValue;

  @override
  void initState() {
    super.initState();
    final List<String> dropdownValues = [];
    final keys = widget.mapOptions.keys.toList();
    if (widget.mapOptions.isNotEmpty && keys.isNotEmpty) {
      for (var i = 0; i < keys.length; i++) {
        if (widget.mapOptions[keys[i]] != null &&
            widget.mapOptions[keys[i]]!.isNotEmpty) {
          dropdownValues.add(widget.mapOptions[keys[i]]!.first);
        }
      }

      _firstValue = dropdownValues[0];
      _secondValue = dropdownValues[1];
      if(keys.length >= 3){
        _thirdValue = dropdownValues[2];
      }
      if(keys.length == 4){
        _forthValue = dropdownValues[3];
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: white,
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
              TextField(
                controller: _moneyController,
                decoration: const InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: primary900),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: primary900),
                  ),
                  counterText: "",
                  helperText: "",
                ),
              ),
              const SizedBox(height: 28.0),
              ..._displayDynamicWidgetList(widget.category, widget.mapOptions),
              const SizedBox(height: 32.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      _moneyController.clear();
                      setState(() {
                        isSubmitted = false;
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
                        isSubmitted = true;
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
              if (isSubmitted)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 40.0),
                    titleText("계산 결과"),
                    const SizedBox(height: 16.0),
                    _displayResult(widget.category, []),
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

  Widget dropdownCard(int ordinal, List<dynamic> items) {
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
            dropdownColor: white,
            value: switch (ordinal) {
              1 => _firstValue,
              2 => _secondValue,
              3 => _thirdValue,
              _ => _forthValue,
            },
            items: [
              for (final item in items)
                DropdownMenuItem(value: item, child: normalText(item)),
            ],
            onChanged: items.length == 1
                ? null
                : (value) {
                    setState(() {
                      switch (ordinal) {
                        case 1:
                          _firstValue = value.toString();
                        case 2:
                          _secondValue = value.toString();
                        case 3:
                          _thirdValue = value.toString();
                        default:
                          _forthValue = value.toString();
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
    Map<String, List<String>> options,
  ) {
    final keys = options.keys.toList();
    return [
      titleText(switch (category) {
        ProductCategory.deposit => "예치 기간",
        ProductCategory.installment => "예치 종류 및 기간(개월)",
        ProductCategory.annuity => "연금수령 기간 및 납입 기간",
        _ => "상환 방법 및 대출 기간",
      }),
      const SizedBox(height: 2.0),
      if (category == ProductCategory.deposit)
        dropdownCard(1, options[keys[0]] ?? [])
      else
        Row(
          children: [
            Expanded(child: dropdownCard(1, options[keys[0]] ?? [])),
            const SizedBox(width: 8.0),
            if (category == ProductCategory.installment &&
                _firstValue == "자유적립식")
              Expanded(
                child: TextField(
                  controller: _periodController,
                  decoration: const InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: primary900),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: primary900),
                    ),
                    helperText: "12",
                    counterText: "",
                  ),
                ),
              )
            else
              Expanded(child: dropdownCard(2, options[keys[1]] ?? [])),
          ],
        ),
      const SizedBox(height: 32.0),
      if (category == ProductCategory.installment &&
          _firstValue == "자유적립식") ...[
        titleText("계약 기간"),
        const SizedBox(height: 2.0),
        dropdownCard(2, options[keys[1]] ?? []),
        const SizedBox(height: 32.0,)
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
            Expanded(child: dropdownCard(3, options[keys[2]] ?? [])),
            const SizedBox(width: 8.0),
            Expanded(child: dropdownCard(4, options[keys[3]] ?? [])),
          ],
        )
      else if (category == ProductCategory.deposit ||
          category == ProductCategory.installment)
        Row(
          children: [
            SizedBox(
              width: 100,
              child: dropdownCard(3, options[keys[2]] ?? []),
            ),
            const SizedBox(width: 8.0),
            Expanded(child: dropdownCard(4, options[keys[3]] ?? [])),
          ],
        )
      else
        dropdownCard(3, options[keys[2]] ?? []),
    ];
  }

  Widget _displayResult(ProductCategory category, List<String> values) {
    if (category == ProductCategory.mortage ||
        category == ProductCategory.rent ||
        category == ProductCategory.credit) {
      return SingleChildScrollView(child: Center());
    } else {
      return SizedBox(
        width: double.infinity,
        child: Table(
          defaultColumnWidth: FlexColumnWidth(1.0),
          children: [
            for (var i = 0; i < values.length; i++)
              tableRow(switch (category) {
                ProductCategory.annuity => "월 납입 금액",
                _ => "예치금",
              }, values[i]),
          ],
        ),
      );
    }
  }
}
