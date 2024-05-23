// Second.ets
import router from '@ohos.router';

@Entry
@Component
struct Second {
  @State message: string = 'Hi there';

  build() {
    Navigation() {
      Row() {
        Column() {
          Text(this.message)
            .fontSize(50)
            .fontWeight(FontWeight.Bold)
          Button() {
            Text('Back')
              .fontSize(25)
              .fontWeight(FontWeight.Bold)
          }
          .type(ButtonType.Capsule)
          .margin({
            top: 20
          })
          .backgroundColor('#0D9FFB')
          .width('40%')
          .height('5%')
          .onClick(() => {
            console.log("Succeeded in Clicking the Back button");
            try {
              router.back();
            }
            catch(err) {

            }
          })
        }
        .width('100%')
      }
      .height('100%')
    }.size({width: "100%", height: "100%"})
    .titleMode(NavigationTitleMode.Mini)
    .title("二级页面")
  }
}
