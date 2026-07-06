import 'package:finbrain/data/model/entities/financial_product.dart';
import 'package:finbrain/product_categories.dart';
import 'package:finbrain/ui/viewmodel/liked_product_viewmodel.dart';
import 'package:finbrain/ui/viewmodel/sort_or_filter_viewmodel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

/// Minimal concrete [FinancialProduct] used purely for exercising the
/// filtering/sorting logic in [LikedProductViewmodel]. The real subclasses
/// (DepositAndInstallmentSavings, CreditLoan, ...) require many unrelated
/// fields that are irrelevant to the behaviour under test here.
class _TestProduct extends FinancialProduct {
  _TestProduct(super.commonInfo);

  @override
  FinancialProduct copyWith(bool isLiked) {
    return _TestProduct(
      CommonInfo(
        category: commonInfo.category,
        companyName: commonInfo.companyName,
        productName: commonInfo.productName,
        isLiked: isLiked,
      ),
    );
  }

  @override
  Map<String, Object> toMap() => {};
}

FinancialProduct _product(
  ProductCategory category,
  String name, {
  bool isLiked = false,
}) {
  return _TestProduct(
    CommonInfo(
      category: category,
      companyName: 'Test Bank',
      productName: name,
      isLiked: isLiked,
    ),
  );
}

void main() {
  // Note: GoogleAuthService.getCurrentUser() reaches into
  // FirebaseAuth.instance, which throws (no Firebase app has been
  // initialized in this plain `flutter_test` environment). Every call site
  // in liked_product_viewmodel.dart guards this behind a try/catch and
  // treats "no signed in user" and "error retrieving user" identically, so
  // the resulting behaviour (empty list / no state mutation) is
  // deterministic regardless of which branch actually fires.

  late FinancialProduct deposit;
  late FinancialProduct installment;
  late FinancialProduct isa;
  late FinancialProduct annuity;
  late List<FinancialProduct> allProducts;

  setUp(() {
    deposit = _product(ProductCategory.deposit, 'Deposit A');
    installment = _product(ProductCategory.installment, 'Installment B');
    isa = _product(ProductCategory.isa, 'ISA C');
    annuity = _product(ProductCategory.annuity, 'Annuity D');
    allProducts = [deposit, installment, isa, annuity];
  });

  group('FetchLikedViewmodel', () {
    test(
      'build() resolves to an empty list when no user is signed in / auth is unavailable',
      () async {
        final container = ProviderContainer();
        addTearDown(container.dispose);

        final result = await container.read(
          fetchLikedViewmodelProvider.future,
        );

        expect(result, isEmpty);
      },
    );
  });

  group('LikedProductViewmodel.build', () {
    test(
      'derives its initial state from FetchLikedViewmodel (empty when unauthenticated)',
      () async {
        final container = ProviderContainer();
        addTearDown(container.dispose);

        final result = await container.read(
          likedProductViewmodelProvider.future,
        );

        expect(result, isEmpty);
      },
    );
  });

  group('LikedProductViewmodel.filterByCategory', () {
    late ProviderContainer container;
    late LikedProductViewmodel notifier;

    setUp(() async {
      container = ProviderContainer();
      addTearDown(container.dispose);
      // Make sure the initial async build settles before invoking methods
      // directly on the notifier.
      await container.read(likedProductViewmodelProvider.future);
      notifier = container.read(likedProductViewmodelProvider.notifier);
    });

    test('returns only the products matching a single category', () {
      final filtered = notifier.filterByCategory('정기예금', allProducts);

      expect(filtered, [deposit]);
    });

    test('returns the union of products for multiple comma separated categories', () {
      final filtered = notifier.filterByCategory(
        '정기예금, 적금',
        allProducts,
      );

      expect(filtered, containsAll([deposit, installment]));
      expect(filtered, hasLength(2));
    });

    test('"모든 상품" selects every product category', () {
      final filtered = notifier.filterByCategory('모든 상품', allProducts);

      expect(filtered, containsAll(allProducts));
      expect(filtered, hasLength(allProducts.length));
    });

    test('"모든 상품" takes precedence even when combined with other categories', () {
      final filtered = notifier.filterByCategory(
        '모든 상품, 정기예금',
        allProducts,
      );

      expect(filtered, containsAll(allProducts));
    });

    test('returns an empty list when the criteria matches no known category', () {
      final filtered = notifier.filterByCategory('알수없음', allProducts);

      expect(filtered, isEmpty);
    });

    test(
      'does NOT match the "연금 저축" (with space) label used by the filter UI, '
      'because the implementation only checks for "연금저축" (no space)',
      () {
        final filtered = notifier.filterByCategory('연금 저축', allProducts);

        expect(
          filtered,
          isEmpty,
          reason:
              'This documents a mismatch between the option label exposed by '
              'SortOrFilterTextViewModel ("연금 저축") and the string checked '
              'in filterByCategory ("연금저축"). If this test starts failing '
              'because the strings were reconciled, that is a desirable fix.',
        );
      },
    );

    test('matches "연금저축" (no space), the exact string currently checked in code', () {
      final filtered = notifier.filterByCategory('연금저축', allProducts);

      expect(filtered, [annuity]);
    });

    test('falls back to the last fetched products when no explicit list is passed', () async {
      // With no user signed in, the fetched list resolves to [].
      final filtered = notifier.filterByCategory('모든 상품');

      expect(filtered, isEmpty);
    });

    test('updates the provider state as a side effect', () {
      notifier.filterByCategory('정기예금', allProducts);

      expect(container.read(likedProductViewmodelProvider).value, [deposit]);
    });

    test('trims whitespace around each category token', () {
      final filtered = notifier.filterByCategory(
        '  정기예금 ,   적금  ',
        allProducts,
      );

      expect(filtered, containsAll([deposit, installment]));
      expect(filtered, hasLength(2));
    });
  });

  group('LikedProductViewmodel.getProductsFilteredByCriteria', () {
    late ProviderContainer container;
    late LikedProductViewmodel notifier;

    setUp(() async {
      container = ProviderContainer();
      addTearDown(container.dispose);
      await container.read(likedProductViewmodelProvider.future);
      notifier = container.read(likedProductViewmodelProvider.notifier);
    });

    test('uses the default "모든 상품" criteria to return every product', () {
      final result = notifier.getProductsFilteredByCriteria(allProducts);

      expect(result, containsAll(allProducts));
      expect(result, hasLength(allProducts.length));
    });

    test('reflects criteria changes made via SortOrFilterTextViewModel', () {
      container
          .read(
            sortOrFilterTextViewModelProvider(
              FilterTextCategory.liked,
            ).notifier,
          )
          .changeCriteria(['정기예금', '적금']);

      final result = notifier.getProductsFilteredByCriteria(allProducts);

      expect(result, containsAll([deposit, installment]));
      expect(result, hasLength(2));
    });

    test('returns an empty list when passed no products and nothing has been fetched', () {
      final result = notifier.getProductsFilteredByCriteria();

      expect(result, isEmpty);
    });
  });

  group('LikedProductViewmodel.addInLikedList', () {
    test('does not mutate state when there is no authenticated user', () async {
      final container = ProviderContainer();
      addTearDown(container.dispose);
      await container.read(likedProductViewmodelProvider.future);
      final notifier = container.read(likedProductViewmodelProvider.notifier);

      await notifier.addInLikedList(deposit);

      expect(container.read(likedProductViewmodelProvider).value, isEmpty);
    });

    test('does not throw when invoked without a signed-in user', () async {
      final container = ProviderContainer();
      addTearDown(container.dispose);
      await container.read(likedProductViewmodelProvider.future);
      final notifier = container.read(likedProductViewmodelProvider.notifier);

      await expectLater(notifier.addInLikedList(deposit), completes);
    });
  });

  group('LikedProductViewmodel.deleteInLikedList', () {
    test('does not mutate state when there is no authenticated user', () async {
      final container = ProviderContainer();
      addTearDown(container.dispose);
      await container.read(likedProductViewmodelProvider.future);
      final notifier = container.read(likedProductViewmodelProvider.notifier);

      await notifier.deleteInLikedList(deposit);

      expect(container.read(likedProductViewmodelProvider).value, isEmpty);
    });

    test('does not throw when invoked without a signed-in user', () async {
      final container = ProviderContainer();
      addTearDown(container.dispose);
      await container.read(likedProductViewmodelProvider.future);
      final notifier = container.read(likedProductViewmodelProvider.notifier);

      await expectLater(notifier.deleteInLikedList(deposit), completes);
    });
  });

  group('LikedProductViewmodel.filterByKeyword', () {
    late ProviderContainer container;
    late LikedProductViewmodel notifier;

    setUp(() async {
      container = ProviderContainer();
      addTearDown(container.dispose);
      await container.read(likedProductViewmodelProvider.future);
      notifier = container.read(likedProductViewmodelProvider.notifier);
    });

    test('filters the current state by a matching keyword substring', () {
      notifier.filterByCategory('모든 상품', allProducts);

      notifier.filterByKeyword('Deposit');

      expect(container.read(likedProductViewmodelProvider).value, [deposit]);
    });

    test('returns an empty list when no product matches the keyword', () {
      notifier.filterByCategory('모든 상품', allProducts);

      notifier.filterByKeyword('NoMatch');

      expect(container.read(likedProductViewmodelProvider).value, isEmpty);
    });

    test(
      'resets to the criteria-filtered product list when the keyword is cleared',
      () {
        notifier.filterByCategory('정기예금', allProducts);
        notifier.filterByKeyword('Deposit');
        expect(
          container.read(likedProductViewmodelProvider).value,
          [deposit],
        );

        notifier.filterByKeyword('');

        // getProductsFilteredByCriteria() falls back to the last fetched
        // products (empty, since there is no authenticated user), not the
        // list previously passed explicitly to filterByCategory.
        expect(container.read(likedProductViewmodelProvider).value, isEmpty);
      },
    );
  });
}