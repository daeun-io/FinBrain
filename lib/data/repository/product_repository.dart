import 'package:collection/collection.dart';
import 'package:finbrain/data/model/entities/credit_loan.dart';
import 'package:finbrain/data/model/entities/credit_loan_option.dart';
import 'package:finbrain/data/model/entities/deposit_and_installment_savings.dart';
import 'package:finbrain/data/model/entities/deposit_and_installment_savings_option.dart';
import 'package:finbrain/data/model/entities/isa_mp_benefit_rate.dart';
import 'package:finbrain/data/model/entities/isa_mp_benefit_rate_option.dart';
import 'package:finbrain/data/model/entities/mortgage_and_rent_loan.dart';
import 'package:finbrain/data/model/entities/mortgage_and_rent_loan_option.dart';
import 'package:finbrain/data/model/request/isa_search_options.dart';
import 'package:finbrain/data/repository/liked_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:finbrain/data/data_source/product_data_source.dart';
import 'package:finbrain/data/model/entities/financial_product.dart';
import 'package:finbrain/data/model/request/finlife_search_options.dart';
import 'package:finbrain/product_categories.dart';
import 'package:http/http.dart' as http;

final likedRepository = LikedRepository();

// 금융 상품 레포지토리
// Financial product repository
class ProductRepository {
  List<String>? _cachedLikedPrdtNames;

  // 주어진 업권에 따라 금융한눈에 상품 불러오기
  // Get financial products based on give category
  Future<(int, List<FinancialProduct>)> fetchFinlifeProductsAndPageNo(
    String uid,
    ProductCategory ctg,
    String topFinGrpNo,
    String pageNo,
  ) async {
    final client = http.Client();
    final dataStore = ProductRemoteDataSource(client);
    final options = FinlifeSearchOptions(
      auth: dotenv.env["FINLIFE_API"] ?? "",
      topFinGrpNo: topFinGrpNo,
      pageNo: pageNo,
    );
    try {
      // 좋아요 리스트를 불러와 동적으로 좋아요 상태 반영하기
      // Reflect the like status dynamically from the liked products list
      _cachedLikedPrdtNames ??= (await likedRepository.getLikedProducts(uid)).map((e) => e.commonInfo.productName).whereType<String>().toList();
      final result = await dataStore.fetchFinlifeProducts(ctg, options);
      if (result["result"] == null) {
        throw Exception("[error] result of fetching finlife products is null");
      }

      final maxPage =
          int.tryParse((result["result"]["max_page_no"]).toString()) ?? 0;
      if (maxPage == 0) {
        debugPrint("[empty] finlife product list is empty");
        return (0, <FinancialProduct>[]);
      }

      if (result["result"]["products"] == null ||
          result["result"]["products"]["product"] == null) {
        throw Exception("[error] result of fetching finlife products is null");
      }

      final rawProducts =
          result["result"]["products"]["product"] as Iterable<dynamic>;

      // 카테고리에 맞는 클래스로 변환
      // Convert data based on category
      final List<FinancialProduct> products = switch (ctg) {
        ProductCategory.deposit || ProductCategory.installment =>
          rawProducts
              .map<DepositAndInstallmentSavings?>((element) {
                if (element == null ||
                    element["baseinfo"] == null ||
                    element["baseinfo"]["kor_co_nm"] == null ||
                    element["baseinfo"]["fin_prdt_nm"] == null ||
                    element["baseinfo"]["fin_prdt_cd"] == null ||
                    element["options"] == null ||
                    element["options"]["option"] == null) {
                  return null;
                }
                final productOptions = (element["options"]["option"] is List)
                    ? element["options"]["option"]
                    : [element["options"]["option"]];
                final List options = (productOptions is List)
                    ? productOptions
                    : [productOptions];
                // 정렬용 값 구하기
                // Calculate rates for sorting
                final maxPrfRate = options
                    .map((e) => double.tryParse(e["intr_rate2"] ?? ""))
                    .whereType<double>()
                    .toList()
                    .maxOrNull;
                final maxBaseRate = options
                    .map((e) => double.tryParse(e["intr_rate"] ?? ""))
                    .whereType<double>()
                    .toList()
                    .maxOrNull;
                return DepositAndInstallmentSavings(
                  category: ctg,
                  submittedMonth: element["baseinfo"]["dcls_month"].toString(),
                  companyCode: element["baseinfo"]["fin_co_no"].toString(),
                  companyName: element["baseinfo"]["kor_co_nm"].toString(),
                  productCode: element["baseinfo"]["fin_prdt_cd"].toString(),
                  productName: element["baseinfo"]["fin_prdt_nm"].toString(),
                  startDay: element["baseinfo"]["dcls_strt_day"].toString(),
                  endDay: element["baseinfo"]["dcls_end_day"].toString(),
                  submittedDay: element["baseinfo"]["fin_co_subm_day"]
                      .toString(),
                  joinWay: (element["baseinfo"]["join_way"].toString()).split(
                    ",",
                  ),
                  interestAfterExpiration: element["baseinfo"]["mtrt_int"]
                      .toString(),
                  specialCondition: element["baseinfo"]["spcl_cnd"].toString(),
                  joinDeny: switch (int.tryParse(
                        element["baseinfo"]["join_deny"],
                      ) ??
                      0) {
                    1 => "제한 없음",
                    2 => "서민 전용",
                    3 => "일부 제한",
                    _ => "제공 안 함",
                  },
                  joinMember: element["baseinfo"]["join_member"].toString(),
                  etc: element["baseinfo"]["etc_note"].toString(),
                  maxLimit: element["baseinfo"]["max_limit"].toString(),
                  maxPrfRate: maxPrfRate,
                  maxBaseRate: maxBaseRate,
                  options: productOptions
                      .map<DepositAndInstallmentSavingsOption>(
                        (e) => DepositAndInstallmentSavingsOption(
                          intRateType: e["intr_rate_type"].toString(),
                          intRateTypeName: e["intr_rate_type_nm"].toString(),
                          saveTerm: int.tryParse(e["save_trm"].toString()),
                          intRate: double.tryParse(e["intr_rate"].toString()),
                          maxIntRate: double.tryParse(
                            e["intr_rate2"].toString(),
                          ),
                          reserveType: e["rsrv_type"].toString(),
                          reserveTypeName: e["rsrv_type_nm"].toString(),
                        ),
                      )
                      .toList(),
                  isLiked: (_cachedLikedPrdtNames ?? []).contains(
                    element["baseinfo"]["fin_prdt_nm"],
                  ),
                );
              })
              .nonNulls
              .toList()
              .cast<FinancialProduct>(),
        ProductCategory.mortgage || ProductCategory.rent =>
          rawProducts
              .map<MortgageAndRentLoan?>((element) {
                if (element == null ||
                    element["baseinfo"] == null ||
                    element["baseinfo"]["kor_co_nm"] == null ||
                    element["baseinfo"]["fin_prdt_nm"] == null ||
                    element["baseinfo"]["fin_prdt_cd"] == null ||
                    element["options"] == null ||
                    element["options"]["option"] == null) {
                  return null;
                }
                final productOptions = (element["options"]["option"] is List)
                    ? element["options"]["option"]
                    : [element["options"]["option"]];
                final List options = (productOptions is List)
                    ? productOptions
                    : [productOptions];
                // 정렬용 값 구하기
                // Calculate rates for sorting
                final minRate = options
                    .map((e) => double.tryParse(e["lend_rate_min"] ?? ""))
                    .whereType<double>()
                    .toList()
                    .minOrNull;
                final maxRate = options
                    .map((e) => double.tryParse(e["lend_rate_max"] ?? ""))
                    .whereType<double>()
                    .toList()
                    .minOrNull;
                final avgRate = options
                    .map((e) => double.tryParse(e["lend_rate_avg"] ?? ""))
                    .whereType<double>()
                    .toList()
                    .minOrNull;

                return MortgageAndRentLoan(
                  category: ctg,
                  submittedMonth: element["baseinfo"]["dcls_month"].toString(),
                  companyCode: element["baseinfo"]["fin_co_no"].toString(),
                  companyName: element["baseinfo"]["kor_co_nm"].toString(),
                  productCode: element["baseinfo"]["fin_prdt_cd"].toString(),
                  productName: element["baseinfo"]["fin_prdt_nm"].toString(),
                  startDay: element["baseinfo"]["dcls_strt_day"].toString(),
                  endDay: element["baseinfo"]["dcls_end_day"].toString(),
                  submittedDay: element["baseinfo"]["fin_co_subm_day"]
                      .toString(),
                  joinWay: (element["baseinfo"]["join_way"].toString()).split(
                    ",",
                  ),
                  isLiked: (_cachedLikedPrdtNames ?? []).contains(
                    element["baseinfo"]["fin_prdt_nm"],
                  ),
                  extraExpense: element["baseinfo"]["loan_inci_expn"]
                      .toString(),
                  earlyRepayFee: element["baseinfo"]["erly_rpay_fee"]
                      .toString(),
                  delayRate: element["baseinfo"]["dly_rate"].toString(),
                  loanLimit: element["baseinfo"]["loan_lmt"].toString(),
                  maxRate: maxRate,
                  minRate: minRate,
                  avgRate: avgRate,
                  options: productOptions
                      .map<MortgageAndRentLoanOption>(
                        (e) => MortgageAndRentLoanOption(
                          loanType: e["mrtg_type"].toString(),
                          loanTypeName: e["mrtg_type_nm"].toString(),
                          repayType: e["rpay_type"].toString(),
                          repayTypeName: e["rpay_type_nm"].toString(),
                          lendRateType: e["lend_rate_type"].toString(),
                          lendRateTypeName: e["lend_rate_type_nm"].toString(),
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
              })
              .nonNulls
              .toList()
              .cast<FinancialProduct>(),
        // 개인신용대출(credit loan)
        _ =>
          rawProducts
              .map<CreditLoan?>((element) {
                if (element == null ||
                    element["baseinfo"] == null ||
                    element["baseinfo"]["kor_co_nm"] == null ||
                    element["baseinfo"]["fin_prdt_nm"] == null ||
                    element["baseinfo"]["fin_prdt_cd"] == null ||
                    element["options"] == null ||
                    element["options"]["option"] == null) {
                  return null;
                }
                final productOptions = (element["options"]["option"] is List)
                    ? element["options"]["option"]
                    : [element["options"]["option"]];
                final List options = (productOptions is List)
                    ? productOptions
                    : [productOptions];
                // 정렬용 값 구하기
                // Calculate rates for sorting
                final foundOption = options
                    .where((e) => e["crdt_lend_rate_type_nm"] == "대출금리")
                    .firstOrNull;
                final rates = [
                  double.tryParse(foundOption["crdt_grad_1"] ?? ""),
                  double.tryParse(foundOption["crdt_grad_4"] ?? ""),
                  double.tryParse(foundOption["crdt_grad_5"] ?? ""),
                  double.tryParse(foundOption["crdt_grad_6"] ?? ""),
                  double.tryParse(foundOption["crdt_grad_10"] ?? ""),
                  double.tryParse(foundOption["crdt_grad_11"] ?? ""),
                  double.tryParse(foundOption["crdt_grad_12"] ?? ""),
                  double.tryParse(foundOption["crdt_grad_13"] ?? ""),
                ].whereType<double>();
                final minRate = (foundOption == null) ? null : rates.minOrNull;
                final maxRate = (foundOption == null) ? null : rates.maxOrNull;
                final avgRate = (foundOption["crdt_grad_avg"] != null)
                    ? double.tryParse(foundOption["crdt_grad_avg"])
                    : rates.average;

                return CreditLoan(
                  category: ProductCategory.credit,
                  submittedMonth: element["baseinfo"]["dcls_month"].toString(),
                  companyCode: element["baseinfo"]["fin_co_no"].toString(),
                  companyName: element["baseinfo"]["kor_co_nm"].toString(),
                  productCode: element["baseinfo"]["fin_prdt_cd"].toString(),
                  productName: element["baseinfo"]["fin_prdt_nm"].toString(),
                  startDay: element["baseinfo"]["dcls_strt_day"].toString(),
                  endDay: element["baseinfo"]["dcls_end_day"].toString(),
                  submittedDay: element["baseinfo"]["fin_co_subm_day"]
                      .toString(),
                  joinWay: (element["baseinfo"]["join_way"].toString()).split(
                    ",",
                  ),
                  isLiked: (_cachedLikedPrdtNames ?? []).contains(
                    element["baseinfo"]["fin_prdt_nm"],
                  ),
                  productType: element["baseinfo"]["crdt_prdt_type"].toString(),
                  productTypeName: element["baseinfo"]["crdt_prdt_type_nm"]
                      .toString(),
                  cbName: element["baseinfo"]["cb_name"].toString(),
                  minRate: minRate,
                  maxRate: maxRate,
                  avgRate: avgRate,
                  options: productOptions
                      .map<CreditLoanOption>(
                        (e) => CreditLoanOption(
                          creditLendRateType: e["crdt_lend_rate_type"]
                              .toString(),
                          creditLendRateTypeName: e["crdt_lend_rate_type_nm"]
                              .toString(),
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
              })
              .nonNulls
              .toList()
              .cast<FinancialProduct>(),
      };
      return (maxPage, products);
    } catch (e) {
      debugPrint("[error] failed to fetch finlife products : $e");
      throw Exception("[error] failed to fetch finlife products : $e");
    } finally {
      client.close();
    }
  }

  // 필터링 조건 없이 모든 ISA 상품 불러오기
  // Get ISA products without filters
  Future<(int, List<FinancialProduct>)> fetchIsaMpProductsAndCount(
    String uid,
    String pageNo,
    String numOfRows,
    String baseYearMonth,
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
      // 좋아요 리스트를 불러와 동적으로 좋아요 상태 반영하기
      // Reflect the like status dynamically from the liked products list
      _cachedLikedPrdtNames ??= (await likedRepository.getLikedProducts(uid)).map((e) => e.commonInfo.productName).whereType<String>().toList();
      final response = await dataStore.fetchIsaMpProducts(options);

      if (response["response"] == null ||
          response["response"]["body"] == null) {
        throw Exception("[error] result of fetching isa mp products is null");
      }
      final totalCount =
          int.tryParse(response["response"]["body"]["totalCount"].toString()) ??
          0;
      if (totalCount == 0) {
        debugPrint("[empty] isa mp product list is empty");
        return (0, <FinancialProduct>[]);
      }

      final body = response["response"]["body"];
      if (body["items"] == null || body["items"]["item"] == null) {
        throw Exception("[error] result of fetching isa mp products is null");
      }

      final rawItems = body["items"]["item"] as Iterable<dynamic>;

      // 원시 정보 가져와 IsaMPBenefit로 변환
      // Convert raw data to IsaMPBenefit
      final items = rawItems
          .map<IsaMpBenefitRate?>((element) {
            if (element == null ||
                element["cmpyNm"] == null ||
                element["mpNm"] == null) {
              return null;
            }
            final itemOptions =
                ((element["options"] is! List) || element["options"].isEmpty)
                ? []
                : element["options"];
            // 정렬용 값 구하기
            // Calculate profits for sorting
            final List options = (itemOptions is List)
                ? itemOptions
                : [itemOptions];
            final profits =
                options
                    .map((e) => double.tryParse(e["bnfRt"].toString()))
                    .whereType<double>()
                    .toList()
                  ..sorted((a, b) => a.compareTo(b));
            final middle = profits.length ~/ 2;
            final averageProfit = profits.average;
            final medianProfit = (profits.length % 2 == 1)
                ? profits[middle]
                : (profits[middle - 1] + profits[middle]) / 2;

            try {
              return IsaMpBenefitRate(
                category: ProductCategory.isaMp,
                companyName: element["cmpyNm"].toString(),
                productName: element["mpNm"].toString(),
                releaseDate: element["rlsDt"].toString(),
                isLiked: (_cachedLikedPrdtNames ?? []).contains(element["mpNm"]),
                baseDate: element["basDt"].toString(),
                businessDomain: element["bzds"].toString(),
                mpType: element["mpTp"].toString(),
                avgProfit: averageProfit,
                medProfit: medianProfit,
                options: itemOptions
                    .map<IsaMpBenefitRateOption>(
                      (e) => IsaMpBenefitRateOption(
                        term: e["trm"].toString(),
                        benefitRate: double.tryParse(e["bnfRt"].toString()),
                      ),
                    )
                    .toList(),
              );
            } catch (e) {
              throw Exception("[error] failed to map isa mp products : $e");
            }
          })
          .nonNulls
          .toList()
          .cast<FinancialProduct>();
      print('데이터 매핑: ${stopwatch.elapsedMilliseconds}ms');
      return (totalCount, items);
    } catch (e) {
      throw Exception("[error] failed to fetch isa mp products : $e");
    } finally {
      client.close();
    }
  }
}
