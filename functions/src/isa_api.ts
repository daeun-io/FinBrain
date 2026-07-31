import { onRequest } from "firebase-functions/https";
import { transformApiResponse } from "./isa_transform";

export const fetchAndGroupProducts = onRequest(async (request, response) => {
  response.set("Access-Control-Allow-Origin", "*");

  try {
    const baseUrl = "https://apis.data.go.kr/1160100/GetISAInfoService_V2/getMPBenefitRateInfo_V2?";
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
      const errorBody = res.text();
      console.log(`error: ${errorBody}`);
      response.status(res.status).send(errorBody);
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