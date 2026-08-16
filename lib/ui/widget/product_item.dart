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
import 'package:finbrain/ui/viewmodel/text_theme_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 상품 아이템
class ProductItem extends ConsumerStatefulWidget {
  const ProductItem({
    super.key,
    required this.productCode,
    required this.productName,
    required this.category,
    required this.fromLikedScreen,
    required this.isSelecting,
  });

  final String productCode;
  final String productName;
  final ProductCategory category;
  final bool fromLikedScreen;
  final bool isSelecting;

  @override
  ConsumerState<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends ConsumerState<ProductItem> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = ref.watch(textThemeViewmodelProvider);

    final cPage = ref.watch(currentPageViewmodelProvider(widget.category));
    final productList = ref.watch(
      fetchProductViewmodelProvider(widget.category, cPage),
    );
    final likedList = ref.watch(fetchLikedViewmodelProvider);

    // 부모 스크린에 따라 관찰하기
    // Watch data based on parent screen
    return ((widget.fromLikedScreen) ? likedList : productList).when(
      data: (data) {
        final product =
            ((widget.fromLikedScreen)
                    ? data as List<FinancialProduct>
                    : (data as (int, List<FinancialProduct>)).$2)
                .where(
                  (e) => (widget.category == ProductCategory.isaMp)
                      ? e.commonInfo.productName == widget.productName
                      : e.commonInfo.productCode == widget.productCode,
                )
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
        final isSelected = ref
            .watch(selectedProductsViewmodelProvider)
            .contains(product);

        return GestureDetector(
          onTap: () {
            Navigator.of(context, rootNavigator: true).push(
              MaterialPageRoute(
                builder: (ctx) => ProductDetailScreen(
                  productCode: product.commonInfo.productCode ?? "isaMp",
                  productName: product.commonInfo.productName!,
                  category: product.commonInfo.category,
                  fromLikedScreen: widget.fromLikedScreen,
                ),
              ),
            );
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
                        // 상품명(product name)
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
                        // 회사명(company name)
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
                      // 정렬 기준(sort criteria)
                      Text(
                        sortCriteria.split('(').first,
                        style: textTheme.titleSmall!.copyWith(
                          color: colorScheme.onTertiary,
                        ),
                      ),
                      const SizedBox(height: 6.0),
                      // 정렬 기준에 따른 값
                      // Value based on sort criteria
                      Text(
                        switch (product.commonInfo.category) {
                          ProductCategory.deposit ||
                          ProductCategory.installment =>
                            (sortCriteria == "최고 금리(높은 순)")
                                ? ((product as DepositAndInstallmentSavings)
                                              .maxPrfRate ==
                                          null)
                                      ? "미제공"
                                      : product.maxPrfRate!.toStringAsFixed(2)
                                : ((product as DepositAndInstallmentSavings)
                                          .maxBaseRate ==
                                      null)
                                ? "미제공"
                                : product.maxBaseRate!.toStringAsFixed(2),
                          ProductCategory.credit => switch (sortCriteria) {
                            "최저 금리(낮은 순)" =>
                              ((product as CreditLoan).minRate == null)
                                  ? "미제공"
                                  : product.minRate!.toStringAsFixed(2),
                            "최고 금리(낮은 순)" =>
                              ((product as CreditLoan).maxRate == null)
                                  ? "미제공"
                                  : product.maxRate!.toStringAsFixed(2),
                            _ =>
                              ((product as CreditLoan).avgRate == null)
                                  ? "미제공"
                                  : product.avgRate!.toStringAsFixed(2),
                          },
                          ProductCategory.mortgage ||
                          ProductCategory.rent => switch (sortCriteria) {
                            "최저 금리(낮은 순)" =>
                              ((product as MortgageAndRentLoan).minRate == null)
                                  ? "미제공"
                                  : product.minRate!.toStringAsFixed(2),
                            "최고 금리(낮은 순)" =>
                              ((product as MortgageAndRentLoan).maxRate == null)
                                  ? "미제공"
                                  : product.maxRate!.toStringAsFixed(2),
                            _ =>
                              ((product as MortgageAndRentLoan).avgRate == null)
                                  ? "미제공"
                                  : product.avgRate!.toStringAsFixed(2),
                          },
                          _ => switch (sortCriteria) {
                            "평균 수익률(높은 순)" =>
                              ((product as IsaMpBenefitRate).avgProfit == null)
                                  ? "미제공"
                                  : product.avgProfit!.toStringAsFixed(2),
                            _ =>
                              ((product as IsaMpBenefitRate).medProfit == null)
                                  ? "미제공"
                                  : product.medProfit!.toStringAsFixed(2),
                          },
                        },
                        style: textTheme.titleMedium!.copyWith(
                          color: colorScheme.onPrimary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 3.0),
                  if (!widget.isSelecting)
                    // 관심 버튼
                    // liked button
                    IconButton(
                      onPressed: () {
                        final page = ref.read(
                          currentPageViewmodelProvider(widget.category),
                        );
                        ref
                            .read(
                              fetchProductViewmodelProvider(
                                widget.category,
                                page,
                              ).notifier,
                            )
                            .toggleLiked(product);
                      },
                      icon: product.commonInfo.isLiked
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
      loading: () => const SizedBox.shrink(),
    );
  }
}
