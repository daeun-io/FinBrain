import 'package:finbrain/product_categories.dart';

const getFinGroupCode = {
  "은행": "020000",
  "여신전문": "030200",
  "저축은행": "030300",
  "보험": "050000",
  "금융투자": "060000"
};

const getFinGroupName = {
  "020000": "은행",
  "030200": "여신전문",
  "030300": "저축은행",
  "050000": "보험",
  "060000": "금융투자"
};

const getCategoryEnum = {
  "ProductCategory.deposit": ProductCategory.deposit,
  "ProductCategory.installment": ProductCategory.installment,
  "ProductCategory.mortage": ProductCategory.mortage,
  "ProductCategory.rent": ProductCategory.rent,
  "ProductCategory.credit": ProductCategory.credit,
  "ProductCategory.annuity": ProductCategory.annuity,
  "ProductCategory.isa": ProductCategory.isa
};