import 'dart:math';
import 'package:collection/collection.dart';
import 'package:finbrain/data/model/entities/annuity_savings_option.dart';
import 'package:finbrain/data/model/entities/credit_loan_option.dart';
import 'package:finbrain/data/model/entities/deposit_and_installment_savings_option.dart';
import 'package:finbrain/data/model/entities/mortage_and_rent_loan_option.dart';
import 'package:finbrain/product_categories.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'calculator_screen_viewmodel.g.dart';

@riverpod
class CalculatorScreenViewmodel extends _$CalculatorScreenViewmodel {
  @override
  List<double> build() => [];

  List<double> returnRate(
    ProductCategory category,
    List<Object> options,
    Map<String, String> selectedValues,
  ) {
    final keys = selectedValues.keys.toList();
    switch (category) {
      case ProductCategory.deposit:
        final option = options
            .where(
              (e) =>
                  "${(e as DepositAndInstallmentSavingsOption).saveTerm}개월" ==
                      selectedValues[keys[0]] &&
                  e.intRateTypeName == selectedValues[keys[1]],
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
        final option = options
            .where(
              (e) =>
                  (e as DepositAndInstallmentSavingsOption).reserveTypeName ==
                      selectedValues[keys[0]] &&
                  "${e.saveTerm}개월" == selectedValues[keys[1]] &&
                  e.intRateTypeName == selectedValues[keys[2]],
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
      case ProductCategory.credit:
        // todo: change later
        final foundOption = options
            .where(
              (e) => (e as CreditLoanOption).creditLendRateTypeName == "대출금리",
            )
            .firstOrNull;
        if (foundOption == null) return [];
        final rates = [
          (foundOption as CreditLoanOption).gradeOver900,
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
      default:
        if (category == ProductCategory.mortgage ||
            category == ProductCategory.rent) {
          // todo: change later
          final min = options
              .map((e) => (e as MortageAndRentLoanOption).lendRateMin)
              .whereType<double>()
              .min;
          final max = options
              .map((e) => (e as MortageAndRentLoanOption).lendRateMax)
              .whereType<double>()
              .max;
          final avg = options
              .map((e) => (e as MortageAndRentLoanOption).lendRateAvg)
              .whereType<double>()
              .average;
          return [min, avg, max];
        } else {
          return [];
        }
    }
  }

  Map<String, dynamic> returnResult(
    int principal,
    double? rate,
    int term,
    int? savedTerm,
    String type,
    ProductCategory category,
    List<Object> options,
    Map<String, String> selectedValues,
  ) {
    final keys = selectedValues.keys.toList();
    if (category != ProductCategory.annuity && rate == null) {
      return {};
    }
    final monthlyRate = (rate! / 100) / 12;
    switch (category) {
      case ProductCategory.deposit:
        final interest = (type == "단리")
            ? principal * monthlyRate * term
            : principal * (pow((1 + monthlyRate), term) - 1);
        final tax = interest * 0.154;
        final interestAfterTax = interest - tax;
        return {
          "예치금": principal,
          "이자": interest.floorToDouble(),
          "세후 이자(15.4%)": interestAfterTax.floorToDouble(),
          "만기수령액": principal + interestAfterTax.floorToDouble(),
        };
      case ProductCategory.installment:
        double interest = 0.0;
        final monthlyDeposit = principal;
        final totalPrincipal = monthlyDeposit * term;
        if (type == "단리 정액적립식") {
          interest = monthlyDeposit * monthlyRate * (term * (term + 1) / 2);
        } else if (type == "복리 정액적립식") {
          final totalAmount =
              monthlyDeposit *
              (1 + monthlyRate) *
              (pow(1 + monthlyRate, term) - 1) /
              monthlyRate;
          interest = totalAmount - totalPrincipal;
        } else if (type == "단리 자유적립식") {
          final remainingTerm = term - savedTerm!;
          interest = monthlyDeposit * monthlyRate * remainingTerm;
        } else {
          final remainingTerm = term - savedTerm!;
          final totalAmount =
              monthlyDeposit * pow(1 + monthlyRate, remainingTerm);
          interest = totalAmount - monthlyDeposit.toDouble();
        }
        final tax = interest * 0.154;
        final interestAfterTax = interest - tax;
        return {
          "총 납입원금": type.contains("자유적립식") ? principal : totalPrincipal,
          "총 이자": interest.floorToDouble(),
          "세후 이자(15.4%)": interestAfterTax.floorToDouble(),
          "만기수령액":
              ((type.contains("자유적립식") ? principal : totalPrincipal) +
                      interestAfterTax)
                  .floorToDouble(),
        };
      case ProductCategory.annuity:
        final option = options
            .where(
              (e) =>
                  (e as AnnuitySavingsOption).monthlyPaymentName ==
                      selectedValues[keys[0]] &&
                  e.receiptTermName == selectedValues[keys[1]] &&
                  e.paymentPeriodName == selectedValues[keys[2]] &&
                  e.entryAgeName == selectedValues[keys[3]] &&
                  e.startAgeName == selectedValues[keys[4]],
            )
            .toList();
        if ((option as List<AnnuitySavingsOption>).isNotEmpty) {
          return {
            "월 납입 금액": selectedValues[keys[0]],
            "연금 수령 기간": selectedValues[keys[1]],
            "납입 기간": selectedValues[keys[2]],
            "가입 연령": selectedValues[keys[3]],
            "개시 연령": selectedValues[keys[4]],
            "예상 수령액": option.first.monthlyReceiptAmount,
          };
        } else {
          return {};
        }
      default:
        final num = List.generate(term, (index) => index + 1);
        List<double> monthlyPaymentList = []; // 월 납입금(원금 + 이자)
        List<double> repaidPrincipalList = []; // 상환한 원금
        List<double> interestList = []; // 매달 이자
        List<double> remainingBalanceList = []; // 대출 잔액
        switch (type) {
          case "원리금균등상환방식":
            for (final currentMonth in num) {
              double monthlyPayment =
                  principal *
                  monthlyRate *
                  pow(1 + monthlyRate, term) /
                  (pow(1 + monthlyRate, term) - 1);
              double previousBalance =
                  principal *
                  (pow(1 + monthlyRate, term) -
                      pow(1 + monthlyRate, currentMonth - 1)) /
                  (pow(1 + monthlyRate, term) - 1);
              double interest = previousBalance * monthlyRate;
              double repaidPrincipal = monthlyPayment - interest;
              double remainingBalance = previousBalance - repaidPrincipal;
              monthlyPaymentList.add(monthlyPayment.floorToDouble());
              interestList.add(interest.floorToDouble());
              repaidPrincipalList.add(repaidPrincipal.floorToDouble());
              remainingBalanceList.add(remainingBalance.floorToDouble());
            }
            break;
          case "원금균등상환방식":
            for (final currentMonth in num) {
              double repaidPrincipal = principal / term;
              double previousBalance =
                  principal - (repaidPrincipal * (currentMonth - 1));
              double interest = previousBalance * monthlyRate;
              double monthlyPayment = repaidPrincipal + interest;
              double remainingBalance = previousBalance - repaidPrincipal;
              repaidPrincipalList.add(repaidPrincipal.floorToDouble());
              interestList.add(interest.floorToDouble());
              monthlyPaymentList.add(monthlyPayment.floorToDouble());
              remainingBalanceList.add(remainingBalance.floorToDouble());
            }
            break;
          // 만기일시상환방식
          default:
            final interest = principal * monthlyRate;
            interestList = List.generate(
              term,
              (index) => interest.floorToDouble(),
            );
            repaidPrincipalList = List.generate(term - 1, (index) => 0.0);
            repaidPrincipalList.add(principal.floorToDouble());
            monthlyPaymentList = List.generate(
              term - 1,
              (index) => interest.floorToDouble(),
            );
            monthlyPaymentList.add((interest + principal).floorToDouble());
            remainingBalanceList = List.generate(
              term - 1,
              (index) => principal.floorToDouble(),
            );
            remainingBalanceList.add(0.0);
        }
        return {
          "회차": num,
          "월 납입금": monthlyPaymentList,
          "상환 원금": repaidPrincipalList,
          "이자": interestList,
          "대출 잔액": remainingBalanceList,
        };
    }
  }
}
