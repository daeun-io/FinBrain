import type {
  IsaMp,
  GroupedIsaMp,
  IsaMpApiResponse,
  IsaMpGroupedApiResponse,
} from "./isa_types";

export function groupItemsByName(items: IsaMp[]): GroupedIsaMp[]{
  const groupedMap = new Map<string, GroupedIsaMp>();
  for(const item of items){
    const exisitng = groupedMap.get(item.mpNm);
    if(exisitng){
      exisitng.options.push({trm: item.trm, bnfRt: item.bnfRt});
      continue;
    }
    groupedMap.set(item.mpNm, {
      basDt: item.basDt,
      bzds: item.bzds,
      cmpyNm: item.cmpyNm,
      mpTp: item.mpTp,
      mpNm: item.mpNm,
      rlsDt: item.rlsDt,
      options: [{ trm: item.trm, bnfRt: item.bnfRt}],
    });
  }
  return Array.from(groupedMap.values());
}

export function transformApiResponse(data: IsaMpApiResponse): IsaMpGroupedApiResponse {
  const {header, body} = data.response;
  const items = body.items?.item ?? [];

  return {
    response: {
      header,
      body: {
        numOfRows: body.numOfRows,
        pageNo: body.pageNo,
        totalCount: body.totalCount,
        items: {
          item: groupItemsByName(items),
        },
      },
    },
  };
}