import 'package:finbrain/data/data_source/user_data_source.dart';
import 'package:finbrain/data/google_auth_service.dart';
import 'package:finbrain/data/model/entities/deposit_and_installment_savings.dart';
import 'package:finbrain/data/model/entities/financial_product.dart';
import 'package:finbrain/product_categories.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'ai_comp_tutorial_viewmodel.g.dart';

@riverpod
class AiCompTutorialViewmodel extends _$AiCompTutorialViewmodel {
  final userDataSource = UserDataSource();

  @override
  Future<bool> build() async {
    return readAiCompTutorial();
  }

  Future<bool> readAiCompTutorial() async {
    final user = GoogleAuthService.getCurrentUser();
    if(user == null || user.displayName == null || user.email == null) return true;
    return userDataSource.readAiCompTutorial(user);
  }

  Future<void> setReadAiCompTutorialToValue(bool value) async {
    final user = GoogleAuthService.getCurrentUser();
    if(user == null || user.displayName == null || user.email == null) return;
    return userDataSource.setReadAiCompTutorialToValue(value);
  }
  
  List<FinancialProduct> getMockData() {
    return [
      DepositAndInstallmentSavings(
        category: ProductCategory.deposit,
        submittedMonth: "201609",
        companyCode: "0010001",
        companyName: "우리은행",
        productCode: "WR0001A",
        productName: "우리웰리치 주거래예금",
        startDay: "20160920",
        endDay: null,
        submittedDay: "201609201028",
        joinWay: ["영업점", "인터넷", "스마트폰"],
        isLiked: true,
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
        joinDeny: "없음",
        joinMember: "실명의 개인",
        etc:
            "-추가입금은 신규가입 시 선택한 예치기간을 각 입금건별 입금일로부터 적용\n-재예치는 입금건별 최초 입금일로부터 최장 10년간 가능",
        maxLimit: null,
        maxPrfRate: null,
        maxBaseRate: null,
        options: [],
      ),
      DepositAndInstallmentSavings(
        category: ProductCategory.deposit,
        submittedMonth: "201609",
        companyCode: "0010001",
        companyName: "우리은행",
        productCode: "WR0001B",
        productName: "우리웰리치100예금(회전형)",
        startDay: "20160920",
        endDay: null,
        submittedDay: "201609201028",
        joinWay: ["영업점", "인터넷", "스마트폰"],
        isLiked: true,
        interestAfterExpiration: """만기 후
		- 1개월이내 : 만기시점약정이율×50%
		- 1개월초과 6개월이내: 만기시점약정이율×30%
		- 6개월초과 : 만기시점약정이율×20%

		※ 만기시점 약정이율 : 일반정기예금 금리""",
        specialCondition: """최고 연 0.2%p우대이율
		1. 연금이체실적보유 : 연0.1%p
		2. 신용/체크카드 보유 : 연0.1%p
		3. 당일 적금/예금/펀드 해지 후 신규시  : 연0.1%p
		4. 인터넷/스마트뱅킹으로 신규시 : 연 0.1%""",
        joinDeny: "없음",
        joinMember: "실명의 개인",
        etc:
            "-가입자가 환갑, 칠순, 팔순, 구순, 백순 사유로 중도해지 시 기본이자율을 중도해지 이자율 적용\n※ 주민등록번호 기준으로 사유발생 전후3개월간 혜택제공",
        maxLimit: null,
        maxPrfRate: null,
        maxBaseRate: null,
        options: [],
      ),
    ];
  }

  String getMockRes(){
    return """우리은행의 우리웰리치 주거래예금과 우리웰리치100예금(회전형)은 고객의 자산을 안정적으로 운용하면서 주거래 실적이나 시장 금리 변동에 연동되도록 설계된 상품들이라는 공통점을 가집니다. 두 상품의 공통점과 세부적인 차이점은 다음과 같습니다.
    공통점
    - 예금자 보호 대상: 두 상품 모두 예금자보호법에 따라 원금과 소정의 이자를 합하여 1인당 최고 5천만 원까지 보호받을 수 있습니다. 
    - 개인 대상 상품: 실명의 개인 고객이 가입할 수 있는 목돈 운용용 정기예금 상품입니다.  
    - 주거래 및 금융 거래 우대: 은행과의 거래 실적(카드 사용, 자동이체, 급여 및 연금 이체 등)과 연계하여 우대금리 혜택을 제공하는 구조를 가지고 있습니다.
    차이점  
    1. 계약 기간 및 운용 방식
    - 우리웰리치 주거래예금: 입금 건별로 예치 기간을 6개월 또는 1년 중 선택할 수 있습니다. 특히 하나의 계좌 안에서 추가 입금(50만 원 이상)이 가능하며, 추가된 건마다 각각 만기와 이자가 별도로 굴러가는 회전식·적립식 성격의 복합 구조를 지닙니다. 
    - 우리웰리치100예금(회전형): 가입 기간이 1년에서 최대 5년(연 단위)으로 설정됩니다. 매 1년마다 금리가 변동되는 회전식 정기예금으로, 은퇴(준비)자나 노후자금처럼 비교적 긴 호흡의 목돈을 한 번에 예치해 굴리는 데 초점을 맞추고 있습니다.  
    2. 추가 입금 기능 여부  
    - 우리웰리치 주거래예금: 최초 가입 이후 최장 10년 동안 자유로운 추가 입금(50만 원 이상)이 허용되어 여유 자금을 계속해서 같은 조건의 예금 계좌에 밀어 넣을 수 있습니다.  
    - 우리웰리치100예금(회전형): 추가 입금 기능이 없고, 최초 가입 시점에 일시불로 납입한 금액을 기준으로 운용됩니다.  
    3. 이자율 적용 및 변동 주기
    - 우리웰리치 주거래예금: 입금 건별로 입금일 당시 고시된 기본금리에 조건 충족 시 만기 시점에 우대금리가 가산되는 방식을 취합니다.  
    - 우리웰리치100예금(회전형): 매 1년(회전주기)마다 시장금리를 반영하여 이자율이 새롭게 변동되는 구조를 가집니다. 금리 상승기에는 유리하고 하락기에는 금리가 조정될 수 있는 회전식 금리 체계입니다.  
    4. 주요 우대금리 조건의 성격  
    - 우리웰리치 주거래예금: 가계대출 이용, 주거래 우대 조건(급여/연금 이체, 공과금 자동이체, 카드 결제 계좌 등 중 2가지 이상 충족), 첫 거래 여부 등에 따라 입금 건별 만기 시 0.2%p 수준의 우대금리를 제공합니다.  
    - 우리웰리치100예금(회전형): 연금 이체 실적, 만기자금 재예치, 신용/체크카드 보유, 인터넷/스마트뱅킹 신규 가입 등의 은퇴자 및 디지털 거래 친화적 조건들에 따라 우대금리가 적용됩니다.  
""";
  }
}
