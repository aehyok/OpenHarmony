import { getCaptcha, login } from "../../api/index"
import buffer from '@ohos.buffer';
import router from '@ohos.router';
import { BusinessError } from '@ohos.base';
import { UIContext } from '@ohos.arkui.UIContext';
import { preferences } from '@kit.ArkData';
import preferenceUtils from "../../utils/LocalStorage"

@Entry
@Component
struct Login {
  @State userName: string = "18620394208";
  @State password: string = "394208";
  @State captcha: string = "data:image/jpeg;base64,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";
  @State captchaValue: string = "";
  @State captchaError: string = "";
  @State captchaKey: string = "";
  @State platformType: number = 0;
  token: preferences.ValueType| undefined = undefined

  onPageShow(): void {
    console.log("onPageShow");
  }

  async aboutToAppear(): Promise<void> {
    getContext(this).eventHub.on('1', (data: string) => {
      let context: UIContext = this.getUIContext() as UIContext
      console.log(JSON.stringify(context), "测试context")
      let prompt = context.getPromptAction()
      console.log(data, "测试data")
      prompt.showToast({
        message: data,
        bottom: 600  })
    });
    await this.getCaptchaApi()
  }

  async getCaptchaApi () {
    const result = await getCaptcha()
    if(result.code === 200) {
      console.log(JSON.stringify(result.data))
      this.captchaKey = result.data.key
      this.captcha = result.data.captcha
    }
  }

  build() {

    Column() {
      Row() {
        Image($r("app.media.output_image041"))
          .width(100)
          .height(100)
          .border({
            radius:50
          })
      }
      .padding({
        top: 50,
        bottom:20
      })
      .width('100%')
      .justifyContent(FlexAlign.Start)
      Row(){
        Text("宣恩县数字乡村平台")
          .fontSize(24)
          .fontWeight(400)
      }
      .width('100%')
      .justifyContent(FlexAlign.Start)
        .padding({
          bottom: 15
        })
      Row(){
        TextInput({
          placeholder: "请输入手机号码",
          text: this.userName
        })
          .onChange((value: string) => {
            this.userName = value
          })
          .height(45)
          .border({
            radius: 8
          })
      }
      .margin({
        bottom: 10
      })
      Row(){
        TextInput({
          placeholder: "请输入密码",
          text: this.password
        })
          .onChange((value: string) => {
            this.password = value
          })
          .type(InputType.Password)
          .height(45)
          .border({
            radius: 8
          })
      }
      .margin({
        bottom: 10
      })
      Row(){
        Flex({
          alignItems: ItemAlign.Center,
          justifyContent: FlexAlign.Center
        }){
          TextInput({
            placeholder: "请输入验证码",
          })
            .showError(this.captchaError)
            .onChange((value: string) => {
              this.captchaValue = value
              console.log(this.captchaValue, "this.captchaValue测试")
            })
            .onSubmit(() => {
              if(this.captchaValue.length != 4) {
                this.captchaError = "验证码格式不正确"
                return
              }
              console.log(this.captchaError, "this.captchaError测试")
              this.captchaError = "验证码错误"
            })
            .height(45)
            .border({
              radius: 8
            })

          Image(this.captcha)
            .width(150)
            .height(30)
            .margin({
              left: 2,
              right: 2
            })
          Text("换一张")
            .width(100)
            .fontSize(14)
            .textAlign(TextAlign.End)
            .fontColor(Color.Blue)
            .onClick(() => {

            })
        }
      }
      Row(){
        Button("登录")
          .width("96%")
          .onClick( async() => {
            let base64Password = buffer.from(this.password, "utf-8").toString("base64")
            console.log(base64Password, "测试密码")
            getContext(this).eventHub.emit('1','测试111');

            const result = await login({
              userName: this.userName,
              password: base64Password,
              captcha: this.captchaValue,
              captchaKey: this.captchaKey,
              platformType: 0
            })
            console.debug("login-page测试",JSON.stringify(result))
            if(result.code == 200) {
              await preferenceUtils.setValue("UserToken","token", JSON.stringify(result.data))
              getContext(this).eventHub.emit('1', '登录成功');
              router.pushUrl({ url: 'pages/Index' }).then(() => {
                console.info('Succeeded in jumping to the second page.测试')
              }).catch((err: BusinessError) => {
                console.debug(`Failed to jump to the second page.Code is ${err.code}, message is ${err.message}`)
              })
            } else {
              console.debug("alertSHow")
            }
          })
      }
      .padding({
        top: 14
      })
    }
    .margin(20)
  }
}