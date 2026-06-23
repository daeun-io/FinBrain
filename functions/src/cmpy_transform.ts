import type { CmpyNameApiResponse, Company } from "./cmpy_types";

// 단일 항목 배열로 정규화
function normalizeArray<T>(value: T | T[] | undefined): T[] {
  if (!value) return [];
  return Array.isArray(value) ? value : [value];
}

// XML 파싱 결과
interface ParsedXmlResult {
  result: {
    err_cd: string;
    err_msg: string;
    total_count: string;
    max_page_no?: string;
    now_page_no?: string;
    products?: {
      product: Company[],
    }
  };
}

// kor_co_nm만 추출해 Json으로 변환
export function transformToCmpyName(parsed: ParsedXmlResult): CmpyNameApiResponse {
  const { result } = parsed;
  const products = normalizeArray(result.products?.product);
  const cmpyList = products.map((product) => product.baseinfo.kor_co_nm);

  return {
    result: {
      err_cd: result.err_cd,
      err_msg: result.err_msg,
      total_count: result.total_count,
      max_page_no: result.max_page_no,
      now_page_no: result.now_page_no,
      products: cmpyList,
    },
  };
}