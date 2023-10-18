import HttpClient, { HttpClientConfig } from 'axios-mapper';

export const httpConfig = (hasToken = true) => {
  const config: HttpClientConfig = {
    baseURL: import.meta.env.VITE_APP_BASE_API?.toString(),
    headers: {
      Authorization: hasToken ? `Bearer ` : '',
    },
  };
  return config;
};

const request = new HttpClient(httpConfig());

// request拦截器
request.httpClient.interceptors.request.use(
  (config) => config,
  (error) =>
    // console.log(error);
    Promise.reject(error),
);

// 响应拦截器
request.httpClient.interceptors.response.use(
  (response) =>
    // 未设置状态码则默认成功状态
    response,
  (error) => {
    const { response } = error;

    if (response) {
      switch (response.status) {
        case 400:
          break;
        case 401:
          break;
        case 403:
          break;
        case 404:
          break;
        case 408:
          break;
        case 500:
          break;
        case 501:
          break;
        case 502:
          break;
        case 503:
          break;
        case 504:
          break;
        case 505:
          break;
        default:
          break;
      }
    }
    return Promise.reject(error);
  },
);

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
export interface Result<T> {
  code: number;
  message: string;
  data: T;
}

export default request;
