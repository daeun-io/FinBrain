import * as functions from "firebase-functions";
import { XMLParser } from "fast-xml-parser";
import type { CmpyNameApiResponse } from "./cmpy_types";
import { transformToCmpyName } from "./cmpy_transform";
import { FetchOptions } from "./fetch_options";

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
export const fetchCmpyNameList = functions.https.onCall(async (request: functions.https.CallableRequest<FetchOptions>) => {
  // call auth later
  const { data } = request;
  const url = new URL(data.url);
  url.searchParams.set("auth", data.key);
  url.searchParams.set("topFinGrpNo", String(data.topFinGrpNo));
  url.searchParams.set("pageNo", String(data.pageNo));

  try {
    const res = await fetch(url, {
      headers: {Accept: "application/xml, text/xml"},
    });

    if (!res.ok) {
      throw new Error(`Failed to call API: ${res.status} ${res.statusText}`);
    }

    const xml = await res.text();
    const parsed = parseXmlToCmpyName(xml);
    return { success: true, data: parsed };

  }catch(error) {
    console.error(error);
    throw new functions.https.HttpsError("internal", String(error));
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