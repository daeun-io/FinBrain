import * as functions from "firebase-functions";

const USER_AGENT =
  "Mozilla/5.0 (compatible; FinbrainBot/1.0; +https://github.com/finbrain)";

function decodeDuckDuckGoRedirect(href: string): string | null {
  try {
    const absolute = href.startsWith("//") ? `https:${href}` : href;
    const url = new URL(absolute);
    const uddg = url.searchParams.get("uddg");
    if (uddg) return decodeURIComponent(uddg);

    if (url.hostname !== "duckduckgo.com" && url.hostname !== "html.duckduckgo.com") {
      return absolute;
    }
  } catch {
    return null;
  }
  return null;
}

function extractFirstResultUrl(html: string): string | null {
  const linkPattern =
    /class="result__a"[^>]*href="([^"]+)"|href="([^"]+)"[^>]*class="result__a"/g;

  for (const match of html.matchAll(linkPattern)) {
    const href = match[1] ?? match[2];
    const decoded = decodeDuckDuckGoRedirect(href);
    if (decoded) return decoded;
  }

  return null;
}

export const searchProductUrl = functions.https.onCall(async (request: functions.https.CallableRequest<ProductUrlInput>) => {
  // call auth later
  const { data } = request;
  const query = encodeURIComponent(`${data.cmpyNm} ${data.prdtNm}`);
  const searchUrl = `https://html.duckduckgo.com/html/?q=${query}`;

  try {
    const res = await fetch(searchUrl, {
      headers: {
        "Accept": "text/html",
        "User-Agent": USER_AGENT,
      },
    });

    if (!res.ok) return "";

    const html = await res.text();
    const result = extractFirstResultUrl(html) ?? "";
    if(result == ""){
      return { success: false, data: result };
    }else{
      return { success: true, data: result };
    }
  }catch(error){
    console.log(error);
    throw new functions.https.HttpsError("internal", String(error));
  }
});
// export async function searchProductUrl(
  // companyName: string,
  // productName: string,
// ): Promise<string> {
  // const query = encodeURIComponent(`${companyName} ${productName}`);
  // const searchUrl = `https://html.duckduckgo.com/html/?q=${query}`;
// 
  // const res = await fetch(searchUrl, {
    // headers: {
      // "Accept": "text/html",
      // "User-Agent": USER_AGENT,
    // },
  // });
// 
  // if (!res.ok) {
    // return "";
  // }
// 
  // const html = await res.text();
  // return extractFirstResultUrl(html) ?? "";
// }

export interface ProductUrlInput {
  cmpyNm: string;
  prdtNm: string;
}