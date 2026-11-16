import type {
  IsaMp,
  GroupedIsaMp,
  IsaMpApiResponse,
  IsaMpGroupedApiResponse,
} from "./isa_types";

export function groupItemsByName(items: IsaMp[]): GroupedIsaMp[]{
  const groupedMap = new Map<string, GroupedIsaMp>();

  for(const item of items){
    const existing = groupedMap.get(item.mpNm);
    if(existing){
      const targetOption = existing?.options.find((e) => e.basDt == item.basDt);
      const termAndRate = { trm: item.trm, bnfRt: item.bnfRt };
      if(targetOption){
        targetOption.termAndRate.push(termAndRate);
      } else {
        existing.options.push({ basDt: item.basDt, termAndRate: [termAndRate]});
      }
      continue;
    }

    groupedMap.set(item.mpNm, {
      bzds: item.bzds,
      cmpyNm: item.cmpyNm,
      mpTp: item.mpTp,
      mpNm: item.mpNm,
      rlsDt: item.rlsDt,
      options: [
        { basDt: item.basDt,
          termAndRate: [
            {
              trm: item.trm,
              bnfRt: item.bnfRt,
            },
          ],
        },
      ],
    });
  }
  const result = Array.from(groupedMap.values());
  result.forEach((group) => group.options.reverse());

  return result;
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