import 'package:finbrain/data/model/entities/annuity_savings.dart';
import 'package:finbrain/data/model/entities/credit_loan.dart';
import 'package:finbrain/data/model/entities/deposit_and_installment_savings.dart';
import 'package:finbrain/data/model/entities/financial_product.dart';
import 'package:finbrain/data/model/entities/isa_mp_benefit_rate.dart';
import 'package:finbrain/data/model/entities/mortage_and_rent_loan.dart';
import 'package:finbrain/ui/viewmodel/product_viewmodel.dart';
import 'package:finbrain/ui/viewmodel/selected_prdt_viewmodel.dart';
import 'package:finbrain/ui/viewmodel/sort_or_filter_viewmodel.dart';
import 'package:finbrain/product_categories.dart';
import 'package:finbrain/ui/screen/product_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductItem extends ConsumerStatefulWidget {
  const ProductItem({
    super.key,
    required this.product,
    required this.fromLikedScreen,
  });

  final FinancialProduct product;
  final bool fromLikedScreen;

  @override
  ConsumerState<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends ConsumerState<ProductItem> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final sortFilter = ref.watch(
      sortOrFilterTextViewModelProvider(widget.product.commonInfo.category),
    );
    final sortCriteria =
        (widget.product.commonInfo.category == ProductCategory.liked)
        ? switch (widget.product.commonInfo.category) {
            ProductCategory.deposit => "최고 금리(높은순)",
            ProductCategory.installment => "최고 금리(높은순)",
            ProductCategory.annuity => "평균 수익률(높은 순)",
            ProductCategory.isaMp => "평균 수익률(높은 순)",
            _ => "최저 금리(낮은 순)",
          }
        : sortFilter.$1.toString();

    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (ctx) => ProductDetailScreen(
              productName: widget.product.commonInfo.productName!,
              fromLikedScreen: widget.fromLikedScreen,
            ),
          ),
        );
      },
      onLongPress: () {
        setState(() {
          if (widget.product.commonInfo.isLiked) {
            isSelected = !isSelected;
          }
          if (isSelected) {
            ref
                .read(selectedProductsViewmodelProvider.notifier)
                .addProduct(widget.product);
          } else {
            ref
                .read(selectedProductsViewmodelProvider.notifier)
                .subtractProduct(widget.product);
          }
        });
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          color: isSelected
              ? colorScheme.surfaceContainerLow
              : colorScheme.secondary,
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
                      widget.product.commonInfo.productName!.replaceAll(
                        r'\\n',
                        "",
                      ),
                      style: textTheme.bodyMedium!.copyWith(color: colorScheme.onPrimary)
                    ),
                    const SizedBox(height: 6.0),
                    Text(
                      widget.product.commonInfo.companyName!,
                      style: textTheme.bodySmall!.copyWith(color: colorScheme.onTertiary)
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 28.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    sortCriteria.split('(').first,
                    style: textTheme.titleSmall!.copyWith(color: colorScheme.onTertiary)
                  ),
                  const SizedBox(height: 6.0),
                  Text(
                    switch (widget.product.commonInfo.category) {
                      ProductCategory.deposit =>
                        (sortCriteria == "최고 금리(높은 순)")
                            ? (widget.product as DepositAndInstallmentSavings)
                                  .returnHighestRateValue()
                                  .$1
                                  .toStringAsFixed(2)
                            : (widget.product as DepositAndInstallmentSavings)
                                  .returnHighestRateValue()
                                  .$2
                                  .toStringAsFixed(2),
                      ProductCategory.installment =>
                        (sortCriteria == "최고 금리(높은 순)")
                            ? (widget.product as DepositAndInstallmentSavings)
                                  .returnHighestRateValue()
                                  .$1
                                  .toStringAsFixed(2)
                            : (widget.product as DepositAndInstallmentSavings)
                                  .returnHighestRateValue()
                                  .$2
                                  .toStringAsFixed(2),
                      ProductCategory.annuity => switch (sortCriteria) {
                        "평균 수익률(높은 순)" =>
                          (widget.product as AnnuitySavings)
                              .returnProfits()[0]
                              .toStringAsFixed(2),
                        "전년도 수익률(높은 순)" =>
                          (widget.product as AnnuitySavings)
                              .returnProfits()[1]
                              .toStringAsFixed(2),
                        "전전년도 수익률(높은 순)" =>
                          (widget.product as AnnuitySavings)
                              .returnProfits()[2]
                              .toStringAsFixed(2),
                        _ =>
                          (widget.product as AnnuitySavings)
                              .returnProfits()[3]
                              .toStringAsFixed(2),
                      },
                      ProductCategory.credit => switch (sortCriteria) {
                        "최저 금리(낮은 순)" =>
                          (widget.product as CreditLoan)
                              .returnRates()[0]
                              .toStringAsFixed(2),
                        "최고 금리(낮은 순)" =>
                          (widget.product as CreditLoan)
                              .returnRates()[2]
                              .toStringAsFixed(2),
                        _ =>
                          (widget.product as CreditLoan)
                              .returnRates()[1]
                              .toStringAsFixed(2),
                      },
                      ProductCategory.mortgage => switch (sortCriteria) {
                        "최저 금리(낮은 순)" =>
                          ((widget.product as MortageAndRentLoan)
                                      .returnRates()[0] ==
                                  null)
                              ? "미제공"
                              : (widget.product as MortageAndRentLoan)
                                    .returnRates()[0]!
                                    .toStringAsFixed(2),
                        "최고 금리(낮은 순)" =>
                          ((widget.product as MortageAndRentLoan)
                                      .returnRates()[0] ==
                                  null)
                              ? "미제공"
                              : (widget.product as MortageAndRentLoan)
                                    .returnRates()[2]!
                                    .toStringAsFixed(2),
                        _ =>
                          ((widget.product as MortageAndRentLoan)
                                      .returnRates()[1] ==
                                  null)
                              ? "미제공"
                              : (widget.product as MortageAndRentLoan)
                                    .returnRates()[1]!
                                    .toStringAsFixed(2),
                      },
                      ProductCategory.rent => switch (sortCriteria) {
                        "최저 금리(낮은 순)" =>
                          ((widget.product as MortageAndRentLoan)
                                      .returnRates()[0] ==
                                  null)
                              ? "미제공"
                              : (widget.product as MortageAndRentLoan)
                                    .returnRates()[0]!
                                    .toStringAsFixed(2),
                        "최고 금리(낮은 순)" =>
                          ((widget.product as MortageAndRentLoan)
                                      .returnRates()[0] ==
                                  null)
                              ? "미제공"
                              : (widget.product as MortageAndRentLoan)
                                    .returnRates()[2]!
                                    .toStringAsFixed(2),
                        _ =>
                          ((widget.product as MortageAndRentLoan)
                                      .returnRates()[1] ==
                                  null)
                              ? "미제공"
                              : (widget.product as MortageAndRentLoan)
                                    .returnRates()[1]!
                                    .toStringAsFixed(2),
                      },
                      _ => switch (sortCriteria) {
                        "평균 수익률(높은 순)" =>
                          (widget.product as IsaMpBenefitRate)
                              .returnAvgMedProfits()
                              .$1
                              .toStringAsFixed(2),
                        _ =>
                          (widget.product as IsaMpBenefitRate)
                              .returnAvgMedProfits()
                              .$2
                              .toStringAsFixed(2),
                      },
                    },
                    style: textTheme.titleMedium!.copyWith(color: colorScheme.onPrimary)
                  ),
                ],
              ),
              const SizedBox(width: 3.0),
              IconButton(
                onPressed: () {
                  ref
                      .read(productViewmodelProvider.notifier)
                      .toggleLiked(widget.product);
                },
                icon: isSelected
                    ? Icon(
                        Icons.check_circle,
                        color: colorScheme.surfaceContainerHigh,
                        size: 32.0,
                      )
                    : widget.product.commonInfo.isLiked
                    ? Icon(
                        Icons.favorite,
                        color: colorScheme.onPrimaryFixed,
                        size: 32.0,
                      )
                    : Icon(
                        Icons.favorite,
                        color: colorScheme.onPrimaryFixedVariant,
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
