import 'package:finbrain/data/models/entities/annuity_savings.dart';
import 'package:finbrain/data/models/entities/annuity_savings_option.dart';
import 'package:finbrain/data/models/entities/credit_loan.dart';
import 'package:finbrain/data/models/entities/credit_loan_option.dart';
import 'package:finbrain/data/models/entities/deposit_and_installment_savings.dart';
import 'package:finbrain/data/models/entities/deposit_and_installment_savings_option.dart';
import 'package:finbrain/data/models/entities/isa_mp_benefit_rate.dart';
import 'package:finbrain/data/models/entities/isa_mp_benefit_rate_option.dart';
import 'package:finbrain/data/models/entities/mortage_and_rent_loan.dart';
import 'package:finbrain/data/models/entities/mortage_and_rent_loan_option.dart';
import 'package:finbrain/data/models/request/isa_search_options.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:finbrain/data/data_sources/product_data_source.dart';
import 'package:finbrain/data/models/entities/financial_product.dart';
import 'package:finbrain/data/models/request/finlife_search_options.dart';
import 'package:finbrain/product_categories.dart';
import 'package:http/http.dart' as http;

class ProductRepository {
  Future<(int, List<FinancialProduct>)> fetchFinlifeProductsAndPageNo(
    ProductCategory ctg,
    String topFinGrpNo,
    String pageNo,
  ) async {
    print("ctg, $ctg");
    final client = http.Client();
    final dataStore = ProductRemoteDataSource(client);
    final options = FinlifeSearchOptions(
      auth: dotenv.env["FINLIFE_API"] ?? "",
      topFinGrpNo: topFinGrpNo,
      pageNo: pageNo,
    );
    try {
      final Map<String, dynamic> result = await dataStore.fetchFinlifeProducts(
        ctg,
        options,
      );

      if (result["result"] == null) {
        print("error: result is null");
        return (0, <FinancialProduct>[]);
      }

      final maxPage = int.tryParse(result["result"]["max_page_no"]) ?? 0;
      if (maxPage == 0) {
        return (0, <FinancialProduct>[]);
        ;
      }

      if (result["result"]["products"] == null ||
          result["result"]["products"]["product"] == null) {
        print("error: No products found");
        return (0, [] as List<FinancialProduct>);
      }

      final rawProducts =
          result["result"]["products"]["product"] as Iterable<dynamic>;

      final List<FinancialProduct> products = switch (ctg) {
        ProductCategory.deposit =>
          rawProducts
              .map<DepositAndInstallmentSavings?>((e) {
                if (e == null ||
                    e["baseinfo"] == null ||
                    e["baseinfo"]["kor_co_nm"] == null ||
                    e["baseinfo"]["fin_prdt_nm"] == null ||
                    e["options"] == null ||
                    e["options"]["option"] == null) {
                  print("error: product is null");
                  return null;
                }
                final productOptions = (e["options"]["option"] is List)
                    ? e["options"]["option"]
                    : [e["options"]["option"]];
                try {
                  return DepositAndInstallmentSavings(
                    category: ProductCategory.deposit,
                    submittedMonth: e["baseinfo"]["dcls_month"],
                    companyCode: e["baseinfo"]["fin_co_no"],
                    companyName: e["baseinfo"]["kor_co_nm"],
                    productCode: e["baseinfo"]["fin_prdt_cd"],
                    productName: e["baseinfo"]["fin_prdt_nm"],
                    startDay: e["baseinfo"]["dcls_strt_day"],
                    endDay: e["baseinfo"]["dcls_end_day"],
                    submittedDay: e["baseinfo"]["fin_co_subm_day"],
                    joinWay: (e["baseinfo"]["join_way"] as String).split(","),
                    interestAfterExpiration: e["baseinfo"]["mtrt_int"],
                    specialCondition: e["baseinfo"]["spcl_cnd"],
                    joinDeny:
                        switch (int.tryParse(e["baseinfo"]["join_deny"]) ?? 0) {
                          1 => "제한 없음",
                          2 => "서민 전용",
                          3 => "일부 제한",
                          _ => "제공 안 함",
                        },
                    joinMember: e["baseinfo"]["join_member"],
                    etc: e["baseinfo"]["etc_note"],
                    maxLimit: e["baseinfo"]["max_limit"],
                    options: productOptions
                        .map<DepositAndInstallmentSavingsOption>(
                          (e) => DepositAndInstallmentSavingsOption(
                            intRateType: e["intr_rate_type"],
                            intRateTypeName: e["intr_rate_type_nm"],
                            saveTerm: int.tryParse(e["save_trm"].toString()),
                            intRate: double.tryParse(e["intr_rate"].toString()),
                            maxIntRate: double.tryParse(
                              e["intr_rate2"].toString(),
                            ),
                            reserveType: null,
                            reserveTypeName: null,
                          ),
                        )
                        .toList(),
                    isLiked: false,
                  );
                } catch (error, stackTrace) {
                  print("error: a mapping error: $error");
                  print("error: trace the mapping error: $stackTrace");
                  print("error: failed element: $e");
                  return null;
                }
              })
              .nonNulls
              .toList()
              .cast<FinancialProduct>(),
        ProductCategory.installment =>
          rawProducts
              .map<DepositAndInstallmentSavings?>((e) {
                if (e == null ||
                    e["baseinfo"] == null ||
                    e["baseinfo"]["kor_co_nm"] == null ||
                    e["baseinfo"]["fin_prdt_nm"] == null ||
                    e["options"] == null ||
                    e["options"]["option"] == null) {
                  print("error: product is null");
                  return null;
                }
                final productOptions = (e["options"]["option"] is List)
                    ? e["options"]["option"]
                    : [e["options"]["option"]];
                try {
                  return DepositAndInstallmentSavings(
                    category: ProductCategory.installment,
                    submittedMonth: e["baseinfo"]["dcls_month"],
                    companyCode: e["baseinfo"]["fin_co_no"],
                    companyName: e["baseinfo"]["kor_co_nm"],
                    productCode: e["baseinfo"]["fin_prdt_cd"],
                    productName: e["baseinfo"]["fin_prdt_nm"],
                    startDay: e["baseinfo"]["dcls_strt_day"],
                    endDay: e["baseinfo"]["dcls_end_day"],
                    submittedDay: e["baseinfo"]["fin_co_subm_day"],
                    joinWay: (e["baseinfo"]["join_way"] as String).split(","),
                    interestAfterExpiration: e["baseinfo"]["mtrt_int"],
                    specialCondition: e["baseinfo"]["spcl_cnd"],
                    joinDeny:
                        switch (int.tryParse(e["baseinfo"]["join_deny"]) ?? 0) {
                          1 => "제한 없음",
                          2 => "서민 전용",
                          3 => "일부 제한",
                          _ => "제공 안 함",
                        },
                    joinMember: e["baseinfo"]["join_member"],
                    etc: e["baseinfo"]["etc_note"],
                    maxLimit: e["baseinfo"]["max_limit"],
                    options: productOptions
                        .map<DepositAndInstallmentSavingsOption>(
                          (e) => DepositAndInstallmentSavingsOption(
                            intRateType: e["intr_rate_type"],
                            intRateTypeName: e["intr_rate_type_nm"],
                            saveTerm: int.tryParse(e["save_trm"].toString()),
                            intRate: double.tryParse(e["intr_rate"].toString()),
                            maxIntRate: double.tryParse(
                              e["intr_rate2"].toString(),
                            ),
                            reserveType: e["rsrv_type"],
                            reserveTypeName: e["rsrv_type_nm"],
                          ),
                        )
                        .toList(),
                    isLiked: false,
                  );
                } catch (error, stackTrace) {
                  print("error: a mapping error: $error");
                  print("error: trace the mapping error: $stackTrace");
                  print("error: failed element: $e");
                  return null;
                }
              })
              .nonNulls
              .toList()
              .cast<FinancialProduct>(),
        ProductCategory.mortage =>
          rawProducts
              .map<MortageAndRentLoan?>((e) {
                if (e == null ||
                    e["baseinfo"] == null ||
                    e["baseinfo"]["kor_co_nm"] == null ||
                    e["baseinfo"]["fin_prdt_nm"] == null ||
                    e["options"] == null ||
                    e["options"]["option"] == null) {
                  print("error: product is null");
                  return null;
                }
                final productOptions = (e["options"]["option"] is List)
                    ? e["options"]["option"]
                    : [e["options"]["option"]];
                try {
                  return MortageAndRentLoan(
                    category: ProductCategory.mortage,
                    submittedMonth: e["baseinfo"]["dcls_month"],
                    companyCode: e["baseinfo"]["fin_co_no"],
                    companyName: e["baseinfo"]["kor_co_nm"],
                    productCode: e["baseinfo"]["fin_prdt_cd"],
                    productName: e["baseinfo"]["fin_prdt_nm"],
                    startDay: e["baseinfo"]["dcls_strt_day"],
                    endDay: e["baseinfo"]["dcls_end_day"],
                    submittedDay: e["baseinfo"]["fin_co_subm_day"],
                    joinWay: (e["baseinfo"]["join_way"] as String).split(","),
                    isLiked: false,
                    extraExpense: e["baseinfo"]["loan_inci_expn"],
                    earlyRepayFee: e["baseinfo"]["erly_rpay_fee"],
                    delayRate: e["baseinfo"]["dly_rate"],
                    loanLimit: e["baseinfo"]["loan_lmt"],
                    options: productOptions
                        .map<MortageAndRentLoanOption>(
                          (e) => MortageAndRentLoanOption(
                            loanType: e["mrtg_type"],
                            loanTypeName: e["mrtg_type_nm"],
                            repayType: e["rpay_type"],
                            repayTypeName: e["rpay_type_nm"],
                            lendRateType: e["lend_rate_type"],
                            lendRateTypeName: e["lend_rate_type_nm"],
                            lendRateMin: double.tryParse(
                              e["lend_rate_min"].toString(),
                            ),
                            lendRateMax: double.tryParse(
                              e["lend_rate_max"].toString(),
                            ),
                            lendRateAvg: double.tryParse(
                              e["lend_rate_avg"].toString(),
                            ),
                          ),
                        )
                        .toList(),
                  );
                } catch (error, stackTrace) {
                  print("error: a mapping error: $error");
                  print("error: trace the mapping error: $stackTrace");
                  print("error: failed element: $e");
                  return null;
                }
              })
              .nonNulls
              .toList()
              .cast<FinancialProduct>(),
        ProductCategory.rent =>
          rawProducts
              .map<MortageAndRentLoan?>((e) {
                if (e == null ||
                    e["baseinfo"] == null ||
                    e["baseinfo"]["kor_co_nm"] == null ||
                    e["baseinfo"]["fin_prdt_nm"] == null ||
                    e["options"] == null ||
                    e["options"]["option"] == null) {
                  print("error: product is null");
                  return null;
                }
                final productOptions = (e["options"]["option"] is List)
                    ? e["options"]["option"]
                    : [e["options"]["option"]];
                try {
                  return MortageAndRentLoan(
                    category: ProductCategory.rent,
                    submittedMonth: e["baseinfo"]["dcls_month"],
                    companyCode: e["baseinfo"]["fin_co_no"],
                    companyName: e["baseinfo"]["kor_co_nm"],
                    productCode: e["baseinfo"]["fin_prdt_cd"],
                    productName: e["baseinfo"]["fin_prdt_nm"],
                    startDay: e["baseinfo"]["dcls_strt_day"],
                    endDay: e["baseinfo"]["dcls_end_day"],
                    submittedDay: e["baseinfo"]["fin_co_subm_day"],
                    joinWay: (e["baseinfo"]["join_way"] as String).split(","),
                    isLiked: false,
                    extraExpense: e["baseinfo"]["loan_inci_expn"],
                    earlyRepayFee: e["baseinfo"]["erly_rpay_fee"],
                    delayRate: e["baseinfo"]["dly_rate"],
                    loanLimit: e["baseinfo"]["loan_lmt"],
                    options: productOptions
                        .map<MortageAndRentLoanOption>(
                          (e) => MortageAndRentLoanOption(
                            loanType: null,
                            loanTypeName: null,
                            repayType: e["rpay_type"],
                            repayTypeName: e["rpay_type_nm"],
                            lendRateType: e["lend_rate_type"],
                            lendRateTypeName: e["lend_rate_type_nm"],
                            lendRateMin: double.tryParse(
                              e["lend_rate_min"].toString(),
                            ),
                            lendRateMax: double.tryParse(
                              e["lend_rate_max"].toString(),
                            ),
                            lendRateAvg: double.tryParse(
                              e["lend_rate_avg"].toString(),
                            ),
                          ),
                        )
                        .toList(),
                  );
                } catch (error, stackTrace) {
                  print("error: a mapping error: $error");
                  print("error: trace the mapping error: $stackTrace");
                  print("error: failed element: $e");
                  return null;
                }
              })
              .nonNulls
              .toList()
              .cast<FinancialProduct>(),
        ProductCategory.credit =>
          rawProducts
              .map<CreditLoan?>((e) {
                if (e == null ||
                    e["baseinfo"] == null ||
                    e["baseinfo"]["kor_co_nm"] == null ||
                    e["baseinfo"]["fin_prdt_nm"] == null ||
                    e["options"] == null ||
                    e["options"]["option"] == null) {
                  print("error: product is null");
                  return null;
                }
                final productOptions = (e["options"]["option"] is List)
                    ? e["options"]["option"]
                    : [e["options"]["option"]];
                try {
                  return CreditLoan(
                    category: ProductCategory.credit,
                    submittedMonth: e["baseinfo"]["dcls_month"],
                    companyCode: e["baseinfo"]["fin_co_no"],
                    companyName: e["baseinfo"]["kor_co_nm"],
                    productCode: e["baseinfo"]["fin_prdt_cd"],
                    productName: e["baseinfo"]["fin_prdt_nm"],
                    startDay: e["baseinfo"]["dcls_strt_day"],
                    endDay: e["baseinfo"]["dcls_end_day"],
                    submittedDay: e["baseinfo"]["fin_co_subm_day"],
                    joinWay: (e["baseinfo"]["join_way"] as String).split(","),
                    isLiked: false,
                    productType: e["baseinfo"]["crdt_prdt_type"],
                    productTypeName: e["baseinfo"]["crdt_prdt_type_nm"],
                    cbName: e["baseinfo"]["cb_name"],
                    options: productOptions
                        .map<CreditLoanOption>(
                          (e) => CreditLoanOption(
                            creditLendRateType: e["crdt_lend_rate_type"],
                            creditLendRateTypeName: e["crdt_lend_rate_type_nm"],
                            gradeOver900: double.tryParse(
                              e["crdt_grad_1"].toString(),
                            ),
                            grade801900: double.tryParse(
                              e["crdt_grad_4"].toString(),
                            ),
                            grade701800: double.tryParse(
                              e["crdt_grad_5"].toString(),
                            ),
                            grade601700: double.tryParse(
                              e["crdt_grad_6"].toString(),
                            ),
                            grade501600: double.tryParse(
                              e["crdt_grad_10"].toString(),
                            ),
                            grade401500: double.tryParse(
                              e["crdt_grad_11"].toString(),
                            ),
                            grade301400: double.tryParse(
                              e["crdt_grad_12"].toString(),
                            ),
                            gradeUnder300: double.tryParse(
                              e["crdt_grad_13"].toString(),
                            ),
                            averageGrade: double.tryParse(
                              e["crdt_grad_avg"].toString(),
                            ),
                          ),
                        )
                        .toList(),
                  );
                } catch (error, stackTrace) {
                  print("error: a mapping error: $error");
                  print("error: trace the mapping error: $stackTrace");
                  print("error: failed element: $e");
                  return null;
                }
              })
              .nonNulls
              .toList()
              .cast<FinancialProduct>(),
        _ =>
          rawProducts
              .map<AnnuitySavings?>((e) {
                if (e == null ||
                    e["baseinfo"] == null ||
                    e["baseinfo"]["kor_co_nm"] == null ||
                    e["baseinfo"]["fin_prdt_nm"] == null ||
                    e["options"] == null ||
                    e["options"]["option"] == null) {
                  print("error: product is null");
                  return null;
                }
                final productOptions = (e["options"]["option"] is List)
                    ? e["options"]["option"]
                    : [e["options"]["option"]];
                try {
                  return AnnuitySavings(
                    category: ProductCategory.annuity,
                    submittedMonth: e["baseinfo"]["dcls_month"],
                    companyCode: e["baseinfo"]["fin_co_no"],
                    companyName: e["baseinfo"]["kor_co_nm"],
                    productCode: e["baseinfo"]["fin_prdt_cd"],
                    productName: e["baseinfo"]["fin_prdt_nm"],
                    startDay: e["baseinfo"]["dcls_strt_day"],
                    endDay: e["baseinfo"]["dcls_end_day"],
                    submittedDay: e["baseinfo"]["fin_co_subm_day"],
                    joinWay: (e["baseinfo"]["join_way"] as String).split(","),
                    isLiked: false,
                    pensionKind: e["baseinfo"]["pnsn_kind"],
                    pensionKindName: e["baseinfo"]["pnsn_kind_nm"],
                    saleStartDay: e["baseinfo"]["sale_strt_day"],
                    maintenanceCount: e["baseinfo"]["mntn_cnt"],
                    productType: e["baseinfo"]["prdt_type"],
                    productTypeName: e["baseinfo"]["prdt_type_nm"],
                    averageProfit: double.tryParse(
                      e["baseinfo"]["avg_prft_rate"].toString(),
                    ),
                    declaredRate: e["baseinfo"]["dcls_rate"],
                    guaranteedRate: e["baseinfo"]["guar_rate"],
                    pyProfitRate: double.tryParse(
                      e["baseinfo"]["btrm_prft_rate_1"].toString(),
                    ),
                    ppyProfitRate: double.tryParse(
                      e["baseinfo"]["btrm_prft_rate_2"].toString(),
                    ),
                    pppyProfitRate: double.tryParse(
                      e["baseinfo"]["btrm_prft_rate_3"].toString(),
                    ),
                    etc: e["baseinfo"]["etc"],
                    saleCompany: e["baseinfo"]["sale_co"].toString(),
                    options: productOptions
                        .map<AnnuitySavingsOption>(
                          (e) => AnnuitySavingsOption(
                            receiptTerm: e["pnsn_recp_trm"],
                            receiptTermName: e["pnsn_recp_trm_nm"],
                            entryAge: e["pnsn_entr_age"],
                            entryAgeName: e["pnsn_entr_age_nm"],
                            monthlyPayment: e["mon_paym_atm"],
                            monthlyPaymentName: e["mon_paym_atm_nm"],
                            paymentPeriod: e["paym_prd"],
                            paymentPeriodName: e["paym_prd_nm"],
                            startAge: e["pnsn_strt_age"],
                            startAgeName: e["pnsn_strt_age_nm"],
                            monthlyReceiptAmount: e["pnsn_recp_amt"],
                          ),
                        )
                        .toList(),
                  );
                } catch (error, stackTrace) {
                  print("error: a mapping error: $error");
                  print("error: trace the mapping error: $stackTrace");
                  print("error: failed element: $e");
                  return null;
                }
              })
              .nonNulls
              .toList()
              .cast<FinancialProduct>(),
      };
      return (maxPage, products);
    } catch (error) {
      print("error: Failed to load data $error");
      return (0, <FinancialProduct>[]);
    } finally {
      client.close();
    }
  }

  Future<(int, List<FinancialProduct>)> fetchIsaMpProductsAndCount(
    String pageNo,
    String numOfRows,
    String baseYearMonth,
    String domain,
    String mpType,
    String cmpy,
  ) async {
    final client = http.Client();
    final dataStore = ProductRemoteDataSource(client);
    final options = IsaSearchOptions(
      serviceKey: dotenv.env["PUBLIC_API"] ?? "",
      resultType: "json",
      pageNo: pageNo,
      numOfRows: numOfRows,
      baseYearMonth: baseYearMonth,
    );

    try {
      final Map<String, dynamic> response = await dataStore.fetchIsaMpProducts(
        options,
        domain,
        mpType,
        cmpy,
      );
      print("response: $response");
      if (response["response"] == null ||
          response["response"]["body"] == null) {
        print("error: response is null");
        return (0, <FinancialProduct>[]);
      }
      final totalCount =
          int.tryParse(response["response"]["body"]["totalCount"].toString()) ?? 0;
      if (totalCount == 0) {
        return (0, <FinancialProduct>[]);
      }

      final body = response["response"]["body"];
      if (body["items"] == null || body["items"]["item"] == null) {
        print("error: item is null");
        return (0, <FinancialProduct>[]);
      }
      final rawItems = body["items"]["item"] as Iterable<dynamic>;

      final items = rawItems
          .map<IsaMpBenefitRate?>((e) {
            if (e == null || e["cmpyNm"] == null || e["mpNm"] == null) {
              return null;
            }
            final itemOptions =
                ((e["options"] is! List) || e["options"].isEmpty)
                ? []
                : e["options"];
            try {
              return IsaMpBenefitRate(
                category: ProductCategory.isa,
                companyName: e["cmpyNm"],
                mpName: e["mpNm"],
                releaseDate: e["rlsDt"],
                isLiked: false,
                baseDate: e["basDt"],
                businessDomain: e["bzds"],
                mpType: e["mpTp"],
                options: itemOptions
                    .map<IsaMpBenefitRateOption>(
                      (e) => IsaMpBenefitRateOption(
                        term: e["trm"],
                        benefitRate:
                            double.tryParse(e["bnfRt"].toString()) ??
                            double.negativeInfinity,
                      ),
                    )
                    .toList(),
              );
            } catch (error, stackTrace) {
              print("error: a mapping error: $error");
              print("error: trace the mapping error: $stackTrace");
              print("error: failed element: $e");
              return null;
            }
          })
          .nonNulls
          .toList()
          .cast<FinancialProduct>();
      return (totalCount, items);
    } catch (error) {
      print("error: Failed to load data $error");
      return (0, <FinancialProduct>[]);
    } finally {
      client.close();
    }
  }
}
