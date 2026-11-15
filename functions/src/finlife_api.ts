import { onRequest } from "firebase-functions/v2/https";
import { XMLParser } from "fast-xml-parser";
import type { ApiResult, Product } from "./finlife_types";

const BASE_URL = "http://finlife.fss.or.kr/finlifeapi";

const CATEGORY_PATH: Record<string, string> = {
  deposit: "depositProductsSearch.xml",
  installment: "savingProductsSearch.xml",
  mortgage: "mortgageLoanProductsSearch.xml",
  rent: "rentHouseLoanProductsSearch.xml",
  credit: "creditLoanProductsSearch.xml",
  business: "busiLoanProductsSearch.xml",
};

// 필터 기준 필드 (baseinfo 내부)
const COMPANY_FIELD = "kor_co_nm";
const JOIN_WAY_FIELD = "join_way";

export const fetchFinlifeProducts = onRequest(
  async (request, response) => {
    response.set("Access-Control-Allow-Origin", "*");

    try {
      // INPUT
      const key = String(request.query.auth ?? "");
      const category = String(request.query.category ?? "");
      const topFinGrpNo = String(request.query.topFinGrpNo ?? "");
      const selectedCompany = toStringArray(request.query.selectedCompany);
      const selectedJoinWay = toStringArray(request.query.selectedJoinWay);

      if (!CATEGORY_PATH[category]) {
        response
          .status(400)
          .send(`Invalid category. Allowed: ${Object.keys(CATEGORY_PATH).join(", ")}`);
        return;
      }
      if (!topFinGrpNo) {
        response.status(400).send("topFinGrpNo is required");
        return;
      }

      // 1. 첫 페이지 호출 및 JSON 변환
      const first = parsePage(await callApi(key, category, topFinGrpNo, 1));

      // 정상 응답 코드 확인 (000 = 정상)
      if (first.err_cd && first.err_cd !== "000") {
        response.status(200).json({ result: first });
        return;
      }

      let products: Product[] = [...(first.products?.product ?? [])];
      const maxPageNo = Number(first.max_page_no);

      // 2. max_page_no > 1 이면 나머지 페이지 호출 후 product만 결합
      if (maxPageNo > 1) {
        for (let pageNo = 2; pageNo <= maxPageNo; pageNo++) {
          const page = parsePage(await callApi(key, category, topFinGrpNo, pageNo));
          products = products.concat(page.products?.product ?? []);
        }
      }

      // 3. 금융회사, 가입 방법 모두 값이 있으면 필터링
      if (selectedCompany.length > 0 && selectedJoinWay.length > 0) {
        const companySet = new Set(selectedCompany);

        products = products.filter((p) => {
          const company = p.baseinfo?.[COMPANY_FIELD] ?? "";
          const joinWay = p.baseinfo?.[JOIN_WAY_FIELD] ?? "";

          const companyMatched = companySet.has(company);
          // join_way는 "영업점,인터넷,스마트폰"처럼 여러 값이 들어오므로 포함 여부로 비교
          const joinWayMatched = selectedJoinWay.some((w) => joinWay.includes(w));

          return companyMatched && joinWayMatched;
        });
      }

      // 4. 메타 값은 첫 페이지 것을 유지하고 products.product만 교체
      const result: ApiResult = {
        err_cd: first.err_cd,
        err_msg: first.err_msg,
        total_count: first.total_count,
        max_page_no: first.max_page_no,
        now_page_no: first.now_page_no,
        products: { product: products },
      };

      response.status(200).json({ result });
    } catch (error: any) {
      if (error?.status) {
        console.error(`API error ${error.status}: ${error.body}`);
        response.status(error.status).send(error.body);
        return;
      }
      console.error("Error occurred", error);
      response.status(500).send("Internal server error");
    }
  }
);

// XML -> JSON
const XML_ENCODING = "euc-kr";
const xmlDecoder = new TextDecoder(XML_ENCODING);

const xmlParser = new XMLParser({
  // 값을 문자열로 유지 (회사코드 "0010001", err_cd "000" 등의 앞자리 0 보존)
  parseTagValue: false,
  parseAttributeValue: false,
  trimValues: true,
  // 1건뿐이어도 항상 배열로 파싱
  isArray: (name) => name === "product" || name === "option",
});

function parsePage(xml: string): ApiResult {
  const result = xmlParser.parse(xml)?.result ?? {};

  // <products/>처럼 비어 있으면 빈 문자열("")로 파싱되므로 정규화
  const rawProducts = result.products;
  const productList: Product[] =
    rawProducts && typeof rawProducts === "object" ? rawProducts.product ?? [] : [];

  return {
    err_cd: String(result.err_cd ?? ""),
    err_msg: String(result.err_msg ?? ""),
    total_count: String(result.total_count ?? "0"),
    max_page_no: String(result.max_page_no ?? "1"),
    now_page_no: String(result.now_page_no ?? "1"),
    products: { product: productList },
  };
}

function toStringArray(value: unknown): string[] {
  if (value === undefined || value === null) return [];
  const arr = Array.isArray(value) ? value : [value];
  return arr.map((v) => String(v)).filter((v) => v.length > 0);
}

async function callApi(
  key: string,
  category: string,
  topFinGrpNo: string,
  pageNo: number
): Promise<string> {
  const urlObj = new URL(`${BASE_URL}/${CATEGORY_PATH[category]}`);
  urlObj.searchParams.set("auth", key);
  urlObj.searchParams.set("topFinGrpNo", topFinGrpNo);
  urlObj.searchParams.set("pageNo", String(pageNo));

  // 로그에 인증키가 남지 않도록 마스킹
  console.log(`url: ${urlObj.toString().replace(key, "***")}`);

  const res = await fetch(urlObj.toString());
  const buffer = await res.arrayBuffer();
  const body = xmlDecoder.decode(buffer);

  if (!res.ok) {
    const err: any = new Error(`API error: ${res.status}`);
    err.status = res.status;
    err.body = body;
    throw err;
  }
  return body;
}