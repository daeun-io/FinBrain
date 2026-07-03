import 'package:finbrain/data/model/entities/ai_summary.dart';
import 'package:finbrain/themes/colors.dart';
import 'package:flutter/material.dart';

class SummaryArchiveScreen extends StatefulWidget {
  const SummaryArchiveScreen({super.key});

  @override
  State<StatefulWidget> createState() => _SummaryArchiveScreenState();
}

class _SummaryArchiveScreenState extends State<SummaryArchiveScreen> {
  @override
  Widget build(BuildContext context) {
    final dummies = [
      AiSummary(
        productName: "im함께예금",
        isExpanded: false,
        chatSummaries: [
          ChatSummary(
            createdAt: DateTime(2026, 7, 3),
            summary: """### 1. 중도 해지 시 수령 금액 관련
*   **사용자 질문:** "만기 전에 해지하면 돈을 얼마나 돌려받나요?" (What much money will i get if i cancel before contract?)
*   **AI 핵심 답변:**
    *   **원금:** **100% 안전하게 돌려받습니다.** (원금 손실 전혀 없음)
    *   **이자:** 처음에 약속한 높은 이자 대신, 보유 기간에 따른 매우 낮은 **'중도해지 이자율'**이 
    적용되어 이자가 매우 적어집니다.
    *   **최종 돌려받는 금액:** `내가 넣은 원금` + `중도해지 이자 (세금 공제 후)`
    *   **💡 실시간 확인 방법:** 신한은행 앱(신한 SOL뱅크)의 **[해지 예상 조회]** 
    메뉴를 통해 실제 돌려받을 금액을 정확히 확인할 수 있습니다.

---

### 2. 상품 상세 정보 관련
*   **사용자 질문:** "이 상품에 대해 더 자세히 알려주세요." (Tell me more about it)
*   **AI 핵심 답변:**
    *   **상품 특징:** 복잡한 조건 없이 간단한 미션으로 보너스 우대 금리를 챙길 수 있는 대표 정기예금 상품입니다.
    *   **기본 정보:**
        *   **가입 대상:** 개인 고객 누구나
        *   **가입 금액:** 최소 10만 원 이상 (한도 제한 없음)
        *   **가입 기간:** 1개월 ~ 36개월 중 자유롭게 선택 가능
    *   **우대 조건 (최대 연 0.2%p 보너스 금리):**
        1.  **신규 고객 우대 (최대 연 0.1%p):** 최근 12개월간 신한은행 정기예금 미보유 시
        2.  **신한카드 사용 우대 (연 0.1%p):** 신한카드 결제 계좌를 신한은행으로 지정하고 사용 실적이 있을 시
    *   **안전성 (예금자보호):** 원금과 이자를 합해 **1인당 최고 5,000만 원까지** 법적으로 안전하게 보호됩니다.""",
          ),
          ChatSummary(
            createdAt: DateTime(2026, 7, 3),
            summary: """### 1. 상품 소개 및 특징
**Q. iM뱅크의 'iM함께예금'은 어떤 상품인가요?**
> **A.** 주변 사람과 함께 가입할수록 더 많은 이자를 받을 수 있는 **참여형 정기예금** 상품입니다.

* **기본 정보**
  * **상품 종류**: 정기예금 (만기일시지급식)
  * **가입 기간**: 1년 (12개월)
  * **가입 금액**: 최소 100만 원 ~ 최대 2,000만 원
  * **가입 대상**: 개인 고객 (1인 1계좌)

* **핵심 혜택 (우대금리 조건)**
  * **추천인 코드 공유**: 가족·친구와 추천인 코드를 서로 입력하면 우대금리 혜택을 받습니다.
  * **앱 이용 활성화**: iM뱅크 첫 거래 고객이거나 앱 로그인 등 간단한 활동 시 추가 보너스 금리가 제공됩니다.

---

### 2. 가입 방법 (인터넷/모바일)
**Q. 인터넷이나 스마트폰으로 가입할 수 있나요?**
> **A. 네, 가능합니다!** 본 상품은 은행 방문이 필요 없는 **비대면(온라인) 전용 상품**입니다. 스마트폰 앱을 이용하면 가장 쉽고 빠르게 가입할 수 있습니다.

* **모바일 앱 가입 단계**
  1. **앱 설치**: 스마트폰에서 **'iM뱅크'** 앱 다운로드 및 실행
  2. **상품 선택**: 상품몰에서 **'iM함께예금'** 선택
  3. **본인 인증**: 준비한 **신분증**(주민등록증 또는 운전면허증)을 촬영하여 본인 확인 후 가입 완료""",
          ),
        ],
      ),
      AiSummary(
        productName: "신한My플러스 정기예금",
        isExpanded: false,
        chatSummaries: [
          ChatSummary(
            createdAt: DateTime(2026, 7, 3),
            summary: """### 1. 중도 해지 시 수령 금액 관련
*   **사용자 질문:** "만기 전에 해지하면 돈을 얼마나 돌려받나요?" (What much money will i get if i cancel before contract?)
*   **AI 핵심 답변:**
    *   **원금:** **100% 안전하게 돌려받습니다.** (원금 손실 전혀 없음)
    *   **이자:** 처음에 약속한 높은 이자 대신, 보유 기간에 따른 매우 낮은 **'중도해지 이자율'**이 적용되어 이자가 매우 적어집니다.
    *   **최종 돌려받는 금액:** `내가 넣은 원금` + `중도해지 이자 (세금 공제 후)`
    *   **💡 실시간 확인 방법:** 신한은행 앱(신한 SOL뱅크)의 **[해지 예상 조회]** 메뉴를 통해 실제 돌려받을 금액을 정확히 확인할 수 있습니다.

---

### 2. 상품 상세 정보 관련
*   **사용자 질문:** "이 상품에 대해 더 자세히 알려주세요." (Tell me more about it)
*   **AI 핵심 답변:**
    *   **상품 특징:** 복잡한 조건 없이 간단한 미션으로 보너스 우대 금리를 챙길 수 있는 대표 정기예금 상품입니다.
    *   **기본 정보:**
        *   **가입 대상:** 개인 고객 누구나
        *   **가입 금액:** 최소 10만 원 이상 (한도 제한 없음)
        *   **가입 기간:** 1개월 ~ 36개월 중 자유롭게 선택 가능
    *   **우대 조건 (최대 연 0.2%p 보너스 금리):**
        1.  **신규 고객 우대 (최대 연 0.1%p):** 최근 12개월간 신한은행 정기예금 미보유 시
        2.  **신한카드 사용 우대 (연 0.1%p):** 신한카드 결제 계좌를 신한은행으로 지정하고 사용 실적이 있을 시
    *   **안전성 (예금자보호):** 원금과 이자를 합해 **1인당 최고 5,000만 원까지** 법적으로 안전하게 보호됩니다.""",
          ),
        ],
      ),
    ];

    return Container(
      color: Color(0xFFF4F4F4),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 24.0),
            ...dummies.map((item) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: ExpansionTile(
                    onExpansionChanged: (expanded) {
                      item.isExpanded = expanded;
                    },
                    initiallyExpanded: item.isExpanded,
                    backgroundColor: white,
                    collapsedBackgroundColor: white,
                    iconColor: textPrimary,
                    collapsedIconColor: textPrimary,
                    shape: const Border(),
                    title: Text(
                      item.productName,
                      style: const TextStyle(
                        fontSize: 14.0,
                        color: black,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    children: [
                      ...item.chatSummaries.map((chat) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.center,
                                child: Text(
                                  chat.createdAt.toIso8601String().split("T").first,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14.0,
                                    color: textSecondary,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8.0,),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  chat.summary,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14.0,
                                    color: black,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 12.0),
                            ],
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
