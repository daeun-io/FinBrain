import 'package:finbrain/themes/colors.dart';
import 'package:flutter/material.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  final _textController = TextEditingController();

  var isSubmitted = false;
  int? _period;
  int? _interest;
  String? _type = "단리";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: white,
        body: Padding(
          padding: const EdgeInsets.only(top: 80.0, left: 20.0, right: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "예치금",
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w400,
                  color: textPrimary,
                ),
              ),
              const SizedBox(height: 2.0),
              TextField(
                controller: _textController,
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
              const SizedBox(height: 32.0),
              const Text(
                "예치 기간",
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w400,
                  color: textPrimary,
                ),
              ),
              const SizedBox(height: 2.0),
              Card(
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
                      value: _period,
                      items: [
                        const DropdownMenuItem(
                          value: 6,
                          child: Text(
                            "6개월",
                            style: TextStyle(
                              color: textPrimary,
                              fontSize: 18.0,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        const DropdownMenuItem(
                          value: 12,
                          child: Text(
                            "12개월",
                            style: TextStyle(
                              color: textPrimary,
                              fontSize: 18.0,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          _period = value;
                        });
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32.0),
              const Text(
                "예치 금리",
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w400,
                  color: textPrimary,
                ),
              ),
              const SizedBox(height: 2.0),
              Row(
                children: [
                  SizedBox(
                    width: 100,
                    child: Card(
                      color: white,
                      shape: const RoundedRectangleBorder(
                        side: BorderSide(color: primary900, width: 1.0),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: ButtonTheme(
                          alignedDropdown: true,
                          child: DropdownButton<String>(
                            isExpanded: true,
                            dropdownColor: Colors.white,
                            value: _type,
                            items: [
                              const DropdownMenuItem(
                                value: "단리",
                                child: Text(
                                  "단리",
                                  style: TextStyle(
                                    color: textPrimary,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                              const DropdownMenuItem(
                                value: "복리",
                                child: Text(
                                  "복리",
                                  style: TextStyle(
                                    color: textPrimary,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ],
                            onChanged: (value) {
                              setState(() {
                                _type = value;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12.0),
                  // 2. 이율 선택 드롭다운 (남은 공간 전체)
                  Expanded(
                    child: Card(
                      margin: EdgeInsets.zero,
                      color: Colors.white,
                      shape: const RoundedRectangleBorder(
                        side: BorderSide(color: primary900, width: 1.0),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: ButtonTheme(
                          alignedDropdown: true,
                          child: DropdownButton<int>(
                            isExpanded: true,
                            dropdownColor: Colors.white,
                            value: _interest,
                            items: [
                              const DropdownMenuItem(
                                value: 1,
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    "1.74%",
                                    style: TextStyle(
                                      color: textPrimary,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ),
                              const DropdownMenuItem(
                                value: 2,
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    "1.80%",
                                    style: TextStyle(
                                      color: textPrimary,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                            onChanged: (value) {
                              // 중요: 이 부분에 setState가 있어야 화면이 갱신됩니다.
                              setState(() {
                                _interest = value;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      _textController.clear();
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
                      child: const Text(
                        "리셋",
                        style: TextStyle(
                          fontSize: 18.0,
                          color: textPrimary,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
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
                      child: const Text(
                        "계산",
                        style: TextStyle(
                          fontSize: 18.0,
                          color: textPrimary,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              if (isSubmitted)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 40.0),
                    const Text(
                      "계산 결과",
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600,
                        color: textPrimary,
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    SizedBox(
                      width: double.infinity,
                      child: Table(
                        defaultColumnWidth: FlexColumnWidth(1.0),
                        children: [
                          TableRow(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12.0,
                                  horizontal: 16.0,
                                ),
                                color: primary100,
                                child: const Text(
                                  "예치금",
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w400,
                                    color: black,
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12.0,
                                  horizontal: 16.0,
                                ),
                                color: white,
                                child: const Text(
                                  "10,000,000원",
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w400,
                                    color: black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          TableRow(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12.0,
                                  horizontal: 16.0,
                                ),
                                color: primary100,
                                child: const Text(
                                  "예치금",
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w400,
                                    color: black,
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12.0,
                                  horizontal: 16.0,
                                ),
                                color: white,
                                child: const Text(
                                  "10,000,000원",
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w400,
                                    color: black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          TableRow(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12.0,
                                  horizontal: 16.0,
                                ),
                                color: primary100,
                                child: const Text(
                                  "예치금",
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w400,
                                    color: black,
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12.0,
                                  horizontal: 16.0,
                                ),
                                color: white,
                                child: const Text(
                                  "10,000,000원",
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w400,
                                    color: black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          TableRow(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12.0,
                                  horizontal: 16.0,
                                ),
                                color: primary100,
                                child: const Text(
                                  "예치금",
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w400,
                                    color: black,
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12.0,
                                  horizontal: 16.0,
                                ),
                                color: white,
                                child: const Text(
                                  "10,000,000원",
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w400,
                                    color: black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      );
  }
}
