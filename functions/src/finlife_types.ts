export interface Product {
  baseinfo: Record<string, string>;
  options?: { option: Record<string, string>[] } | string;
}

export interface ApiResult {
  err_cd: string;
  err_msg: string;
  total_count: string;
  max_page_no: string;
  now_page_no: string;
  products?: { product: Product[] };
}