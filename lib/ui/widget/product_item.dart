import 'package:finbrain/data/model/entities/annuity_savings.dart';
import 'package:finbrain/data/model/entities/credit_loan.dart';
import 'package:finbrain/data/model/entities/deposit_and_installment_savings.dart';
import 'package:finbrain/data/model/entities/mortage_and_rent_loan.dart';
import 'package:finbrain/provider/product_provider.dart';
import 'package:finbrain/themes/colors.dart';
import 'package:finbrain/ui/product_categories.dart';
import 'package:finbrain/ui/screen/product_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductItem extends ConsumerWidget {
  const ProductItem({
    super.key,
    required this.productName,
    required this.sortCriteria,
  });

  final String productName;
  final String sortCriteria;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //print("Product Item criteria: $sortCriteria");
    final product = ref
        .watch(productNotifierProvider)
        .firstWhere((p) => p.commonInfo.productName == productName);

    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (ctx) => ProductDetailScreen(
              productName: productName,
              category: product.commonInfo.category,
            ),
          ),
        );
      },
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          color: primary100,
        ),
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      productName,
                      style: const TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w600,
                        color: textPrimary,
                      ),
                    ),
                    const SizedBox(height: 6.0),
                    Text(
                      product.commonInfo.companyName!,
                      style: const TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w400,
                        color: textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 28.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    sortCriteria,
                    style: const TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w400,
                      color: textSecondary,
                    ),
                  ),
                  const SizedBox(height: 6.0),
                  Text(
                    switch (product.commonInfo.category) {
                      ProductCategory.deposit =>
                        (sortCriteria == "최고 금리(높은순)")
                            ? (product as DepositAndInstallmentSavings)
                                  .returnHighestRateValue()
                                  .$1
                                  .toString()
                            : (product as DepositAndInstallmentSavings)
                                  .returnHighestRateValue()
                                  .$2
                                  .toString(),
                      ProductCategory.installment =>
                        (sortCriteria == "최고 금리(높은순)")
                            ? (product as DepositAndInstallmentSavings)
                                  .returnHighestRateValue()
                                  .$1
                                  .toString()
                            : (product as DepositAndInstallmentSavings)
                                  .returnHighestRateValue()
                                  .$2
                                  .toString(),
                      ProductCategory.annuity => switch (sortCriteria) {
                        "평균 수익률(높은 순)" =>
                          (product as AnnuitySavings)
                              .returnProfits()[0]
                              .toString(),
                        "전년도 수익률(높은 순)" =>
                          (product as AnnuitySavings)
                              .returnProfits()[1]
                              .toString(),
                        "전전년도 수익률(높은 순)" =>
                          (product as AnnuitySavings)
                              .returnProfits()[2]
                              .toString(),
                        _ =>
                          (product as AnnuitySavings)
                              .returnProfits()[3]
                              .toString(),
                      },
                      ProductCategory.credit => switch (sortCriteria) {
                        "최저 금리(낮은 순)" =>
                          (product as CreditLoan).returnRates()[0].toString(),
                        "최고 금리(낮은 순)" =>
                          (product as CreditLoan).returnRates()[2].toString(),
                        _ =>
                          (product as CreditLoan).returnRates()[1].toString(),
                      },
                      ProductCategory.mortage => switch (sortCriteria) {
                        "최저 금리(낮은 순)" =>
                          (product as MortageAndRentLoan)
                              .returnRates()[0]
                              .toString(),
                        "최고 금리(낮은 순)" =>
                          (product as MortageAndRentLoan)
                              .returnRates()[2]
                              .toString(),
                        _ =>
                          (product as MortageAndRentLoan)
                              .returnRates()[1]
                              .toString(),
                      },
                      ProductCategory.rent => switch (sortCriteria) {
                        "최저 금리(낮은 순)" =>
                          (product as MortageAndRentLoan)
                              .returnRates()[0]
                              .toString(),
                        "최고 금리(낮은 순)" =>
                          (product as MortageAndRentLoan)
                              .returnRates()[2]
                              .toString(),
                        _ =>
                          (product as MortageAndRentLoan)
                              .returnRates()[1]
                              .toString(),
                      },
                      _ => "이자율"
                    },
                    style: const TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w600,
                      color: textPrimary,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 3.0),
              IconButton(
                onPressed: () {
                  ref.read(productNotifierProvider.notifier).toggleLiked(productName);
                },
                icon: product.commonInfo.isLiked
                    ? const Icon(Icons.favorite, color: likedColor, size: 32.0)
                    : const Icon(
                        Icons.favorite,
                        color: unlikedColor,
                        size: 32.0,
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
