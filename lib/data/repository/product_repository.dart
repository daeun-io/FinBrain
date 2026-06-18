import 'package:finbrain/data/dummy_data.dart';
import 'package:finbrain/data/model/entities/financial_product.dart';

class ProductRepository {
  Future<List<FinancialProduct>> fetchProducts() async {
    return dummyData;
  }
}
