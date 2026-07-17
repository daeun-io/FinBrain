import 'package:finbrain/data/model/entities/credit_loan.dart';
import 'package:finbrain/data/model/entities/deposit_and_installment_savings.dart';
import 'package:finbrain/data/model/entities/financial_product.dart';
import 'package:finbrain/data/model/entities/isa_mp_benefit_rate.dart';
import 'package:finbrain/data/model/entities/mortgage_and_rent_loan.dart';
import 'package:finbrain/ui/viewmodel/current_page_viewmodel.dart';
import 'package:finbrain/ui/viewmodel/liked_product_viewmodel.dart';
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
    required this.productName,
    required this.category,
    required this.fromLikedScreen,
  });

  final String productName;
  final ProductCategory category;
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

    final page = ref.watch(currentPageViewmodelProvider(widget.category));
    final productList = ref.watch(
      fetchProductViewmodelProvider(widget.category, "$page"),
    );
    final likedList = ref.watch(fetchLikedViewmodelProvider);

    return ((widget.fromLikedScreen) ? likedList : productList).when(
      data: (data) {
        final product =
            ((widget.fromLikedScreen)
                    ? data as List<FinancialProduct>
                    : (data as (int, List<FinancialProduct>)).$2)
                .where((e) => e.commonInfo.productName == widget.productName)
                .firstOrNull;
        if (product == null) return const SizedBox.shrink();
        final sortFilter = ref.watch(
          sortOrFilterTextViewModelProvider(product.commonInfo.category),
        );
        final sortCriteria =
            (product.commonInfo.category == ProductCategory.liked)
            ? switch (product.commonInfo.category) {
                ProductCategory.deposit => "최고 금리(높은 순)",
                ProductCategory.installment => "최고 금리(높은 순)",
                ProductCategory.isaMp => "평균 수익률(높은 순)",
                _ => "최저 금리(낮은 순)",
              }
            : sortFilter.$1.toString();

        return GestureDetector(
          onTap: () {
            print("==============");
            print("product item tapped");
            Navigator.of(context, rootNavigator: true).push(
              MaterialPageRoute(
                builder: (ctx) => ProductDetailScreen(
                  productName: product.commonInfo.productName!,
                  category: product.commonInfo.category,
                  fromLikedScreen: widget.fromLikedScreen,
                ),
              ),
            );
          },
          onLongPress: () {
            setState(() {
              if (product.commonInfo.isLiked) {
                isSelected = !isSelected;
              }
              if (isSelected) {
                ref
                    .read(selectedProductsViewmodelProvider.notifier)
                    .addProduct(product);
              } else {
                ref
                    .read(selectedProductsViewmodelProvider.notifier)
                    .subtractProduct(product);
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
                          product.commonInfo.productName!.replaceAll(
                            r'\\n',
                            "",
                          ),
                          style: textTheme.bodyMedium!.copyWith(
                            color: colorScheme.onPrimary,
                          ),
                        ),
                        const SizedBox(height: 6.0),
                        Text(
                          product.commonInfo.companyName!,
                          style: textTheme.bodySmall!.copyWith(
                            color: colorScheme.onTertiary,
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
                        sortCriteria.split('(').first,
                        style: textTheme.titleSmall!.copyWith(
                          color: colorScheme.onTertiary,
                        ),
                      ),
                      const SizedBox(height: 6.0),
                      Text(
                        switch (product.commonInfo.category) {
                          ProductCategory.deposit =>
                            (sortCriteria == "최고 금리(높은 순)")
                                ? (product as DepositAndInstallmentSavings)
                                      .returnHighestRateValue()
                                      .$1
                                      .toStringAsFixed(2)
                                : (product as DepositAndInstallmentSavings)
                                      .returnHighestRateValue()
                                      .$2
                                      .toStringAsFixed(2),
                          ProductCategory.installment =>
                            (sortCriteria == "최고 금리(높은 순)")
                                ? (product as DepositAndInstallmentSavings)
                                      .returnHighestRateValue()
                                      .$1
                                      .toStringAsFixed(2)
                                : (product as DepositAndInstallmentSavings)
                                      .returnHighestRateValue()
                                      .$2
                                      .toStringAsFixed(2),
                          ProductCategory.credit => switch (sortCriteria) {
                            "최저 금리(낮은 순)" =>
                              (product as CreditLoan)
                                  .returnRates()[0]
                                  .toStringAsFixed(2),
                            "최고 금리(낮은 순)" =>
                              (product as CreditLoan)
                                  .returnRates()[2]
                                  .toStringAsFixed(2),
                            _ =>
                              (product as CreditLoan)
                                  .returnRates()[1]
                                  .toStringAsFixed(2),
                          },
                          ProductCategory.mortgage => switch (sortCriteria) {
                            "최저 금리(낮은 순)" =>
                              ((product as MortgageAndRentLoan)
                                          .returnRates()[0] ==
                                      null)
                                  ? "미제공"
                                  : product.returnRates()[0]!.toStringAsFixed(
                                      2,
                                    ),
                            "최고 금리(낮은 순)" =>
                              ((product as MortgageAndRentLoan)
                                          .returnRates()[2] ==
                                      null)
                                  ? "미제공"
                                  : product.returnRates()[2]!.toStringAsFixed(
                                      2,
                                    ),
                            _ =>
                              ((product as MortgageAndRentLoan)
                                          .returnRates()[1] ==
                                      null)
                                  ? "미제공"
                                  : product.returnRates()[1]!.toStringAsFixed(
                                      2,
                                    ),
                          },
                          ProductCategory.rent => switch (sortCriteria) {
                            "최저 금리(낮은 순)" =>
                              ((product as MortgageAndRentLoan)
                                          .returnRates()[0] ==
                                      null)
                                  ? "미제공"
                                  : product.returnRates()[0]!.toStringAsFixed(
                                      2,
                                    ),
                            "최고 금리(낮은 순)" =>
                              ((product as MortgageAndRentLoan)
                                          .returnRates()[0] ==
                                      null)
                                  ? "미제공"
                                  : product.returnRates()[2]!.toStringAsFixed(
                                      2,
                                    ),
                            _ =>
                              ((product as MortgageAndRentLoan)
                                          .returnRates()[1] ==
                                      null)
                                  ? "미제공"
                                  : product.returnRates()[1]!.toStringAsFixed(
                                      2,
                                    ),
                          },
                          _ => switch (sortCriteria) {
                            "평균 수익률(높은 순)" =>
                              (product as IsaMpBenefitRate)
                                  .returnAvgMedProfits()
                                  .$1
                                  .toStringAsFixed(2),
                            _ =>
                              (product as IsaMpBenefitRate)
                                  .returnAvgMedProfits()
                                  .$2
                                  .toStringAsFixed(2),
                          },
                        },
                        style: textTheme.titleMedium!.copyWith(
                          color: colorScheme.onPrimary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 3.0),
                  IconButton(
                    onPressed: () {
                      final page = ref.read(
                        currentPageViewmodelProvider(widget.category),
                      );
                      ref
                          .read(
                            fetchProductViewmodelProvider(
                              widget.category,
                              "$page",
                            ).notifier,
                          )
                          .toggleLiked(product);
                    },
                    icon: isSelected
                        ? Icon(
                            Icons.check_circle,
                            color: colorScheme.surfaceContainerHigh,
                            size: 32.0,
                          )
                        : product.commonInfo.isLiked
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
      },
      error: (err, stack) => const SizedBox.shrink(),
      loading: () => const SizedBox.shrink()
    );
  }
}
