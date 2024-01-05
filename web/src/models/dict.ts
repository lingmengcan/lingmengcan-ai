// 用户model
export interface Dict {
  dictId: string;
  dictName: string;
  dictCode: string;
  dictType: string;
  sort: number;
  status: number;
  description?: string;
  createdUser?: string;
  updatedUser?: string;
  createdAt?: string;
  updatedAt?: string;
}

// 列表对象
export interface DictList {
  list: Dict[];
  page: number;
  pageSize: number;
  count: number;
}

/**
 * 查询对象
 */
export interface DictParams {
  dictName: string;
  dictCode: string;
  dictType: string;
  status: string | null;
  page: number;
  pageSize: number;
}
