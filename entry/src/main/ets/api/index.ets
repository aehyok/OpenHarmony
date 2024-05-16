import axios, { AxiosResponse } from "@ohos/axios"
import { ResponseData } from "../models/index"
import Request from "../utils/Instance"
// 验证码
interface CaptchaData {
  captcha: string;
  key: string;
  expireTime: string;
}

// 获取图片验证码
export const getCaptcha = async() => {
  return await Request.get<CaptchaData>("/api/basic/Token/captcha")
}

interface LoginParams {
  userName: string,
  password: string,
  captcha: string,
  captchaKey: string,
  platformType: number;
}

interface  LoginModel {
  userId: string,
  token: string,
  refreshToken: string,
  expirationDate: Date,
}

export const login = async(data: LoginParams) => {
  console.log(JSON.stringify(data), "login-api")
  return await Request.post<LoginModel>('/api/basic/Token/password', data)
}