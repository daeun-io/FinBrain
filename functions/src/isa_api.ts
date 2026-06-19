import { onRequest } from "firebase-functions/https";
import { transformApiResponse } from "./isa_transform";

export const fetchAndGroupProducts = onRequest(async (request, response) => {
  response.set("Access-Control-Allow-Origin", "*");

  try {
    const serviceKey = request.query.serviceKey as string;
    const resultType = request.query.resultType as string;
    const pageNo = request.query.pageNo as string;
    const numOfRows = request.query.numOfRows as string;
    const url = `https://apis.data.go.kr/1160100/GetISAInfoService_V2/getMPBenefitRateInfo_V2?key:${serviceKey}&resultType=${resultType}&pageNo=${pageNo}&numOfRows=${numOfRows}`;

    const res = await fetch(url);

    if(!res.ok){
      response.status(res.status).send("Failed to load API");
      return;
    }

    const raw = await res.json();
    const transformed = transformApiResponse(raw);
    response.status(200).send(transformed);

  } catch(error) {
    console.error("Error occurred", error);
    response.status(500).send("Internal servere error");
  }
});

// export async function fetchAndGroupProducts(
  // apiUrl: string,
  // apiKey: string,
  // options: FetchOptions = {}
// ): Promise<IsaMpGroupedApiResponse> {
  // const { pageNo = 1, numOfRows = 10 } = options;
// 
  // const url = new URL(apiUrl);
  // url.searchParams.set("serviceKey", apiKey);
  // url.searchParams.set("pageNo", String(pageNo));
  // url.searchParams.set("numOfRows", String(numOfRows));
  // url.searchParams.set("resultType", "json");
// 
  // const res = await fetch(url.toString());
// 
  // if (!res.ok) {
    // throw new Error(`API 호출 실패: ${res.status} ${res.statusText}`);
  // }
// 
  // const raw = await res.json();
  // return transformApiResponse(raw);
// }