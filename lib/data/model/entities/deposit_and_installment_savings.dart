import 'package:finbrain/data/model/entities/common_info.dart';
import 'package:finbrain/data/model/entities/deposit_and_installment_savings_option.dart';

// 정기예금, 적금
class DepositAndInstallmentSavings {
  // 프로퍼티명(필드명): 의미
  // commonInfo: 공통 정보
  // interestAfterExpiration(mrnt_int): 만기 후 이자율
  // specialCondition(spcl_cnd): 우대조건
  // joinDeny(join_deny): 가입 제한 - 추후 수정
  // joinMember(join_member): 가입 대상
  // etc(etc_note): 기타 주의사항
  // options: 옵션 목록

  final CommonInfo commonInfo;
  final String? interestAfterExpiration;
  final String? specialCondition;
  final String? joinDeny;
  final String? joinMember;
  final String? etc;
  final String? maxLimit;
  final List<DepositAndInstallmentSavingsOption>? options;

  DepositAndInstallmentSavings(
    this.commonInfo,
    this.interestAfterExpiration,
    this.specialCondition,
    this.joinDeny,
    this.joinMember,
    this.etc,
    this.maxLimit,
    this.options
  );
}