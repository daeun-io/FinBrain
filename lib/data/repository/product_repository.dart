import 'package:finbrain/data/dummy_data.dart';
import 'package:finbrain/data/models/entities/financial_product.dart';

class ProductRepository {
  Future<List<FinancialProduct>> fetchProducts() async {
    return dummyData;
  }
}
