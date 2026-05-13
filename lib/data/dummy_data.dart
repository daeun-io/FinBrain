import 'package:finbrain/data/model/entities/deposit_and_installment_savings_option.dart';
import 'package:finbrain/data/model/entities/deposit_and_installment_savings.dart';

final dummyData = [
  DepositAndInstallmentSavings(
    submittedMonth: "201609",
    companyCode: "0010001",
    companyName: "우리은행",
    productCode: "WR0001A",
    productName: "우리웰리치 주거래예금1",
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
    submittedMonth: "201609",
    companyCode: "0010001",
    companyName: "우리은행",
    productCode: "WR0001A",
    productName: "우리웰리치 주거래예금2",
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
    submittedMonth: "201609",
    companyCode: "0010001",
    companyName: "우리은행",
    productCode: "WR0001A",
    productName: "우리웰리치 주거래예금3",
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
];
