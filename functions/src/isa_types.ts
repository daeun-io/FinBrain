export interface IsaMp {
  basDt: string;
  bzds: string;
  cmpyNm: string;
  mpTp: string;
  mpNm: string;
  rlsDt: string;
  trm: string;
  bnfRt: string;
}

export interface Option {
  trm: string;
  bnfRt: string;
}

export interface GroupedIsaMp {
  basDt: string;
  bzds: string;
  cmpyNm: string;
  mpTp: string;
  mpNm: string;
  rlsDt: string;
  options: Option[];
}

export interface IsaMpApiResponse {
  response: {
    header: {
      resultCode: string;
      resultMsg: string;
    };
    body: {
      numOfRows: number;
      pageNo: number;
      totalCount: number;
      items: {
        item: IsaMp[];
      };
    };
  };
}

export interface IsaMpGroupedApiResponse {
  response: {
    header: IsaMpApiResponse["response"]["header"];
    body: {
      numOfRows: number;
      pageNo: number;
      totalCount: number;
      items: {
        item: GroupedIsaMp[];
      };
    };
  };
}
