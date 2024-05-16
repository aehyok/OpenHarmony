import axios, {
  AxiosError,
  AxiosInstance, AxiosRequestConfig, AxiosResponse, InternalAxiosRequestConfig } from '@ohos/axios'
import dataPreferences from '@ohos.data.preferences';
import preferences from '@ohos.data.preferences';
import { ResponseData } from '../models';
import { DEFAULT } from '@ohos/hypium';

const Url: string = ""

enum RequestEnums {
  TIMEOUT = 20000,
  OVERDUE = 600,
  FAIL =999,
  SUCCESS = 200
}

interface Config {
  baseURL: string,
  timeout: number,
  withCredentials: Boolean
}

const config: Config = {
  baseURL: Url as string,
  timeout: RequestEnums.TIMEOUT as number,
  withCredentials: true
}



export class Instance {
  instance: AxiosInstance

  constructor(config: AxiosRequestConfig) {
    this.instance = axios.create(config)

    this.instance.interceptors.request.use(
      (config:InternalAxiosRequestConfig) => {
        // let token  =  preferences.getPreferencesSync()
        // const token = localStorage.token ? JSON.parse(localStorage.token) : {};
        config.headers["Authorization"] = ""
        config.headers["Content-Type"] = "application/json"
        return config;
    }, (error: AxiosError) => {
      return Promise.reject(error);
    })

    this.instance.interceptors.response.use(
      (response: AxiosResponse) => {

        return response.data
      }, (error: AxiosError) => {
      return Promise.reject(error);
    })
  }

  // GET
  get<T>(url: string, data?: object): Promise<ResponseData<T>> {
    return this.instance.get(url, { params: data });
  }

  // POST
  post<T>(url: string, data?: object): Promise<ResponseData<T>> {
    console.log('instance', url)
    return this.instance.post(url, data);
  }

  // PUT
  put<T>(url: string, data?: object): Promise<ResponseData<T>> {
    return this.instance.put(url, data);
  }

  //DELETE
  delete<T>(url: string, data?: object): Promise<ResponseData<T>> {
    return this.instance.delete(url, {data});
  }
}

export default new Instance({
  baseURL: "http://101.200.243.192:8080",
  timeout: 60000
})