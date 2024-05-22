import router from "@ohos.router";
import { BusinessError } from "@ohos.base";
import { TextView } from "../components/form/TextView"
import { ToggleView } from "../components/form/ToggleView"
import { CustomDialogExample } from "./CustomDialogExample"
import { SwiperExample } from "./SwiperList"
import { Course } from "./Course"
import preferenceUtils from "../utils/LocalStorage"
import preferences from "@ohos.data.preferences"
import { Mine } from "./Mine"
import { ModuleList } from "./ModuleList"
@Entry
@Component
struct Index {
  token: preferences.ValueType| undefined = undefined
  dialogController: CustomDialogController = new CustomDialogController({
    builder: CustomDialogExample(),
  })

  async onPageShow(): Promise<void> {
    this.token = await preferenceUtils.getValue("UserToken","token", "")
    if(!this.token) {
      router.pushUrl({
        url: "pages/login/Index"
      })
    }
  }

  async aboutToAppear(): Promise<void> {
    this.token = await preferenceUtils.getValue("UserToken","token", "")

    if(!this.token) {
      router.pushUrl({
        url: "pages/login/Index"
      })
    }
  }

  @State currentIndex: number = 0
  @Builder tabBuilder(title: string, targetIndex: number, selectedImg: Resource, normalImg: Resource) {
    Column() {
      Image(this.currentIndex === targetIndex ? selectedImg : normalImg)
        .size({ width: 25, height: 25 })
        .fillColor(this.currentIndex === targetIndex ? '#2894FF' : '#6B6B6B')
      Text(title)
        .fontColor(this.currentIndex === targetIndex ? '#2894FF' : '#6B6B6B')
    }
    .width('100%')
    .height(50)
    .justifyContent(FlexAlign.Center)
  }

  @State message: string = 'New a Hello World';
  @State text: string = "";

  build() {
    Tabs({ barPosition: BarPosition.End }) {
      TabContent() {
        Row() {
          Column() {
            SwiperExample()
            ModuleList()

            TextView({
              label: "标题",
              value:"你好啊",
              placeholder: "请输入标题"
            });
            ToggleView({
              label: "是否参加",
              value: true,
            });
            TextInput({
              text: this.text,
              placeholder: "请输入标题"
            })
            Text(this.message)
              .fontSize(50)
              .fontWeight(FontWeight.Bold)

            Button() {
              Text("跳转11页面")
                .fontSize(30)
                .fontWeight(FontWeight.Bold)
            }.type(ButtonType.Capsule)
            .margin({
              top: 20
            })
            .backgroundColor("#0D9FFB")
            .width("40%")
            .onClick(() => {
              console.info(`Succeeded in clicking the 'Next' button.`)
              // 跳转到第二页
              router.pushUrl({ url: 'pages/Second' }).then(() => {
                console.info('Succeeded in jumping to the second page.')
              }).catch((err: BusinessError) => {
                console.error(`Failed to jump to the second page.Code is ${err.code}, message is ${err.message}`)
              })
            })

            Column() {
              Button('click me')
                .onClick(() => {
                  this.dialogController.open()
                  this.dialogController.open()
                })
            }.width('100%').margin({ top: 5 })
          }
          .width('100%')
        }
        .alignItems(VerticalAlign.Top )
        .margin({
          top: 10
        })
        .height('100%')
      }
      .tabBar(this.tabBuilder('首页', 0, $r('app.media.home'), $r('app.media.home')))

      TabContent() {
        Course()
      }
      .backgroundColor("#f7f8fa")
      .tabBar(this.tabBuilder('课程', 1, $r('app.media.course'), $r('app.media.course')))

      TabContent() {
        Mine()
      }
      .backgroundColor(Color.Grey)
      .tabBar(this.tabBuilder('我的', 2, $r('app.media.me'), $r('app.media.me')))
    }
    .animationDuration(0)
    .backgroundColor('#F1F3F5')
    .onChange((index: number) => {
      this.currentIndex = index
    })
  }
}