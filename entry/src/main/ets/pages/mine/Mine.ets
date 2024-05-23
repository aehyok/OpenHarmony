@Entry
@Component
export struct Mine {
  @State isActiveWLAN: boolean = false
  @State isActiveBluetooth: boolean = false

  build() {
    Row(){
      Navigation() {
        NavRouter() {
          Row() {
            Row()
              .width(30)
              .height(30)
              .borderRadius(30)
              .margin({ left: 3, right: 10 })
              .backgroundColor(Color.Pink)
            Text(`个人信息`)
              .fontSize(22)
              .fontWeight(500)
              .textAlign(TextAlign.Center)
          }
          .width('90%')
          .height(60)

          NavDestination() {
            Flex({ direction: FlexDirection.Row }) {
              Text('用户名').fontSize(30).padding({ left: 15 })
              Text('手机号').fontSize(30).padding({ left: 15 })
            }
          }.title("我的个人信息")
        }
        .margin({ top: 10, bottom: 10 })
        .backgroundColor(this.isActiveBluetooth ? '#ccc' : '#fff')
        .borderRadius(20)
        .mode(NavRouteMode.REPLACE)
        .onStateChange((isActivated: boolean) => {
          this.isActiveBluetooth = isActivated
        })

        NavRouter() {
          Row() {
            Row()
              .width(30)
              .height(30)
              .borderRadius(30)
              .margin({ left: 3, right: 10 })
              .backgroundColor(Color.Pink)
            Text(`我的课程`)
              .fontSize(22)
              .fontWeight(500)
              .textAlign(TextAlign.Center)
          }
          .width('90%')
          .height(60)

          NavDestination() {
            Flex({ direction: FlexDirection.Row }) {
              Text('用户名').fontSize(30).padding({ left: 15 })
              Text('手机号').fontSize(30).padding({ left: 15 })
            }
          }.title("我的课程")
        }
        .margin({ top: 10, bottom: 10 })
        .backgroundColor(this.isActiveBluetooth ? '#ccc' : '#fff')
        .borderRadius(20)
        .mode(NavRouteMode.REPLACE)
        .onStateChange((isActivated: boolean) => {
          this.isActiveBluetooth = isActivated
        })

        NavRouter() {
          Row() {
            Row()
              .width(30)
              .height(30)
              .borderRadius(30)
              .margin({ left: 3, right: 10 })
              .backgroundColor(Color.Pink)
            Text(`我的订单`)
              .fontSize(22)
              .fontWeight(500)
              .textAlign(TextAlign.Center)
          }
          .width('90%')
          .height(60)

          NavDestination() {
            Flex({ direction: FlexDirection.Row }) {
              Text('用户名').fontSize(30).padding({ left: 15 })
              Text('手机号').fontSize(30).padding({ left: 15 })
            }
          }.title("我的订单")
        }
        .margin({ top: 10, bottom: 10 })
        .backgroundColor(this.isActiveBluetooth ? '#ccc' : '#fff')
        .borderRadius(20)
        .mode(NavRouteMode.REPLACE)
        .onStateChange((isActivated: boolean) => {
          this.isActiveBluetooth = isActivated
        })


        NavRouter() {
          Row() {
            Row()
              .width(30)
              .height(30)
              .borderRadius(30)
              .margin({ left: 3, right: 10 })
              .backgroundColor(Color.Pink)
            Text(`消息设置`)
              .fontSize(22)
              .fontWeight(500)
              .textAlign(TextAlign.Center)
          }
          .width('90%')
          .height(60)

          NavDestination() {
            Flex({ direction: FlexDirection.Row }) {
              Text('退出登录').fontSize(30).padding({ left: 15 })
              Text('清理缓存').fontSize(30).padding({ left: 15 })
            }
          }.title("消息设置")
        }
        .margin({ top: 10, bottom: 10 })
        .backgroundColor(this.isActiveWLAN ? '#ccc' : '#fff')
        .borderRadius(20)
        .mode(NavRouteMode.PUSH_WITH_RECREATE)
        .onStateChange((isActivated: boolean) => {
          this.isActiveWLAN = isActivated
        })

        NavRouter() {
          Row() {
            Row()
              .width(30)
              .height(30)
              .borderRadius(30)
              .margin({ left: 3, right: 10 })
              .backgroundColor(Color.Pink)
            Text(`检查更新`)
              .fontSize(22)
              .fontWeight(500)
              .textAlign(TextAlign.Center)
          }
          .width('90%')
          .height(60)

          NavDestination() {
            Flex({ direction: FlexDirection.Row }) {
              Text('退出登录').fontSize(30).padding({ left: 15 })
              Text('清理缓存').fontSize(30).padding({ left: 15 })
            }
          }.title("检查更新")
        }
        .margin({ top: 10, bottom: 10 })
        .backgroundColor(this.isActiveWLAN ? '#ccc' : '#fff')
        .borderRadius(20)
        .mode(NavRouteMode.PUSH_WITH_RECREATE)
        .onStateChange((isActivated: boolean) => {
          this.isActiveWLAN = isActivated
        })

        NavRouter() {
          Row() {
            Row()
              .width(30)
              .height(30)
              .borderRadius(30)
              .margin({ left: 3, right: 10 })
              .backgroundColor(Color.Pink)
            Text(`关于`)
              .fontSize(22)
              .fontWeight(500)
              .textAlign(TextAlign.Center)
          }
          .width('90%')
          .height(60)

          NavDestination() {
            Flex({ direction: FlexDirection.Row }) {
              Text('退出登录').fontSize(30).padding({ left: 15 })
              Text('清理缓存').fontSize(30).padding({ left: 15 })
            }
          }.title("关于")
        }
        .margin({ top: 10, bottom: 10 })
        .backgroundColor(this.isActiveWLAN ? '#ccc' : '#fff')
        .borderRadius(20)
        .mode(NavRouteMode.PUSH_WITH_RECREATE)
        .onStateChange((isActivated: boolean) => {
          this.isActiveWLAN = isActivated
        })

        Button("退出登录").width("90%")
          .height(60)
          .fontSize(22)
          .fontWeight(500)
          .fontColor(Color.Black)
          .backgroundColor(Color.White)
      }
      .height('100%')
      .width('100%')
      .title('我的')
      .backgroundColor("#F2F3F5")
      .titleMode(NavigationTitleMode.Free)
      .mode(NavigationMode.Auto)
    }
  }
}