import { onRequest } from "firebase-functions/https";

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

export const searchProductUrl = onRequest( async (request, response) => {
  response.set("Access-Control-Allow-Origin", "*");
  
  try {
    const { cmpyNm, prdtNm } = request.query;

    if(!cmpyNm || !prdtNm){
      response.status(400).send("Give proper arguments");
      return;
    }

    const query = encodeURIComponent(`${cmpyNm} ${prdtNm}`);
    const searchUrl = `https://html.duckduckgo.com/html/?q=${query}`;

    const res = await fetch(searchUrl, {
      headers: {
        "Accept": "text/html",
        "User-Agent": USER_AGENT,
      },
    });

    if (!res.ok){
      response.status(res.status).send("Failed to load API");
      return;
    }
    
    const html = await res.text();
    const result = extractFirstResultUrl(html) ?? "";

    if(result == ""){
      response.status(200).send("No result found");
    }else{
      response.status(200).send(result);
    }
  
  }catch (error){
    console.log(error);
    response.status(500).send(error);
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