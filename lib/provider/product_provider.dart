import 'package:finbrain/data/dummy_data.dart';
import 'package:finbrain/data/model/entities/annuity_savings.dart';
import 'package:finbrain/data/model/entities/credit_loan.dart';
import 'package:finbrain/data/model/entities/deposit_and_installment_savings.dart';
import 'package:finbrain/data/model/entities/financial_product.dart';
import 'package:finbrain/data/model/entities/mortage_and_rent_loan.dart';
import 'package:finbrain/ui/product_categories.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'product_provider.g.dart';

@riverpod
class ProductNotifier extends _$ProductNotifier {
  @override
  List<FinancialProduct> build(){
    return dummyData;
  }

  void toggleLiked(String productName) {
    state = state.map((e){
      if(e.commonInfo.productName == productName){
        return e.copyWith(!e.commonInfo.isLiked);
      }
      return e;
    }).toList();
  }

  void sortByCriteria(String criteria, ProductCategory category) {
    switch (category) {
      case ProductCategory.deposit:
      case ProductCategory.installment:
        final sorted = [...state]
          ..sort(
            (criteria == "최고 금리(높은 순)")
                ? (a, b) => (b as DepositAndInstallmentSavings)
                      .returnHighestRateValue()
                      .$1
                      .compareTo(
                        (a as DepositAndInstallmentSavings)
                            .returnHighestRateValue()
                            .$1,
                      )
                : (a, b) => (b as DepositAndInstallmentSavings)
                      .returnHighestRateValue()
                      .$2
                      .compareTo(
                        (a as DepositAndInstallmentSavings)
                            .returnHighestRateValue()
                            .$2,
                      ),
          );
        state = sorted;
        break;
      case ProductCategory.annuity:
        final sorted = [...state]
          ..sort(switch (criteria) {
            "평균 수익률(높은 순)" =>
              (a, b) => (b as AnnuitySavings).returnProfits()[0].compareTo(
                (a as AnnuitySavings).returnProfits()[0],
              ),
            "전년도 수익률(높은 순)" =>
              (a, b) => (b as AnnuitySavings).returnProfits()[1].compareTo(
                (a as AnnuitySavings).returnProfits()[1],
              ),
            "전전년도 수익률(높은 순)" =>
              (a, b) => (b as AnnuitySavings).returnProfits()[2].compareTo(
                (a as AnnuitySavings).returnProfits()[2],
              ),
            _ => (a, b) => (b as AnnuitySavings).returnProfits()[3].compareTo(
              (a as AnnuitySavings).returnProfits()[3],
            ),
          });
        state = sorted;
        break;
      case ProductCategory.mortage:
      case ProductCategory.rent:
        final sorted = [...state]
          ..sort(switch (criteria) {
            "최저 금리(낮은 순)" =>
              (a, b) => (b as MortageAndRentLoan).returnRates()[0].compareTo(
                (a as MortageAndRentLoan).returnRates()[0],
              ),
            "최고 금리(낮은 순)" =>
              (a, b) => (b as MortageAndRentLoan).returnRates()[2].compareTo(
                (a as MortageAndRentLoan).returnRates()[2],
              ),
            _ => (a, b) => (b as MortageAndRentLoan).returnRates()[1].compareTo(
              (a as MortageAndRentLoan).returnRates()[1],
            ),
          });
        state = sorted;
        break;
      case ProductCategory.credit:
        final sorted = [...state]
          ..sort(switch (criteria) {
            "최저 금리(낮은 순)" =>
              (a, b) => (b as CreditLoan).returnRates()[0].compareTo(
                (a as CreditLoan).returnRates()[0],
              ),
            "최고 금리(낮은 순)" =>
              (a, b) => (b as CreditLoan).returnRates()[2].compareTo(
                (a as CreditLoan).returnRates()[2],
              ),
            _ => (a, b) => (b as CreditLoan).returnRates()[1].compareTo(
              (a as CreditLoan).returnRates()[1],
            ),
          });
        state = sorted;
        break;
      // todo: implement later
      default: state = dummyData;
    }
  }
}
