import 'package:collection/collection.dart';
import 'package:finbrain/data/model/entities/annuity_savings_option.dart';
import 'package:finbrain/data/model/entities/credit_loan_option.dart';
import 'package:finbrain/data/model/entities/deposit_and_installment_savings_option.dart';
import 'package:finbrain/data/model/entities/mortage_and_rent_loan_option.dart';
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

  bool _isSubmitted = false;
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
    _sliderValue =
        _returnRate(widget.category).isNotEmpty &&
            _returnRate(widget.category)[1] != null
        ? _returnRate(widget.category)[1]
        : 0.0;
  }

  List<double> _returnRate(ProductCategory category) {
    final keys = widget.mapOptions.keys.toList();
    switch (category) {
      case ProductCategory.deposit:
        final option = widget.options
            .where(
              (e) =>
                  "${(e as DepositAndInstallmentSavingsOption).saveTerm}개월" ==
                      _selectedValues[keys[0]] &&
                  e.intRateTypeName == _selectedValues[keys[1]],
            )
            .firstOrNull;
        if (option != null) {
          return [
            (option as DepositAndInstallmentSavingsOption).intRate != null
                ? option.intRate!
                : -1.0,
            option.maxIntRate != null ? option.maxIntRate! : -1.0,
          ];
        } else {
          return [];
        }
      case ProductCategory.installment:
        final option = widget.options
            .where(
              (e) =>
                  (e as DepositAndInstallmentSavingsOption).reserveTypeName ==
                      _selectedValues[keys[0]] &&
                  "${e.saveTerm}개월" == _selectedValues[keys[1]] &&
                  e.intRateTypeName == _selectedValues[keys[2]],
            )
            .firstOrNull;
        if (option != null) {
          final result = [
            (option as DepositAndInstallmentSavingsOption).intRate != null
                ? option.intRate!
                : -1.0,
            option.maxIntRate != null ? option.maxIntRate! : -1.0,
          ];
          return result;
        } else {
          return [];
        }
      case ProductCategory.annuity:
        final option = widget.options.where(
          (e) =>
              (e as AnnuitySavingsOption).monthlyPaymentName ==
                  _selectedValues[keys[0]] &&
              e.receiptTermName == _selectedValues[keys[1]] &&
              e.paymentPeriodName == _selectedValues[keys[2]] &&
              e.entryAgeName == _selectedValues[keys[3]] &&
              e.startAgeName == _selectedValues[keys[4]],
        );
        if (option.isNotEmpty && option.first != null) {
          return [option.first.monthlyReceiptAmount];
        } else {
          return [];
        }
      default:
        if (category == ProductCategory.credit) {
          final foundOption = widget.options.where(
            (e) => (e as CreditLoanOption).creditLendRateTypeName == "대출금리",
          ).firstOrNull;
          if(foundOption == null) return [];
          final rates = [
            foundOption.gradeOver900,
            foundOption.grade801900,
            foundOption.grade701800,
            foundOption.grade601700,
            foundOption.grade501600,
            foundOption.grade401500,
            foundOption.grade301400,
            foundOption.gradeUnder300,
          ].whereType<double>();
          final avgRates = foundOption.averageGrade;

          final min = rates.min;
          final max = rates.max;
          final avg = (avgRates != null) ? avgRates : rates.average;
          return [min, avg, max];
        } else {
          final min = widget.options
              .map((e) => (e as MortageAndRentLoanOption).lendRateMin)
              .whereType<double>()
              .min;
          final max = widget.options
              .map((e) => (e as MortageAndRentLoanOption).lendRateMax)
              .whereType<double>()
              .max;
          final avg = widget.options
              .map((e) => (e as MortageAndRentLoanOption).lendRateAvg)
              .whereType<double>()
              .average;
          return [min, avg, max];
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
              ..._displayDynamicWidgetList(widget.category, widget.mapOptions),
              const SizedBox(height: 32.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      _moneyController.clear();
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
  ) {
    final keys = mapOptions.keys.toList();
    return [
      if (category == ProductCategory.annuity)
        dropdownCard(keys[0], mapOptions[keys[0]] ?? [])
      else
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
            helperText: "숫자만 입력",
          ),
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
                  (_returnRate(category).isNotEmpty &&
                          _isPrefSelected == true &&
                          _returnRate(category).last != -1.0)
                      ? _returnRate(category).lastOrNull.toString()
                      : _returnRate(category).firstOrNull.toString(),
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
              (_returnRate(category).firstOrNull ?? 0.0).toString(),
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
                  min: _returnRate(category).firstOrNull ?? 0.0,
                  max: _returnRate(category).lastOrNull ?? 20.0,
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
              (_returnRate(category).lastOrNull ?? 20.0).toString(),
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
