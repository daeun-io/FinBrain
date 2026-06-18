import * as functions from "firebase-functions";
import { transformApiResponse } from "./isa_transform";
import { FetchOptions } from "./fetch_options";

export const fetchAndGroupProducts = functions.https.onCall(async (request: functions.https.CallableRequest<FetchOptions>) => {
  // call auth later
  const { data } = request;
  const url = new URL(data.url);
  url.searchParams.set("serviceKey", data.key);
  url.searchParams.set("pageNo", String(data.pageNo));
  url.searchParams.set("numOfRows", String(data.numOfRows));
  url.searchParams.set("resultType", "json");

  try {
    const res = await fetch(url);

    if (!res.ok) {
      throw new Error(`Failed to call API: ${res.status} ${res.statusText}`);
    }
    
    const raw = await res.json();
    const transformed = transformApiResponse(raw);
    return { success: true, data: transformed };

  }catch(error){
    console.error(error);
    throw new functions.https.HttpsError("internal", String(error));
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