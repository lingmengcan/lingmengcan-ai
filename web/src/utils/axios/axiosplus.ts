import axios, { AxiosInstance, AxiosRequestConfig } from 'axios';
import { ContentType, Method, RequestParams } from './types';
import qs from 'qs';
import { Convert } from './json2model';

export interface AxiosPlusConfig extends AxiosRequestConfig {
  defaultParams?: RequestParams;
  //忽略重复请求
  ignoreCancelToken?: boolean;
  // 是否携带token
  withToken?: boolean;
}

export default class AxiosPlus {
  private axiosPlusConfig: AxiosPlusConfig;
  private axiosInstance: AxiosInstance;

  constructor(options: AxiosPlusConfig = {}) {
    this.axiosInstance = axios.create(options);
    this.axiosPlusConfig = options;
  }

  getAxios(): AxiosInstance {
    return this.axiosInstance;
  }

  /**
   * @description: 重新配置axios
   */
  configAxios(config: AxiosPlusConfig) {
    if (!this.axiosInstance) {
      return;
    }
    this.createAxios(config);
  }

  /**
   * @description: 设置通用header
   */
  setHeader(headers: any): void {
    if (!this.axiosInstance) {
      return;
    }
    Object.assign(this.axiosInstance.defaults.headers, headers);
  }

  /**
   * @description: 封装请求类
   * @param {Method} method 请求方式
   * @param {APIPath} path 请求路径
   * @param {RequestParams} params 参数
   * @param {ContentType} contentType http配置
   * @param {RequestOptions} optionsSource
   * @return {*}
   */
  async request<T>(
    path: string = '',
    method: Method = Method.GET,
    params?: RequestParams,
    contentType: ContentType = ContentType.json,
    optionsSource?: AxiosPlusConfig,
  ) {
    const options: AxiosPlusConfig = Object.assign({}, this.axiosPlusConfig, optionsSource);
    const { headers } = options;
    if (headers) headers['Content-type'] = contentType;
    const allParams = Object.assign({}, this.axiosPlusConfig.defaultParams, params);

    const requestConfig: AxiosPlusConfig = {
      url: `${path}`,
      method,
      headers,
    };

    if (method === Method.GET) {
      requestConfig.params = allParams;
    } else {
      if (contentType === ContentType.form) {
        requestConfig.data = qs.stringify(allParams);
      } else {
        requestConfig.data = JSON.stringify(allParams);
      }
    }
    return this.axiosInstance
      .request(requestConfig)
      .then((res) => {
        const data: string = JSON.stringify(res.data);
        if (res.status >= 200 && res.status < 300) {
          return Convert.jsonToModel(data) as T;
        } else {
          return Promise.reject(data);
        }
      })
      .catch(async (error) => {
        return Promise.reject(error);
      });
  }

  /**
   * @description:  创建axios实例
   */
  private createAxios(config: AxiosPlusConfig): void {
    this.axiosInstance = axios.create(config);
  }
}
