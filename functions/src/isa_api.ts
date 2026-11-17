import { onRequest } from "firebase-functions/v2/https";
import { transformApiResponse } from "./isa_transform";

const BASE_URL =
  "https://apis.data.go.kr/1160100/GetISAInfoService_V2/getMPBenefitRateInfo_V2";
const PAGE_SIZE = 10000;
const RESULT_TYPE = "json";

export const fetchIsaProducts = onRequest(async (request, response) => {
  response.set("Access-Control-Allow-Origin", "*");

  try {
    // 1. 쿼리 파라미터 정리
    const params: Record<string, string> = {};
    let mpTypes: string[] = [];
    let bzdses: string [] = [];

    Object.entries(request.query ?? {}).forEach(([key, value]) => {
      if (key === "pageNo" || key === "numOfRows") return;

      if (key === "mpTp") {
        mpTypes = (Array.isArray(value) ? value : [value]).map(String);
        return; // 일반 파라미터 처리에서 제외, 아래에서 별도 판단
      }
      if (key === "bzds") {
        bzdses = (Array.isArray(value) ? value : [value]).map(String);
        return;
      }

      params[key] = Array.isArray(value) ? String(value[0]) : String(value);
    });

    // 2. mpType 및 bzdses 개수에 따라 분기
    // - 1개: API 호출 인자로 전달, 2개 이상: API에는 넘기지 않고, 결합 후 필터링
    const needsFilter = mpTypes.length >= 2 || bzdses.length >= 2;
    if (mpTypes.length === 1) {
      params["mpTp"] = mpTypes[0];
    }
    if(bzdses.length === 1) {
      params["bzds"] = bzdses[0];
    }

    // 3. 첫 페이지 호출
    const firstRaw = await callApi(params, 1);
    const { totalCount, items: firstItems } = extractPage(firstRaw);
    let resultList: any[] = [...firstItems];

    // 4. 나머지 페이지 호출 후 결합
    if (totalCount > PAGE_SIZE) {
      const maxPage = Math.ceil(totalCount / PAGE_SIZE);

      for (let pageNo = 2; pageNo <= maxPage; pageNo++) {
        const pageRaw = await callApi(params, pageNo);
        const { items } = extractPage(pageRaw);
        resultList = resultList.concat(items);
      }
    }

    // 5. mpType이 2개 이상이면 결합 데이터 필터링
    if (needsFilter) {
      const allowedMpType = new Set(mpTypes);
      const allowedBzds = new Set(bzdses);
      resultList = resultList.filter((item) =>
        allowedMpType.has(String(item?.["mpTp"])) && 
        allowedBzds.has(String(item?.["bzds"]))
      );
    }

    // 6. 변환
    const mergedRaw = {
      ...firstRaw,
      response: {
        ...firstRaw.response,
        body: {
          ...firstRaw.response.body,
          items: { item: resultList },
        },
      },
    };

    const transformed = transformApiResponse(mergedRaw);
    response.status(200).send(transformed);
  } catch (error: any) {
    if (error?.status) {
      console.error(`API error ${error.status}: ${error.body}`);
      response.status(error.status).send(error.body);
      return;
    }
    console.error("Error occurred", error);
    response.status(500).send("Internal server error");
  }
});

async function callApi(
  params: Record<string, string>,
  pageNo: number
): Promise<any> {
  const urlObj = new URL(BASE_URL);

  Object.entries(params).forEach(([key, value]) => {
    urlObj.searchParams.set(key, value);
  });
  urlObj.searchParams.set("numOfRows", String(PAGE_SIZE));
  urlObj.searchParams.set("pageNo", String(pageNo));
  urlObj.searchParams.set("resultType", RESULT_TYPE);

  const url = urlObj.toString();
  console.log(`url: ${url}`);

  const res = await fetchWithRetry(url);

  if (!res.ok) {
    const errorBody = await res.text();
    const err: any = new Error(`API error: ${res.status}`);
    err.status = res.status;
    err.body = errorBody;
    throw err;
  }

  return res.json();
}

function extractPage(raw: any): { totalCount: number; items: any[] } {
  const body = raw?.response?.body;
  const totalCount = Number(body?.totalCount ?? 0);
  const item = body?.items?.item;

  let items: any[] = [];
  if (Array.isArray(item)) {
    items = item;
  } else if (item) {
    items = [item];
  }

  return { totalCount, items };
}

const RETRYABLE_CODES = new Set([
  "UND_ERR_CONNECT_TIMEOUT",
  "ECONNRESET",
  "ETIMEDOUT",
  "EAI_AGAIN",
]);

async function fetchWithRetry(url: string, retries = 3): Promise<Response> {
  for (let attempt = 0; ; attempt++) {
    try {
      return await fetch(url, { signal: AbortSignal.timeout(30000) });
    } catch (e: any) {
      const code = e?.cause?.code ?? e?.code;
      const retryable = RETRYABLE_CODES.has(code) || e?.name === "TimeoutError";
      if (!retryable || attempt >= retries) throw e;
      const delay = 1000 * 2 ** attempt; // 1s, 2s, 4s
      console.warn(`fetch retry ${attempt + 1} (${code}), wait ${delay}ms`);
      await new Promise((r) => setTimeout(r, delay));
    }
  }
}