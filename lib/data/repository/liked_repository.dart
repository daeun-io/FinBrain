import 'package:finbrain/data/converter.dart';
import 'package:finbrain/data/data_source/liked_data_source.dart';
import 'package:finbrain/data/model/entities/financial_product.dart';
import 'package:finbrain/data/model/entities/deposit_and_installment_savings.dart';
import 'package:finbrain/data/model/entities/deposit_and_installment_savings_option.dart';
import 'package:finbrain/data/model/entities/isa_mp_benefit_rate.dart';
import 'package:finbrain/data/model/entities/isa_mp_benefit_rate_option.dart';
import 'package:finbrain/data/model/entities/mortgage_and_rent_loan.dart';
import 'package:finbrain/data/model/entities/mortgage_and_rent_loan_option.dart';
import 'package:finbrain/data/model/entities/credit_loan.dart';
import 'package:finbrain/data/model/entities/credit_loan_option.dart';
import 'package:finbrain/product_categories.dart';

class LikedRepository {
  final dataSource = LikedDataSource();

  // 금융 상품 관심 리스트에 저장하기
  // Save given financial product in liked list
  Future<void> saveProductAsLiked(String uid, FinancialProduct product) async {
    try {
      await dataSource.saveProductAsLiked(uid, product.toMap());
    } catch (e) {
      throw Exception("[error] failed to save product as liked : $e");
    }
  }

  // 금융 상품 관심 리스트에서 삭제하기
  // Delete given financial product in liked list
  Future<void> deleteProductInFirestore(String uid, String nmOrCd) async {
    try {
      await dataSource.deleteProductInFirestore(uid, nmOrCd);
    } catch (e) {
      throw Exception("[error] failed to delete liked product : $e");
    }
  }

  // 관심 상품 목록 리스트 불러오기
  // get all financial products in liked list
  Future<List<FinancialProduct>> getLikedProducts(String uid) async {
    try {
      final listOfMap = await dataSource.getLikedProducts(uid);
      final products = [];
      for (final map in listOfMap) {
        if (getCategoryEnum[map["category"]] == null) continue;
        // 카테고리에 맞는 클래스로 변환
        // convert data based on category
        switch (getCategoryEnum[map["category"]]) {
          case ProductCategory.deposit:
          case ProductCategory.installment:
            try {
              products.add(
                DepositAndInstallmentSavings(
                  category: getCategoryEnum[map["category"]]!,
                  submittedMonth: map["submittedMonth"],
                  companyCode: map["companyCode"],
                  companyName: map["companyName"],
                  productCode: map["productCode"],
                  productName: map["productName"],
                  startDay: map["startDay"],
                  endDay: map["endDay"],
                  submittedDay: map["submittedDay"],
                  joinWay: (map["joinWay"] as List<dynamic>).cast<String>(),
                  isLiked: map["isLiked"],
                  interestAfterExpiration: map["interestAfterExpiration"],
                  specialCondition: map["specialCondition"],
                  joinDeny: map["joinDeny"],
                  joinMember: map["joinMember"],
                  etc: map["etc"],
                  maxLimit: map["maxLimit"],
                  options: map["options"]
                      .map(
                        (e) => DepositAndInstallmentSavingsOption(
                          intRateType: e["intRateType"],
                          intRateTypeName: e["intRateTypeName"],
                          saveTerm: e["saveTerm"],
                          intRate: e["intRate"],
                          maxIntRate: e["maxIntRate"],
                          reserveType: e["reserveType"],
                          reserveTypeName: e["reserveTypeName"],
                        ),
                      )
                      .toList()
                      .cast<DepositAndInstallmentSavingsOption>(),
                ),
              );
              break;
            } catch (e) {
              throw Exception(
                "[error] failed to map deposit/installment product : $e",
              );
            }
          case ProductCategory.mortgage:
          case ProductCategory.rent:
            try {
              products.add(
                MortgageAndRentLoan(
                  category: getCategoryEnum[map["category"]]!,
                  submittedMonth: map["submittedMonth"],
                  companyCode: map["companyCode"],
                  companyName: map["companyName"],
                  productCode: map["productCode"],
                  productName: map["productName"],
                  startDay: map["startDay"],
                  endDay: map["endDay"],
                  submittedDay: map["submittedDay"],
                  joinWay: (map["joinWay"] as List<dynamic>).cast<String>(),
                  isLiked: map["isLiked"],
                  extraExpense: map["extraExpense"],
                  earlyRepayFee: map["earlyRepayFee"],
                  delayRate: map["delayRate"],
                  loanLimit: map["loanLimit"],
                  options: map["options"]
                      .map(
                        (e) => MortgageAndRentLoanOption(
                          loanType: e["loanType"],
                          loanTypeName: e["loanTypeName"],
                          repayType: e["repayType"],
                          repayTypeName: e["repayTypeName"],
                          lendRateType: e["lendRateType"],
                          lendRateTypeName: e["lendRateTypeName"],
                          lendRateMin: e["lendRateMin"],
                          lendRateMax: e["lendRateMax"],
                          lendRateAvg: e["lendRateAvg"],
                        ),
                      )
                      .toList()
                      .cast<MortgageAndRentLoanOption>(),
                ),
              );
            } catch (e) {
              throw Exception(
                "[error] failed to map mortgage/rent product : $e",
              );
            }
            break;
          case ProductCategory.credit:
            try {
              products.add(
                CreditLoan(
                  category: ProductCategory.credit,
                  submittedMonth: map["submittedMonth"],
                  companyCode: map["companyCode"],
                  companyName: map["companyName"],
                  productCode: map["productCode"],
                  productName: map["productName"],
                  startDay: map["startDay"],
                  endDay: map["endDay"],
                  submittedDay: map["submittedDay"],
                  joinWay: (map["joinWay"] as List<dynamic>).cast<String>(),
                  isLiked: map["isLiked"],
                  productType: map["productType"],
                  productTypeName: map["productTypeName"],
                  cbName: map["cbName"],
                  options: map["options"]
                      .map(
                        (e) => CreditLoanOption(
                          creditLendRateType: e["creditLendRateType"],
                          creditLendRateTypeName: e["creditLendRateTypeName"],
                          gradeOver900: e["gradeOver900"],
                          grade801900: e["grade801900"],
                          grade701800: e["grade701800"],
                          grade601700: e["grade601700"],
                          grade501600: e["grade501600"],
                          grade401500: e["grade401500"],
                          grade301400: e["grade301400"],
                          gradeUnder300: e["gradeUnder300"],
                          averageGrade: e["averageGrade"],
                        ),
                      )
                      .toList()
                      .cast<CreditLoanOption>(),
                ),
              );
            } catch (e) {
              throw Exception("[error] failed to map credit product : $e");
            }
            break;
          default:
            try {
              products.add(
                IsaMpBenefitRate(
                  category: ProductCategory.isaMp,
                  companyName: map["companyName"],
                  productName: map["productName"],
                  releaseDate: map["releaseDate"],
                  isLiked: map["isLiked"],
                  baseDate: map["baseDate"],
                  businessDomain: map["businessDomain"],
                  mpType: map["mpType"],
                  options: map["options"]
                      .map(
                        (e) => IsaMpBenefitRateOption(
                          term: e["term"],
                          benefitRate: e["benefitRate"],
                        ),
                      )
                      .toList()
                      .cast<IsaMpBenefitRateOption>(),
                ),
              );
            } catch (e) {
              throw Exception("[error] failed to map isa mp product : $e");
            }
        }
      }
      return products.cast<FinancialProduct>();
    } catch (e) {
      throw Exception("[error] failed to fetch liked products : $e");
    }
  }
}
