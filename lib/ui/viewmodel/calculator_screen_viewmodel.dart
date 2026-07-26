import 'dart:math';
import 'package:collection/collection.dart';
import 'package:finbrain/data/model/entities/credit_loan_option.dart';
import 'package:finbrain/data/model/entities/deposit_and_installment_savings_option.dart';
import 'package:finbrain/data/model/entities/mortgage_and_rent_loan_option.dart';
import 'package:finbrain/product_categories.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'calculator_screen_viewmodel.g.dart';

@riverpod
class CalculatorScreenViewmodel extends _$CalculatorScreenViewmodel {
  @override
  List<double> build() => [];

  // 주어진 옵션에 대해 대응하는 이자 반환
  // Return interests based on given option
  List<double> returnRate(
    ProductCategory category,
    List<Object> options,
    Map<String, String> selectedValues,
  ) {
    final keys = selectedValues.keys.toList();
    switch (category) {
      // 선택한 기간에 따른 기본 금리와 최대 금리 반환
      // return base and max interest based on chosen period
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
      // 대출 금리 중 최소, 최대, 평균 금리 반환
      // return minimum, maximum and average interest
      case ProductCategory.credit:
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

        if (rates.isNotEmpty) {
          final avgRates = foundOption.averageGrade;
          final min = rates.min;
          final max = rates.max;
          final avg = (avgRates != null) ? avgRates : rates.average;
          return [min, avg, max];
        } else {
          return [];
        }
      case ProductCategory.mortgage:
      case ProductCategory.rent:
        final min = options
            .map((e) => (e as MortgageAndRentLoanOption).lendRateMin)
            .whereType<double>()
            .min;
        final max = options
            .map((e) => (e as MortgageAndRentLoanOption).lendRateMax)
            .whereType<double>()
            .max;
        final avg = options
            .map((e) => (e as MortgageAndRentLoanOption).lendRateAvg)
            .whereType<double>()
            .average;
        return [min, avg, max];
      default:
        return [];
    }
  }

  // 계산 결과 반환
  // Return calculate result
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
    // 연 이자를 월 이자로 변경
    // change yearly interst to monthly interest
    final monthlyRate = (rate ?? 0 / 100) / 12;
    switch (category) {
      case ProductCategory.deposit:
        final interest = (type == "단리")
            ? principal * monthlyRate * term
            : principal * (pow((1 + monthlyRate), term) - 1);
        final tax = interest * 0.154;
        final interestAfterTax = interest - tax;
        return {
          "예치금": principal,
          "이자": interest.toInt(),
          "세후 이자(15.4%)": interestAfterTax.toInt(),
          "만기수령액": principal + interestAfterTax.toInt(),
        };
      case ProductCategory.installment:
        double interest = 0.0;
        final monthlyDeposit = principal;
        final totalPrincipal = monthlyDeposit * term;
        if (type.contains("단리")) {
          interest = monthlyDeposit * monthlyRate * (term * (term + 1) / 2);
        } else {
          final totalAmount =
              monthlyDeposit *
              (1 + monthlyRate) *
              (pow(1 + monthlyRate, term) - 1) /
              monthlyRate;
          interest = totalAmount - totalPrincipal;
        }
        final tax = interest * 0.154;
        final interestAfterTax = interest - tax;
        return {
          "총 납입원금": totalPrincipal,
          "총 이자": interest.toInt(),
          "세후 이자(15.4%)": interestAfterTax.toInt(),
          "만기수령액": (totalPrincipal + interestAfterTax).toInt(),
        };
      default:        // 대출(loan)
        final num = List.generate(term, (index) => index + 1);
        List<int> monthlyPaymentList = [];        // 월 납입금(원금 + 이자)
        List<int> repaidPrincipalList = [];       // 상환한 원금
        List<int> interestList = [];              // 매달 이자
        List<int> remainingBalanceList = [];      // 대출 잔액
        switch (type) {
          case "원리금균등상환방식":                   // full amortization
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
              monthlyPaymentList.add(monthlyPayment.toInt());
              interestList.add(interest.toInt());
              repaidPrincipalList.add(repaidPrincipal.toInt());
              remainingBalanceList.add(remainingBalance.toInt());
            }
            break;
          case "원금균등상환방식":                   // even repayment of principal
            for (final currentMonth in num) {
              double repaidPrincipal = principal / term;
              double previousBalance =
                  principal - (repaidPrincipal * (currentMonth - 1));
              double interest = previousBalance * monthlyRate;
              double monthlyPayment = repaidPrincipal + interest;
              double remainingBalance = previousBalance - repaidPrincipal;
              repaidPrincipalList.add(repaidPrincipal.toInt());
              interestList.add(interest.toInt());
              monthlyPaymentList.add(monthlyPayment.toInt());
              remainingBalanceList.add(remainingBalance.toInt());
            }
            break;
          default:                   // 만기일시상환방식: bullet payment
            final interest = principal * monthlyRate;
            interestList = List.generate(term, (index) => interest.toInt());
            repaidPrincipalList = List.generate(term - 1, (index) => 0);
            repaidPrincipalList.add(principal.toInt());
            monthlyPaymentList = List.generate(
              term - 1,
              (index) => interest.toInt(),
            );
            monthlyPaymentList.add((interest + principal).toInt());
            remainingBalanceList = List.generate(
              term - 1,
              (index) => principal.toInt(),
            );
            remainingBalanceList.add(0);
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
