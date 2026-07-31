import 'package:finbrain/product_categories.dart';

// 업권명을 업권 코드로 매핑
// Converter - map company category name to code
const getFinGroupCode = {
  "은행": "020000",
  "여신전문": "030200",
  "저축은행": "030300",
  "보험": "050000",
  "금융투자": "060000"
};

// 업권 코드를 업권명으로 매핑
// Converter - map company category code to name
const getFinGroupName = {
  "020000": "은행",
  "030200": "여신전문",
  "030300": "저축은행",
  "050000": "보험",
  "060000": "금융투자"
};

// 금융 상품 카테고리 컨버터(문자열 -> enum)
// Converter - map product category(string to enum)
const getCategoryEnum = {
  "ProductCategory.deposit": ProductCategory.deposit,
  "ProductCategory.installment": ProductCategory.installment,
  "ProductCategory.mortgage": ProductCategory.mortgage,
  "ProductCategory.rent": ProductCategory.rent,
  "ProductCategory.credit": ProductCategory.credit,
  "ProductCategory.isaMp": ProductCategory.isaMp
};