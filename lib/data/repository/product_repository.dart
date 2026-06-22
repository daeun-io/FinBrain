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
import 'package:http/http.dart' as http;
import 'package:finbrain/data/data_sources/product_data_source.dart';
import 'package:finbrain/data/models/entities/financial_product.dart';
import 'package:finbrain/data/models/request/finlife_search_options.dart';
import 'package:finbrain/product_categories.dart';

class ProductRepository {
  Future<List<FinancialProduct>> fetchProducts(
    ProductCategory ctg,
    String topFinGrpNo,
    String pageNo,
    String numOfRows,
    String baseYearMonth,
    String domain,
    String mpType,
    String cmpy,
  ) async {
    final client = http.Client();
    final dataStore = ProductRemoteDataSource(client);
    final options = (ctg == ProductCategory.isa)
        ? IsaSearchOptions(
            serviceKey: dotenv.env["PUBLIC_API"] ?? "",
            resultType: "json",
            pageNo: pageNo,
            numOfRows: numOfRows,
            baseYearMonth: baseYearMonth,
          )
        : FinlifeSearchOptions(
            auth: dotenv.env["FINLIFE_API"] ?? "",
            topFinGrpNo: topFinGrpNo,
            pageNo: pageNo,
          );

    try {
      if (ctg == ProductCategory.isa) {
        final Map<String, dynamic> response = await dataStore
            .fetchIsaMpProducts(
              options as IsaSearchOptions,
              domain,
              mpType,
              cmpy,
            );
        final body = response["response"]["body"];
        final items = body["items"]["item"].map(
          (e) => IsaMpBenefitRate(
            category: ProductCategory.isa,
            companyName: e["cmpyNm"],
            mpName: e["mpNm"],
            releaseDate: e["rlsDt"],
            isLiked: false,
            baseDate: e["basDt"],
            businessDomain: e["bzds"],
            mpType: e["mpTp"],
            options: e["options"].map(
              (e) => IsaMpBenefitRateOption(
                term: e["trm"],
                benefitRate: e["bnfRt"],
              ),
            ),
          ),
        );
        return items;
      } else {
        final Map<String, dynamic> result = await dataStore
            .fetchFinlifeProducts(ctg, options as FinlifeSearchOptions);
        print("prdt result: $result");
        final products = result["result"]["products"]["product"].map(
          (e) => switch (ctg) {
            ProductCategory.deposit => DepositAndInstallmentSavings(
              category: ProductCategory.deposit,
              submittedMonth: e["baseinfo"]["dcls_month"],
              companyCode: e["baseinfo"]["fin_co_no"],
              companyName: e["baseinfo"]["kor_co_no"],
              productCode: e["baseinfo"]["fin_prdt_cd"],
              productName: e["baseinfo"]["fin_prdt_nm"],
              startDay: e["baseinfo"]["dcls_strt_day"],
              endDay: e["baseinfo"]["dcls_end_day"],
              submittedDay: e["baseinfo"]["fin_co_subm_day"],
              joinWay: (e["baseinfo"]["join_way"] as String).split(","),
              interestAfterExpiration: e["baseinfo"]["mtrt_int"],
              specialCondition: e["baseinfo"]["spcl_cnd"],
              joinDeny: switch (e["baseinfo"]["join_deny"] as int) {
                1 => "제한 없음",
                2 => "서민 전용",
                _ => "일부 제한",
              },
              joinMember: e["baseinfo"]["join_member"],
              etc: e["baseinfo"]["etc_note"],
              maxLimit: e["baseinfo"]["max_limit"],
              options: e["baseinfo"]["options"].map(
                (e) => DepositAndInstallmentSavingsOption(
                  intRateType: e["intr_rate_type"],
                  intRateTypeName: e["int_rate_type_nm"],
                  saveTerm: e["save_trm"],
                  intRate: e["intr_rate"],
                  maxIntRate: e["intr_rate2"],
                  reserveType: null,
                  reserveTypeName: null,
                ),
              ),
              isLiked: false,
            ),
            ProductCategory.installment => DepositAndInstallmentSavings(
              category: ProductCategory.installment,
              submittedMonth: e["baseinfo"]["dcls_month"],
              companyCode: e["baseinfo"]["fin_co_no"],
              companyName: e["baseinfo"]["kor_co_no"],
              productCode: e["baseinfo"]["fin_prdt_cd"],
              productName: e["baseinfo"]["fin_prdt_nm"],
              startDay: e["baseinfo"]["dcls_strt_day"],
              endDay: e["baseinfo"]["dcls_end_day"],
              submittedDay: e["baseinfo"]["fin_co_subm_day"],
              joinWay: (e["baseinfo"]["join_way"] as String).split(","),
              interestAfterExpiration: e["baseinfo"]["mtrt_int"],
              specialCondition: e["baseinfo"]["spcl_cnd"],
              joinDeny: switch (e["baseinfo"]["join_deny"] as int) {
                1 => "제한 없음",
                2 => "서민 전용",
                _ => "일부 제한",
              },
              joinMember: e["baseinfo"]["join_member"],
              etc: e["baseinfo"]["etc_note"],
              maxLimit: e["baseinfo"]["max_limit"],
              options: e["baseinfo"]["options"].map(
                (e) => DepositAndInstallmentSavingsOption(
                  intRateType: e["intr_rate_type"],
                  intRateTypeName: e["int_rate_type_nm"],
                  saveTerm: e["save_trm"],
                  intRate: e["intr_rate"],
                  maxIntRate: e["intr_rate2"],
                  reserveType: e["rsrv_type"],
                  reserveTypeName: e["rsrv_type_nm"],
                ),
              ),
              isLiked: false,
            ),
            ProductCategory.mortage => MortageAndRentLoan(
              category: ProductCategory.mortage,
              submittedMonth: e["baseinfo"]["dcls_month"],
              companyCode: e["baseinfo"]["fin_co_no"],
              companyName: e["baseinfo"]["kor_co_no"],
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
              options: e["options"]["option"].map(
                (e) => MortageAndRentLoanOption(
                  loanType: e["mrtg_type"],
                  loanTypeName: e["mrtg_type_nm"],
                  repayType: e["rpay_type"],
                  repayTypeName: e["rpay_type_nm"],
                  lendRateType: e["lend_rate_type"],
                  lendRateTypeName: e["lend_rate_type_nm"],
                  lendRateMin: double.tryParse(e["lend_rate_min"]),
                  lendRateMax: double.tryParse(e["lend_rate_max"]),
                  lendRateAvg: double.tryParse(e["lend_rate_avg"]),
                ),
              ),
            ),
            ProductCategory.rent => MortageAndRentLoan(
              category: ProductCategory.rent,
              submittedMonth: e["baseinfo"]["dcls_month"],
              companyCode: e["baseinfo"]["fin_co_no"],
              companyName: e["baseinfo"]["kor_co_no"],
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
              options: e["options"]["option"].map(
                (e) => MortageAndRentLoanOption(
                  loanType: null,
                  loanTypeName: null,
                  repayType: e["rpay_type"],
                  repayTypeName: e["rpay_type_nm"],
                  lendRateType: e["lend_rate_type"],
                  lendRateTypeName: e["lend_rate_type_nm"],
                  lendRateMin: double.tryParse(e["lend_rate_min"]),
                  lendRateMax: double.tryParse(e["lend_rate_max"]),
                  lendRateAvg: double.tryParse(e["lend_rate_avg"]),
                ),
              ),
            ),
            ProductCategory.credit => CreditLoan(
              category: ProductCategory.credit,
              submittedMonth: e["baseinfo"]["dcls_month"],
              companyCode: e["baseinfo"]["fin_co_no"],
              companyName: e["baseinfo"]["kor_co_no"],
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
              options: e["options"]["option"].map(
                (e) => CreditLoanOption(
                  creditLendRateType: e["crdt_lend_rate_type"],
                  creditLendRateTypeName: e["crdt_lend_rate_type_nm"],
                  gradeOver900: double.tryParse(e["crdt_grad_1"]),
                  grade801900: double.tryParse(e["crdt_grad_4"]),
                  grade701800: double.tryParse(e["crdt_grad_5"]),
                  grade601700: double.tryParse(e["crdt_grad_6"]),
                  grade501600: double.tryParse(e["crdt_grad_10"]),
                  grade401500: double.tryParse(e["crdt_grad_11"]),
                  grade301400: double.tryParse(e["crdt_grad_12"]),
                  gradeUnder300: double.tryParse(e["crdt_grad_13"]),
                  averageGrade: double.tryParse(e["crdt_grad_avg"]),
                ),
              ),
            ),
            _ => AnnuitySavings(
              category: ProductCategory.credit,
              submittedMonth: e["baseinfo"]["dcls_month"],
              companyCode: e["baseinfo"]["fin_co_no"],
              companyName: e["baseinfo"]["kor_co_no"],
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
              averageProfit: e["baseinfo"]["avg_prft_rate"],
              declaredRate: e["baseinfo"]["dcls_rate"],
              guaranteedRate: e["baseinfo"]["guar_rate"],
              pyProfitRate: e["baseinfo"]["btrm_prft_rate_1"],
              ppyProfitRate: e["baseinfo"]["btrm_prft_rate_2"],
              pppyProfitRate: e["baseinfo"]["btrm_prft_rate_3"],
              etc: e["baseinfo"]["etc"],
              saleCompany: e["baseinfo"]["sale_co"],
              options: e["options"]["option"].map(
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
              ),
            ),
          },
        );
        return products;
      }
    } catch (error) {
      print("error: Failed to load data");
      return [];
    } finally {
      client.close();
    }
  }
}
