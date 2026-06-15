import 'package:finbrain/data/model/entities/annuity_savings_option.dart';
import 'package:finbrain/data/model/entities/deposit_and_installment_savings_option.dart';
import 'package:finbrain/ui/product_categories.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'product_detail_screen_viewmodel.g.dart';

@riverpod
class ProductDetailScreenViewmodel extends _$ProductDetailScreenViewmodel {
  Map<String, List<String>> build() => {};

  Map<String, List<String>> mapProductOptions(
    ProductCategory category,
    List<dynamic> options,
  ) {
    List<String> keys = switch (category) {
      ProductCategory.deposit => ["예치 기간", "저축 금리 유형"],
      ProductCategory.installment => ["예치 종류", "예치 기간", "저축 금리 유형"],
      ProductCategory.annuity => [
        "월 납입 금액",
        "연금 수령 기간",
        "납입 기간",
        "가입 연령",
        "개시 연령",
      ],
      _ => ["상환 방법"],
    };
    final values = [];
    switch (category) {
      case ProductCategory.deposit:
        values.add(
          List.of(
            (options as List<DepositAndInstallmentSavingsOption>)
                .map((e) => "${e.saveTerm}개월")
                .toSet()
                .toList(),
          ),
        );
        values.add(
          List.of(options.map((e) => e.intRateTypeName!).toSet().toList()),
        );
      case ProductCategory.installment:
        values.add(
          List.of(
            (options as List<DepositAndInstallmentSavingsOption>)
                .map((e) => e.reserveTypeName!)
                .toSet()
                .toList(),
          ),
        );
        values.add(
          List.of(options.map((e) => "${e.saveTerm}개월").toSet().toList()),
        );
        values.add(
          List.of(options.map((e) => e.intRateTypeName!).toSet().toList()),
        );
      case ProductCategory.annuity:
        values.add(
          List.of(
            (options as List<AnnuitySavingsOption>)
                .map((e) => e.monthlyPaymentName!)
                .toSet()
                .toList(),
          ),
        );
        values.add(
          List.of(options.map((e) => e.receiptTermName!).toSet().toList()),
        );
        values.add(
          List.of(options.map((e) => e.paymentPeriodName!).toSet().toList()),
        );
        values.add(
          List.of(options.map((e) => e.entryAgeName!).toSet().toList()),
        );
        values.add(
          List.of(options.map((e) => e.startAgeName!).toSet().toList()),
        );
      default:
        values.add(["원리금균등상환방식", "원금균등상환방식", "만기일시상환방식"]);
    }

    Map<String, List<String>> map = {
      for (var i = 0; i < keys.length; i++) keys[i]: values[i],
    };
    return map;
  }
}
