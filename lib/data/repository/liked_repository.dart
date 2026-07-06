import 'package:finbrain/data/converter.dart';
import 'package:finbrain/data/data_source/liked_data_source.dart';
import 'package:finbrain/data/model/entities/financial_product.dart';
import 'package:finbrain/data/model/entities/deposit_and_installment_savings.dart';
import 'package:finbrain/data/model/entities/deposit_and_installment_savings_option.dart';
import 'package:finbrain/data/model/entities/isa_mp_benefit_rate.dart';
import 'package:finbrain/data/model/entities/isa_mp_benefit_rate_option.dart';
import 'package:finbrain/data/model/entities/mortage_and_rent_loan.dart';
import 'package:finbrain/data/model/entities/mortage_and_rent_loan_option.dart';
import 'package:finbrain/data/model/entities/credit_loan.dart';
import 'package:finbrain/data/model/entities/credit_loan_option.dart';
import 'package:finbrain/data/model/entities/annuity_savings.dart';
import 'package:finbrain/data/model/entities/annuity_savings_option.dart';

import 'package:finbrain/product_categories.dart';

class LikedRepository {
  final dataSource = LikedDataSource();

  Future<void> saveProductAsLiked(String uid, FinancialProduct product) async {
    try {
      await dataSource.saveProductAsLiked(uid, product.toMap());
    } catch (e) {
      print("Error saving liked product: $e");
    }
  }

  Future<void> deleteProductInFirestore(String uid, String productName) async {
    try {
      await dataSource.deleteProductInFirestore(uid, productName);
    } catch (e) {
      print("Error deleting liked product: $e");
    }
  }

  Future<List<FinancialProduct>> getLikedProducts(String uid) async {
    try {
      final listOfMap = await dataSource.getLikedProducts(uid);
      final products = [];
      for (final map in listOfMap) {
        if (getCategoryEnum[map["category"]] == null) continue;
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
              print("error occured while mapping map to data $e");
            }
          case ProductCategory.mortage:
          case ProductCategory.rent:
            products.add(
              MortageAndRentLoan(
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
                      (e) => MortageAndRentLoanOption(
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
                    .cast<MortageAndRentLoanOption>(),
              ),
            );
            break;
          case ProductCategory.credit:
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
            break;
          case ProductCategory.annuity:
            try {
              products.add(
                AnnuitySavings(
                  category: ProductCategory.annuity,
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
                  pensionKind: map["pensionKind"],
                  pensionKindName: map["pensionKindName"],
                  saleStartDay: map["saleStartDay"],
                  maintenanceCount: map["maintenanceCount"],
                  productType: map["productType"],
                  productTypeName: map["productTypeName"],
                  averageProfit: double.tryParse(map["averageProfit"]),
                  declaredRate: map["declaredRate"],
                  guaranteedRate: map["guaranteedRate"],
                  pyProfitRate: double.tryParse(map["pyProfitRate"]),
                  ppyProfitRate: double.tryParse(map["ppyProfitRate"]),
                  pppyProfitRate: double.tryParse(map["pppyProfitRate"]),
                  etc: map["etc"],
                  saleCompany: map["saleCompany"],
                  // 맵의 리스트
                  options: map["options"]
                      .map(
                        (e) => AnnuitySavingsOption(
                          receiptTerm: e["receiptTerm"],
                          receiptTermName: e["receiptTermName"],
                          entryAge: e["entryAge"],
                          entryAgeName: e["entryAgeName"],
                          monthlyPayment: e["monthlyPayment"],
                          monthlyPaymentName: e["monthlyPaymentName"],
                          paymentPeriod: e["paymentPeriod"],
                          paymentPeriodName: e["paymentPeriodName"],
                          startAge: e["startAge"],
                          startAgeName: e["startAgeName"],
                          monthlyReceiptAmount: e["monthlyReceiptAmount"],
                        ),
                      )
                      .toList()
                      .cast<AnnuitySavingsOption>(),
                ),
              );
            } catch (e) {
              print("error occured while mapping annuity data $e");
            }
            break;
          default:
            try {
              products.add(
                IsaMpBenefitRate(
                  category: ProductCategory.isa,
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
              print("error occured while mapping isa data $e");
            }
        }
      }
      return products.cast<FinancialProduct>();
    } catch (e) {
      print("Error fetching liked product: $e");
      return [];
    }
  }
}
