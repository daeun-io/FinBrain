import 'package:finbrain/data/data_source/user_data_source.dart';
import 'package:finbrain/data/google_auth_service.dart';
import 'package:finbrain/data/model/entities/deposit_and_installment_savings_option.dart';
import 'package:finbrain/data/repository/url_repository.dart';
import 'package:finbrain/product_categories.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'product_detail_screen_viewmodel.g.dart';

// 상세 화면 뷰모델
@riverpod
class ProductDetailScreenViewmodel extends _$ProductDetailScreenViewmodel {
  final userDataSource = UserDataSource();

  @override
  Future<bool> build() async {
    final user = GoogleAuthService.getCurrentUser();
    if (user == null || user.displayName == null || user.email == null)
      return true;
    return userDataSource.readProductDetailTutorial(user);
  }

  // 계산기에 전달할 금융 상품 옵션 매핑하기
  // Map options to be delivered to calculator screen
  Map<String, List<String>> mapProductOptions(
    ProductCategory category,
    List<dynamic> options,
  ) {
    // 옵션 키 정의
    // Define options key
    List<String> keys = switch (category) {
      ProductCategory.deposit => ["예치 기간", "저축 금리 유형"],
      ProductCategory.installment => ["예치 종류", "예치 기간", "저축 금리 유형"],
      _ => ["상환 방법"],
    };
    // 대응하는 값 추출하기
    // Extract corresponding values
    final values = [];
    switch (category) {
      case ProductCategory.deposit:
        // 가입 개월(period)
        values.add(
          List.of(
            (options as List<DepositAndInstallmentSavingsOption>)
                .map((e) => "${e.saveTerm}개월")
                .toSet()
                .toList(),
          ),
        );
        // 단리/복리(interest rate type)
        values.add(
          List.of(
            options
                .map((e) => e.intRateTypeName!)
                .whereType<String>()
                .toSet()
                .toList(),
          ),
        );
      case ProductCategory.installment:
        // 정기적립식/자유적립식(reserve type name)
        values.add(
          List.of(
            (options as List<DepositAndInstallmentSavingsOption>)
                .map((e) => e.reserveTypeName!)
                .whereType<String>()
                .toSet()
                .toList(),
          ),
        );
        // 가입 개월(period)
        values.add(
          List.of(
            options
                .map((e) => "${e.saveTerm}개월")
                .whereType<String>()
                .toSet()
                .toList(),
          ),
        );
        // 단리/복리(interest rate type)
        values.add(
          List.of(
            options
                .map((e) => e.intRateTypeName!)
                .whereType<String>()
                .toSet()
                .toList(),
          ),
        );
      // 대출상환방법(repayment method)
      default:
        values.add(["원리금균등상환방식", "원금균등상환방식", "만기일시상환방식"]);
    }

    // Map으로 키-값 매핑하기
    // map key-value to Map
    Map<String, List<String>> map = {
      for (var i = 0; i < keys.length; i++) keys[i]: values[i],
    };
    return map;
  }

  // 상품 공식 페이지 검색 후 이동
  // Find official website and launch
  Future<bool> fetchAndOpenProductUrl(String companyName) async {
    try {
      final repository = UrlRepository();
      final urlString = await repository.fetchAndOpenProductUrl(companyName);
      return await repository.launchInBrowser(urlString);
    } catch (error) {
      return false;
    }
  }
}
