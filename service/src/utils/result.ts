/**
 * Note: 接口结果标准类
 *
 * {
    "code": 0,
    "message": "success",
    "data": {
        "accessToken": "admin-token"
    }
}
 */
export class Result<T> {
  code: number;
  message: string;
  data?: T;
}

/**
 * 返回成功json
 * @param data
 * @returns
 */
export function successJson<T>(data: T): Result<T> {
  const result: Result<T> = {
    code: 0,
    message: 'success',
    data: data,
  };

  return result;
}

/**
 * 返回成功json
 * @param data
 * @returns
 */
export function errorJson<T>(code: number, message: string): Result<T> {
  const result: Result<T> = {
    code: code,
    message: message,
  };

  return result;
}
