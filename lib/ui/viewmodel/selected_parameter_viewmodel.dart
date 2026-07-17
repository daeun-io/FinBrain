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
    print("=======================");
    print("🔥 changeTopFinGrp 호출됨! 넘어온 카테고리: $ctg, 번호: $topFinGrp");
    if (state.keys.contains(ctg)) {
      state = {...state, ctg: topFinGrp};
      print("✅ 상태 업데이트 완료: $state");
    } else {
      print("❌ 조건문 실패! state.keys에 '$ctg'가 없습니다.");
      print("=======================");
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
    print("=======================");
    print("🔥 changeBaseYear 호출됨! 넘어온 카테고리: $ctg, 번호: $baseYear");
    if (state.keys.contains(ctg)) {
      state = {...state, ctg: baseYear};
      print("✅ 상태 업데이트 완료: $state");
    } else {
      print("❌ 조건문 실패! state.keys에 '$ctg'가 없습니다.");
      print("=======================");
    }
  }
}
