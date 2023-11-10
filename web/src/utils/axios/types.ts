export enum ContentType {
  form = 'application/x-www-form-urlencoded',
  json = 'application/json; charset=utf-8',
  multipart = 'multipart/form-data',
}

export enum Method {
  GET = 'GET',
  POST = 'POST',
  PUT = 'PUT',
  PATCH = 'PATCH',
  DELETE = 'DELETE',
}

/**
 * 网络请求参数
 */
export interface RequestParams {
  [key: string]: any;
}
