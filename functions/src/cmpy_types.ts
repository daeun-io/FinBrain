export interface Company {
  baseInfo: {
    dcls_month: string,
    fin_co_no: string,
    kor_co_nm: string,
    dcls_chrg_man: string,
    homp_url: string,
    cal_tel: string,
  },
  options: Option[],
}

export interface Option {
  area_cd: string,
  area_nm: string,
  exis_yn: string,
}

export interface CmpyNameApiResponse {
  result: {
    err_cd: string,
    err_msg: string,
    total_count: string,
    max_page_no?: string,
    now_page_no?: string,
    products: string[],
  }
}