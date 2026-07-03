import 'package:finbrain/data/model/entities/ai_record.dart';
import 'package:finbrain/product_categories.dart';
import 'package:finbrain/themes/colors.dart';
import 'package:finbrain/ui/widget/archive_list.dart';
import 'package:flutter/material.dart';

class ComparisonArchiveScreen extends StatefulWidget {
  const ComparisonArchiveScreen({super.key});

  @override
  State<StatefulWidget> createState() => _ComparisonArchiveScreenState();
}

class _ComparisonArchiveScreenState extends State<StatefulWidget> {
  Set<ProductCategory> filters = {};
  final dummies = [
    AiRecord(
      isPinned: false,
      isExpanded: false,
      key: "신한My플러스 정기예금 vs. KDB정기예금",
      value: [
        AiText(
          createdAt: DateTime(2026, 7, 3),
          text: """신한은행 대표 예금 vs KDB 정기예금 비교
신한은행의 대표적인 고금리 예금 상품인 신한My플러스 정기예금과 산업은행의 대표 상품인 **KDB 정기예금(KDB Hi 정기예금 기준)을 비교 분석해 드리겠습니다.
두 상품은 각각 일반 시중은행의 우대금리형 상품과 국책은행의 조건 없는 고금리 상품이라는 뚜렷한 차이점을 가지고 있습니다.

1. [신한My플러스 정기예금 vs KDB 정기예금] 비교표
이율은 작성일 기준(2024년 상반기 시장금리 반영)이며, 금리는 시장 상황에 따라 변동될 수 있으므로 가입 시점의 최종 확인이 필요합니다.

2. 상품별 상세 분석
① 신한My플러스 정기예금 (신한은행)
특징
신한은행을 주로 이용하는 고객이거나, 신한은행에 처음 돈을 예치하는 고객에게 유리한 우대금리 맞춤형 상품입니다.
장점
우대 조건의 직관성
타사 대비 우대금리 조건(입출금 평잔 유지 등)이 비교적 달성하기 쉽습니다.
모바일 편의성
신한 SOL뱅크 앱의 UI/UX가 매우 편리하여 가입 및 관리가 쉽습니다.
소액 가입 가능
최소 가입 금액이 50만 원으로 낮아 소액 재테크에 유리합니다.
단점
한도 제한
1인당 최대 1억 원까지만 가입이 가능하여 거액 자산가에게는 아쉬울 수 있습니다.
우대조건 미충족 시 저금리
우대 조건을 충족하지 못하면 기본 금리가 낮아 매력도가 떨어집니다.

② KDB 정기예금 (KDB Hi 정기예금)
특징
조건 없는 깔끔한 고금리를 지향하는 국책은행(산업은행)의*비대면 전용 상품입니다.
장점
조건 없는 고금리
복잡한 우대금리 조건(카드 실적, 첫 거래 등) 없이 누구나 가입만 하면 최고 금리를 받을 수 있습니다.
가입 한도 무제한
최대 가입 금액 제한이 없어 1억 원 이상의 목돈을 한 번에 예치하기 가장 적합합니다.
높은 안정성
국가가 재정을 뒷받침하는 국책은행이므로, 사실상 시중은행보다 안정성이 높습니다.
단점
비대면 전용
스마트폰이나 인터넷뱅킹 이용이 어려운 고령층에게는 가입 장벽이 있을 수 있습니다.
최소 가입금액
최소 가입 금액이 100만 원으로 신한은행보다 높습니다.
연계 서비스 부족
일반 시중은행에 비해 주거래 은행으로서의 혜택(수수료 면제 등)이 다양하지 않습니다.

3. 최종 요약 및 추천
신한My플러스 정기예금 추천 대상
이미 신한은행을 주거래 은행으로 사용하고 계신 분
모바일 앱 편의성을 중요하게 생각하며 1억 원 이하의 금액을 굴리고자 하는 분
신한은행 입출금 통장에 평잔을 유지할 여력이 있어 우대금리를 쉽게 받을 수 있는 분
KDB 정기예금 추천 대상
복잡한 우대조건(자동이체, 카드 실적 등)을 신경 쓰기 귀찮고 심플하게 최고 금리를 받고 싶은 분
1억 원 이상의 목돈을 예치할 계획이 있는 분
주거래은행 혜택보다 높은 금리를 우선하는 분
""",
        ),
      ],
    ),
    AiRecord(
      isPinned: false,
      isExpanded: false,
      key: "신한My플러스 정기예금 vs. KDB정기예금",
      value: [
        AiText(
          createdAt: DateTime(2026, 7, 3),
          text: """신한은행 대표 예금 vs KDB 정기예금 비교
신한은행의 대표적인 고금리 예금 상품인 신한My플러스 정기예금과 산업은행의 대표 상품인 **KDB 정기예금(KDB Hi 
두 상품은 각각 일반 시중은행의 우대금리형 상품과 국책은행의 조건 없는 고금리 상품이라는 뚜렷한 차이점을 가지


1. [신한My플러스 정기예금 vs KDB 정기예금] 비교표
이율은 작성일 기준(2024년 상반기 시장금리 반영)이며, 금리는 시장 상황에 따라 변동될 수 있으므로 가입 시점의 


2. 상품별 상세 분석
① 신한My플러스 정기예금 (신한은행)
특징
신한은행을 주로 이용하는 고객이거나, 신한은행에 처음 돈을 예치하는 고객에게 유리한 우대금리 맞춤형 상품입니
장점
우대 조건의 직관성
타사 대비 우대금리 조건(입출금 평잔 유지 등)이 비교적 달성하기 쉽습니다.
모바일 편의성
신한 SOL뱅크 앱의 UI/UX가 매우 편리하여 가입 및 관리가 쉽습니다.
소액 가입 가능
최소 가입 금액이 50만 원으로 낮아 소액 재테크에 유리합니다.
단점
한도 제한
1인당 최대 1억 원까지만 가입이 가능하여 거액 자산가에게는 아쉬울 수 있습니다.
우대조건 미충족 시 저금리
우대 조건을 충족하지 못하면 기본 금리가 낮아 매력도가 떨어집니다.


② KDB 정기예금 (KDB Hi 정기예금)
특징
조건 없는 깔끔한 고금리를 지향하는 국책은행(산업은행)의*비대면 전용 상품입니다.
장점
조건 없는 고금리
복잡한 우대금리 조건(카드 실적, 첫 거래 등) 없이 누구나 가입만 하면 최고 금리를 받을 수 있습니다.
가입 한도 무제한
최대 가입 금액 제한이 없어 1억 원 이상의 목돈을 한 번에 예치하기 가장 적합합니다.
높은 안정성
국가가 재정을 뒷받침하는 국책은행이므로, 사실상 시중은행보다 안정성이 높습니다.
단점
비대면 전용
스마트폰이나 인터넷뱅킹 이용이 어려운 고령층에게는 가입 장벽이 있을 수 있습니다.
최소 가입금액
최소 가입 금액이 100만 원으로 신한은행보다 높습니다.
연계 서비스 부족
일반 시중은행에 비해 주거래 은행으로서의 혜택(수수료 면제 등)이 다양하지 않습니다.


3. 최종 요약 및 추천
신한My플러스 정기예금 추천 대상
이미 신한은행을 주거래 은행으로 사용하고 계신 분
모바일 앱 편의성을 중요하게 생각하며 1억 원 이하의 금액을 굴리고자 하는 분
신한은행 입출금 통장에 평잔을 유지할 여력이 있어 우대금리를 쉽게 받을 수 있는 분
KDB 정기예금 추천 대상
복잡한 우대조건(자동이체, 카드 실적 등)을 신경 쓰기 귀찮고 심플하게 최고 금리를 받고 싶은 분
1억 원 이상의 목돈을 예치할 계획이 있는 분
주거래은행 혜택보다 높은 금리를 우선하는 분
""",
        ),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFFF4F4F4),
      padding: EdgeInsets.only(
        top: 24.0,
        left: 20.0,
        right: 20.0,
        bottom: 20.0,
      ),
      child: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              spacing: 8.0,
              children: ProductCategory.values.map((e) {
                return FilterChip(
                  onSelected: (selected) {
                    setState(() {
                      if (selected) {
                        filters.add(e);
                      } else {
                        filters.remove(e);
                      }
                    });
                  },
                  selected: filters.contains(e),
                  selectedColor: primary700,
                  backgroundColor: white,
                  checkmarkColor: white,
                  label: Text(
                    switch (e) {
                      ProductCategory.deposit => "정기예금",
                      ProductCategory.installment => "적금",
                      ProductCategory.mortage => "주택담보대출",
                      ProductCategory.rent => "전세자금대출",
                      ProductCategory.credit => "개인신용대출",
                      ProductCategory.annuity => "연금저축",
                      _ => "ISA",
                    },
                    style: (filters.contains(e))
                        ? const TextStyle(
                            color: white,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w600,
                          )
                        : const TextStyle(
                            color: black,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w400,
                          ),
                  ),
                );
              }).toList(),
            ),
          ),
          Expanded(
            child: ArchiveList(
              ctg: ArchiveCategory.comparison,
              records: dummies,
            ),
          ),
        ],
      ),
    );
  }
}
