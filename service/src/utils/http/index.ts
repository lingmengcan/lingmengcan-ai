import AxiosPlus, { AxiosPlusConfig } from './axiosplus';

export const httpHandler = () => {
  const httpConfig: AxiosPlusConfig = {
    baseURL: '',
    headers: {
      Authorization: '',
    },
  };

  const axiosPlus = new AxiosPlus(httpConfig);

  // request拦截器
  axiosPlus.getAxios().interceptors.request.use(
    (config) => {
      return config;
    },
    (error) => Promise.reject(error),
  );

  // 响应拦截器
  axiosPlus.getAxios().interceptors.response.use(
    (response) => {
      return response;
    },
    (error) => {
      return Promise.reject(error);
    },
  );

  return axiosPlus;
};

export default httpHandler();
