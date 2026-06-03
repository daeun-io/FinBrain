import 'package:finbrain/data/model/entities/annuity_savings.dart';
import 'package:finbrain/data/model/entities/annuity_savings_option.dart';
import 'package:finbrain/data/model/entities/credit_loan.dart';
import 'package:finbrain/data/model/entities/credit_loan_option.dart';
import 'package:finbrain/data/model/entities/deposit_and_installment_savings_option.dart';
import 'package:finbrain/data/model/entities/deposit_and_installment_savings.dart';
import 'package:finbrain/data/model/entities/mortage_and_rent_loan.dart';
import 'package:finbrain/data/model/entities/mortage_and_rent_loan_option.dart';
import 'package:finbrain/ui/product_categories.dart';

final dummyData = [
  DepositAndInstallmentSavings(
    category: ProductCategory.deposit,
    submittedMonth: "201609",
    companyCode: "0010001",
    companyName: "우리은행",
    productCode: "WR0001A",
    productName: "Woori WellRich",
    startDay: "20160920",
    endDay: null,
    submittedDay: "201609201028",
    joinWay: "영업점,인터넷,스마트폰",
    url: "",
    interestAfterExpiration: """만기 후
		  - 1개월이내 : 만기시점약정이율×50%
		  - 1개월초과 6개월이내: 만기시점약정이율×30%
		  - 6개월초과 : 만기시점약정이율×20%

		  ※ 만기시점 약정이율 : 일반정기예금 금리""",
    specialCondition: """다음 중 하나 충족한 입금건에 대해  최고 연0.2%p
		    1. 순신규고객
		    2. 가계대출이용고객
		    3. 입금일 전월 주거래우대조건 2가지이상
		    4. 건별3천만원이상
		    5. 건별 만기 자동재예치""",
    joinDeny: "제한 없음",
    joinMember: "실명의 개인",
    etc: """-추가입금은 신규가입 시 선택한 예치기간을 각 입금건별 입금일로부터 적용
		    -재예치는 입금건별 최초 입금일로부터 최장 10년간 가능""",
    maxLimit: null,
    options: [
      DepositAndInstallmentSavingsOption(
        intRateType: "S",
        intRateTypeName: "단리",
        saveTerm: 6,
        intRate: 1.15,
        maxIntRate: 1.35,
        reserveType: null,
        reserveTypeName: null,
      ),
      DepositAndInstallmentSavingsOption(
        intRateType: "S",
        intRateTypeName: "단리",
        saveTerm: 12,
        intRate: 1.3,
        maxIntRate: 1.5,
        reserveType: null,
        reserveTypeName: null,
      ),
    ],
  ),
  DepositAndInstallmentSavings(
    category: ProductCategory.installment,
    submittedMonth: "201609",
    companyCode: "0010001",
    companyName: "우리은행",
    productCode: "WR0001A",
    productName: "올포미 적금",
    startDay: "20160920",
    endDay: null,
    submittedDay: "201609201049",
    joinWay: "영업점",
    url: "",
    interestAfterExpiration: """만기 후
- 1개월이내 : 만기시점약정이율×50%
- 1개월초과 6개월이내: 만기시점약정이율×30%
- 6개월초과 : 만기시점약정이율×20%

		  ※ 만기시점 약정이율 : 일반정기예금 금리""",
    specialCondition: """신규 시 아래항목 충족 시 최고 연0.2%p
1. 올포미 신용 카드 보유 및 우리은행 결제계좌 지정 연 0.2%p
2. 우리은행 첫거래 고객 연 0.1%p
3. 급여/연금치에 고객 연0.1%p
4. 통신비/공과금 자동이체 고객 연0.1%p""",
    joinDeny: "제한 없음",
    joinMember: "실명의 개인",
    etc: null,
    maxLimit: null,
    options: [
      DepositAndInstallmentSavingsOption(
        intRateType: "S",
        intRateTypeName: "단리",
        saveTerm: 6,
        intRate: 1.15,
        maxIntRate: 1.35,
        reserveType: "S",
        reserveTypeName: "정액적립식",
      ),
      DepositAndInstallmentSavingsOption(
        intRateType: "S",
        intRateTypeName: "단리",
        saveTerm: 24,
        intRate: 1.7,
        maxIntRate: null,
        reserveType: "S",
        reserveTypeName: "정액적립식",
      ),
      DepositAndInstallmentSavingsOption(
        intRateType: "S",
        intRateTypeName: "단리",
        saveTerm: 36,
        intRate: 1.75,
        maxIntRate: null,
        reserveType: "S",
        reserveTypeName: "정액적립식",
      ),
      DepositAndInstallmentSavingsOption(
        intRateType: "S",
        intRateTypeName: "단리",
        saveTerm: 6,
        intRate: 1.35,
        maxIntRate: null,
        reserveType: "F",
        reserveTypeName: "자유적립식",
      ),
      DepositAndInstallmentSavingsOption(
        intRateType: "S",
        intRateTypeName: "단리",
        saveTerm: 12,
        intRate: 1.45,
        maxIntRate: null,
        reserveType: "F",
        reserveTypeName: "자유적립식",
      ),
      DepositAndInstallmentSavingsOption(
        intRateType: "S",
        intRateTypeName: "단리",
        saveTerm: 36,
        intRate: 1.55,
        maxIntRate: null,
        reserveType: "F",
        reserveTypeName: "자유적립식",
      ),
      DepositAndInstallmentSavingsOption(
        intRateType: "S",
        intRateTypeName: "단리",
        saveTerm: 12,
        intRate: 1.65,
        maxIntRate: null,
        reserveType: "S",
        reserveTypeName: "정액적립식",
      ),
    ],
  ),
  MortageAndRentLoan(
    category: ProductCategory.mortage,
    submittedMonth: "201601",
    companyCode: "0010001",
    companyName: "우리은행",
    productCode: "1054",
    productName: "우리아파트론",
    startDay: "20160120",
    endDay: null,
    submittedDay: "201601191355",
    joinWay: "영업점,모집인",
    url: "",
    extraExpense: """
    - 인지세 : 해당세액의 50%(대출금액 4천만원 이하시 없음)
		- 국민주택채권 매입 : 대출금액 × 120% × 1% × 채권할인율
		- 주택신보출연료(신규 주택구입시에 한함) : 0.09~0.29%
    """,
    earlyRepayFee: """
    - 주택상환금액×1.4%×(대출잔액일수÷3년)
    """,
    delayRate: """
    - 3개월 미만 : 정상금리 + 7%
		- 3개월 이상 : 정상금리 + 8%
		  (최고 : 15%)
    """,
    loanLimit: "LTV 70%",
    options: [
      MortageAndRentLoanOption(
        loanType: "A",
        loanTypeName: "아파트",
        repayType: "D",
        repayTypeName: "분할상환방식",
        lendRateType: "F",
        lendRateTypeName: "고정금리",
        lendRateMin: 2.97,
        lendRateMax: 4.78,
        lendRateAvg: 3.2,
      ),
      MortageAndRentLoanOption(
        loanType: "A",
        loanTypeName: "아파트",
        repayType: "S",
        repayTypeName: "만기일시상환방식",
        lendRateType: "C",
        lendRateTypeName: "변동금리",
        lendRateMin: 2.97,
        lendRateMax: 4.78,
        lendRateAvg: 3.51,
      ),
    ],
  ),
  MortageAndRentLoan(
    category: ProductCategory.rent,
    submittedMonth: "201601",
    companyCode: "0010001",
    companyName: "우리은행",
    productCode: "203105601",
    productName: "우리전세론(주택보증)",
    startDay: "20160120",
    endDay: null,
    submittedDay: "201601191355",
    joinWay: "영업점,모집인",
    url: "",
    extraExpense: """
    - 인지세 : 해당세액의 50%(대출금액 4천만원 이하시 없음)
    - 주택신보출연료 : 0.29%
    - 주택신보보증료 : 연 0.18 ~ 연 0.50%
    """,
    earlyRepayFee: """
    - 주택상환금액×0.7%×(대출잔액일수÷3년)
    """,
    delayRate: """
    - 3개월 미만 : 정상금리 + 7%
    - 3개월 이상 : 정상금리 + 8%
    (최고: 15%)
    """,
    loanLimit: "최대2.2억원",
    options: [
      MortageAndRentLoanOption(
        loanType: null,
        loanTypeName: null,
        repayType: "S",
        repayTypeName: "만기일시상환방식",
        lendRateType: "F",
        lendRateTypeName: "고정금리",
        lendRateMin: 2.97,
        lendRateMax: 4.82,
        lendRateAvg: 4.06,
      ),
      MortageAndRentLoanOption(
        loanType: null,
        loanTypeName: null,
        repayType: "S",
        repayTypeName: "만기일시상환방식",
        lendRateType: "C",
        lendRateTypeName: "변동금리",
        lendRateMin: 2.97,
        lendRateMax: 4.82,
        lendRateAvg: 2.94,
      ),
    ],
  ),
  CreditLoan(
    category: ProductCategory.credit,
    submittedMonth: "202102",
    companyCode: "0010001",
    companyName: "우리은행",
    productCode: "CR0001A",
    productName: "개인신용대출",
    startDay: "20160120",
    endDay: null,
    submittedDay: "201601191355",
    joinWay: "영업점,인터넷,스마트폰",
    url: "",
    cbName: "KCB",
    productType: "1",
    productTypeName: "일반신용대출",
    options: [
      CreditLoanOption(
        creditLendRateType: "A",
        creditLendRateTypeName: "대출금리",
        gradeOver900: 2.62,
        grade801900: 2.89,
        grade701800: 3.1,
        grade601700: 3.51,
        grade501600: 4.83,
        grade401500: 4.44,
        grade301400: 2.48,
        gradeUnder300: 10.87,
        averageGrade: 2.93,
      ),
      CreditLoanOption(
        creditLendRateType: "A",
        creditLendRateTypeName: "가산금리",
        gradeOver900: 2.62,
        grade801900: 2.89,
        grade701800: 3.1,
        grade601700: 3.51,
        grade501600: 4.83,
        grade401500: 4.44,
        grade301400: 2.48,
        gradeUnder300: 10.87,
        averageGrade: 2.93,
      ),
      CreditLoanOption(
        creditLendRateType: "A",
        creditLendRateTypeName: "기준금리",
        gradeOver900: 2.62,
        grade801900: 2.89,
        grade701800: 3.1,
        grade601700: 3.51,
        grade501600: 4.83,
        grade401500: 4.44,
        grade301400: 2.48,
        gradeUnder300: 10.87,
        averageGrade: 2.93,
      ),
    ],
  ),
  AnnuitySavings(
    category: ProductCategory.annuity,
    submittedMonth: "201510",
    companyCode: "0010170",
    companyName: "하나유비에스자산운용",
    productCode: "KR5102314204",
    productName: "하나UBS인Best연금증권투자신탁(제1호)[채권]",
    startDay: "20151001",
    endDay: null,
    submittedDay: "201510301534",
    joinWay: "영업점,인터넷,스마트폰,모집인,전화(텔레뱅킹),기타",
    url: null,
    pensionKind: "4",
    pensionKindName: "연금저축펀드",
    saleStartDay: "20010201",
    maintenanceCount: "73342945069",
    productType: "411",
    productTypeName: "채권형",
    averageProfit: 4.05,
    declaredRate: null,
    guaranteedRate: null,
    pyProfitRate: 2.96,
    ppyProfitRate: 1.97,
    pppyProfitRate: 3.35,
    etc: null,
    saleCompany:
        "KEB하나은행(구.외환은행),KEB하나은행(구.하나은행),우리은행,기업은행,수협중앙회,에스케이증권,현대증권,메리츠종금증권,삼성증권,한양증권,NH투자증권,교보증권,KDB대우증권,신한금융투자,유안타증권,아이비케이투자증권,이베스트투자증권,키움증권,리딩투자증권,하나금융투자,하이투자증권,동부증권,에이치엠씨투자증권,한화투자증권,미래에셋생명보험,삼성생명보험,한화생명보험,펀드온라인코리아 주식회사,케이티비투자증권,유진투자증권",
    options: [
      AnnuitySavingsOption(
        receiptTerm: "A",
        receiptTermName: "10년 확정",
        entryAge: "30",
        entryAgeName: "30세",
        monthlyPayment: "10",
        monthlyPaymentName: "100,000원",
        paymentPeriod: "10",
        paymentPeriodName: "10년",
        startAge: "60",
        startAgeName: "60세",
        monthlyReceiptAmount: "229566",
      ),
      AnnuitySavingsOption(
        receiptTerm: "B",
        receiptTermName: "20년 확정",
        entryAge: "30",
        entryAgeName: "30세",
        monthlyPayment: "10",
        monthlyPaymentName: "100,000원",
        paymentPeriod: "20",
        paymentPeriodName: "20년",
        startAge: "60",
        startAgeName: "60세",
        monthlyReceiptAmount: "840868",
      ),
    ],
  ),
];

final dummyDeposit = [
  DepositAndInstallmentSavings(
    category: ProductCategory.deposit,
    submittedMonth: "201609",
    companyCode: "0010001",
    companyName: "우리은행",
    productCode: "WR0001A",
    productName: "Woori WellRich",
    startDay: "20160920",
    endDay: null,
    submittedDay: "201609201028",
    joinWay: "영업점,인터넷,스마트폰",
    url: "",
    interestAfterExpiration: """만기 후
	  - 1개월이내 : 만기시점약정이율×50%
	  - 1개월초과 6개월이내: 만기시점약정이율×30%
	  - 6개월초과 : 만기시점약정이율×20%
	  ※ 만기시점 약정이율 : 일반정기예금 금리""",
    specialCondition: """다음 중 하나 충족한 입금건에 대해  최고
	    1. 순신규고객
	    2. 가계대출이용고객
	    3. 입금일 전월 주거래우대조건 2가지이상
	    4. 건별3천만원이상
	    5. 건별 만기 자동재예치""",
    joinDeny: "제한 없음",
    joinMember: "실명의 개인",
    etc: """-추가입금은 신규가입 시 선택한 예치기간을 각 입금건
	    -재예치는 입금건별 최초 입금일로부터 최장 10년간 가능""",
    maxLimit: null,
    options: [
      DepositAndInstallmentSavingsOption(
        intRateType: "S",
        intRateTypeName: "단리",
        saveTerm: 6,
        intRate: 1.15,
        maxIntRate: 1.35,
        reserveType: null,
        reserveTypeName: null,
      ),
      DepositAndInstallmentSavingsOption(
        intRateType: "S",
        intRateTypeName: "단리",
        saveTerm: 12,
        intRate: 1.3,
        maxIntRate: 1.5,
        reserveType: null,
        reserveTypeName: null,
      ),
    ],
  ),
  DepositAndInstallmentSavings(
    category: ProductCategory.deposit,
    submittedMonth: "201609",
    companyCode: "0010001",
    companyName: "우리은행",
    productCode: "WR0001A",
    productName: "우리웰리치",
    startDay: "20160920",
    endDay: null,
    submittedDay: "201609201028",
    joinWay: "영업점,인터넷,스마트폰",
    url: "",
    interestAfterExpiration: """만기 후
	  - 1개월이내 : 만기시점약정이율×50%
	  - 1개월초과 6개월이내: 만기시점약정이율×30%
	  - 6개월초과 : 만기시점약정이율×20%
	  ※ 만기시점 약정이율 : 일반정기예금 금리""",
    specialCondition: """다음 중 하나 충족한 입금건에 대해  최고
	    1. 순신규고객
	    2. 가계대출이용고객
	    3. 입금일 전월 주거래우대조건 2가지이상
	    4. 건별3천만원이상
	    5. 건별 만기 자동재예치""",
    joinDeny: "제한 없음",
    joinMember: "실명의 개인",
    etc: """-추가입금은 신규가입 시 선택한 예치기간을 각 입금건
	    -재예치는 입금건별 최초 입금일로부터 최장 10년간 가능""",
    maxLimit: null,
    options: [
      DepositAndInstallmentSavingsOption(
        intRateType: "S",
        intRateTypeName: "단리",
        saveTerm: 6,
        intRate: 1.65,
        maxIntRate: 1.85,
        reserveType: null,
        reserveTypeName: null,
      ),
      DepositAndInstallmentSavingsOption(
        intRateType: "S",
        intRateTypeName: "단리",
        saveTerm: 12,
        intRate: 1.85,
        maxIntRate: 2.0,
        reserveType: null,
        reserveTypeName: null,
      ),
    ],
  ),
  DepositAndInstallmentSavings(
    category: ProductCategory.deposit,
    submittedMonth: "201609",
    companyCode: "0010001",
    companyName: "우리은행",
    productCode: "WR0001A",
    productName: "우리웰리치2",
    startDay: "20160920",
    endDay: null,
    submittedDay: "201609201028",
    joinWay: "영업점,인터넷,스마트폰",
    url: "",
    interestAfterExpiration: """만기 후
	  - 1개월이내 : 만기시점약정이율×50%
	  - 1개월초과 6개월이내: 만기시점약정이율×30%
	  - 6개월초과 : 만기시점약정이율×20%
	  ※ 만기시점 약정이율 : 일반정기예금 금리""",
    specialCondition: """다음 중 하나 충족한 입금건에 대해  최고
	    1. 순신규고객
	    2. 가계대출이용고객
	    3. 입금일 전월 주거래우대조건 2가지이상
	    4. 건별3천만원이상
	    5. 건별 만기 자동재예치""",
    joinDeny: "제한 없음",
    joinMember: "실명의 개인",
    etc: """-추가입금은 신규가입 시 선택한 예치기간을 각 입금건
	    -재예치는 입금건별 최초 입금일로부터 최장 10년간 가능""",
    maxLimit: null,
    options: [
      DepositAndInstallmentSavingsOption(
        intRateType: "S",
        intRateTypeName: "단리",
        saveTerm: 6,
        intRate: 1.5,
        maxIntRate: 2.3,
        reserveType: null,
        reserveTypeName: null,
      ),
      DepositAndInstallmentSavingsOption(
        intRateType: "S",
        intRateTypeName: "단리",
        saveTerm: 12,
        intRate: 1.7,
        maxIntRate: 2.5,
        reserveType: null,
        reserveTypeName: null,
      ),
    ],
  ),
];
