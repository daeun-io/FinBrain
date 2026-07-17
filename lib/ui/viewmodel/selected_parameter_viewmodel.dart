import 'package:finbrain/product_categories.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'selected_parameter_viewmodel.g.dart';

@Riverpod(keepAlive: true)
@riverpod
class SelectedTopFinGrpNoViewmodel extends _$SelectedTopFinGrpNoViewmodel {
  @override
  Map<ProductCategory, String> build() {
    return {
      ProductCategory.deposit: "020000",
      ProductCategory.installment: "020000",
      ProductCategory.mortgage: "020000",
      ProductCategory.rent: "020000",
      ProductCategory.credit: "020000",
    };
  }

  void changeTopFinGrp(ProductCategory ctg, String topFinGrp) {
    if (state.keys.contains(ctg)) {
      state = {...state, ctg: topFinGrp};
    }
  }
}

@Riverpod(keepAlive: true)
@riverpod
class SelectedBaseYearViewmodel extends _$SelectedBaseYearViewmodel {
  @override
  Map<ProductCategory, int> build() {
    return {
      ProductCategory.isaJoin: DateTime.now().year,
      ProductCategory.isaManagement: DateTime.now().year,
      ProductCategory.isaMp: DateTime.now().year,
    };
  }

  void changeBaseYear(ProductCategory ctg, int baseYear) {
    if (state.keys.contains(ctg)) {
      state = {...state, ctg: baseYear};
    }
  }
}
