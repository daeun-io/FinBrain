import { onRequest } from "firebase-functions/https";
import type { CmpyNameApiResponse } from "./cmpy_types";
import { transformToCmpyName } from "./cmpy_transform";
import iconv from "iconv-lite";
import { parseStringPromise } from "xml2js";

// XML -> CmpyNameApiResponse
async function parseXmlToCmpyName(xml: string): Promise<CmpyNameApiResponse> {
  const parsed = await parseStringPromise(xml, { explicitArray: false });
  return transformToCmpyName(parsed);
}

// API 호출 후 Json 반환
export const fetchCmpyNameList = onRequest(async (request, response) => {
  response.set("Access-Control-Allow-Origin", "*");

  try {
    const baseUrl = "http://finlife.fss.or.kr/finlifeapi/companySearch.xml";
    const urlObj = new URL(baseUrl);

    if(request.query){
      Object.keys(request.query).forEach((key) => {
        urlObj.searchParams.append(key, request.query[key] as string);
      });
    }

    const url = urlObj.toString();
    console.log(`url: ${url}`);
    
    const res = await fetch(url);
    
    if(!res.ok){
      const errorBody = await res.text();
      console.log(`error: ${errorBody}`);
      response.status(res.status).send(errorBody);
      return;
    }

    const arrayBuffer = await res.arrayBuffer();
    const buffer = Buffer.from(arrayBuffer);
    
    const decodeXml = iconv.decode(buffer, "euc-kr");
    const parsed = await parseXmlToCmpyName(decodeXml);
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