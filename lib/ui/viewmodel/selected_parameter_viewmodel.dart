import 'package:finbrain/product_categories.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'selected_parameter_viewmodel.g.dart';

// 상품 카테고리별 업권
// Company category by product category
@Riverpod(keepAlive: true)
@riverpod
class SelectedTopFinGrpNoViewmodel extends _$SelectedTopFinGrpNoViewmodel {
  // 기본 회사 카테고리
  // Default company category
  @override
  Map<ProductCategory, String> build() {
    return {
      ProductCategory.deposit: "020000",        // 은행(bank)
      ProductCategory.installment: "020000",    // 은행(bank)
      ProductCategory.mortgage: "020000",       // 은행(bank)
      ProductCategory.rent: "020000",           // 은행(bank)
      ProductCategory.credit: "020000",         // 은행(bank)
    };
  }

  // 업권 변경
  // Change company category(financial group)
  void changeTopFinGrp(ProductCategory ctg, String topFinGrp) {
    if (state.keys.contains(ctg)) {
      state = {...state, ctg: topFinGrp};
    }
  }
}

// ISA 다모아 API 기준년도
// ISA base year parameter
@Riverpod(keepAlive: true)
@riverpod
class SelectedBaseYearViewmodel extends _$SelectedBaseYearViewmodel {
  // 기본 기준 년도(올해)
  // Default base year(this year)
  @override
  Map<ProductCategory, int> build() {
    return {
      ProductCategory.isaJoin: DateTime.now().year,
      ProductCategory.isaManagement: DateTime.now().year,
      ProductCategory.isaMp: DateTime.now().year,
    };
  }

  // 기준 년도 변경
  void changeBaseYear(ProductCategory ctg, int baseYear) {
    if (state.keys.contains(ctg)) {
      state = {...state, ctg: baseYear};
    }
  }
}
