import { onRequest } from "firebase-functions/https";
import { XMLParser } from "fast-xml-parser";
import type { CmpyNameApiResponse } from "./cmpy_types";
import { transformToCmpyName } from "./cmpy_transform";

const xmlParser = new XMLParser({
  ignoreAttributes: true,
  trimValues: true,
  isArray: (_tagName, jPath) => {
    // product가 1개일 때도 배열로 처리
    return jPath === "result.products.product";
  },
});

// XML -> CmpyNameApiResponse
export function parseXmlToCmpyName(xml: string): CmpyNameApiResponse {
  const parsed = xmlParser.parse(xml);
  return transformToCmpyName(parsed);
}

// API 호출 후 Json 반환
export const fetchCmpyNameList = onRequest(async (request, response) => {
  response.set("Access-Control-Allow-Origin", "*");

  try {
    const auth = request.query.auth as string;
    const pageNo = request.query.pageNo as string;
    const topFinGrpNo = request.query.topFinGrpNo as string;
    const url = `http://finlife.fss.or.kr/finlifeapi/companySearch.xml?key:${auth}&topFinGrpNo=${topFinGrpNo}&pageNo=${pageNo}`;

    const res = await fetch(url);
    if(!res.ok){
      response.status(res.status).send("Failed to load API");
      return;
    }
    
    const xml = await res.text();
    const parsed = parseXmlToCmpyName(xml);
    response.status(200).json(parsed);

  } catch(error){
    console.error("Error occurred", error);
    response.status(500).send("Internal servere error");
  }
});

// export async function fetchCmpyNameUrlList(
  // apiUrl: string,
  // apiKey: string,
  // options: FetchOptions = {}
// ): Promise<CmpyNameUrlApiResponse> {
  // const { pageNo = 1, topFinGrpNo = "020000"} = options;
// 
  // const url = new URL(apiUrl);
  // url.searchParams.set("auth", apiKey);
  // url.searchParams.set("topFinGrpNo", topFinGrpNo);
  // url.searchParams.set("pageNo", String(pageNo));
  // 
// 
  // const res = await fetch(url.toString(), {
    // headers: { Accept: "application/xml, text/xml" },
  // });
// 
  // if (!res.ok) {
    // throw new Error(`API 호출 실패: ${res.status} ${res.statusText}`);
  // }
// 
  // const xml = await res.text();
  // return parseXmlToCmpyNameUrl(xml);
// }
// 