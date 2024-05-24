// xxx.ets
import web_webview from '@ohos.web.webview'

web_webview.once("webInited", () => {
  console.debug("configCookieSync测试")
})

@Entry
@Component
struct WebComponent {
  @State loadingState: boolean = false
  controller: web_webview.WebviewController = new web_webview.WebviewController();

  aboutToAppear(): void {
    console.debug("测试 webView")
    this.loadingState = true
  }
  build() {
    Column() {
      Navigation(){
        Web({ src: 'https://m.baidu.com', controller: this.controller })
          .width("100%")
        // if(this.loadingState) {
        //   LoadingProgress()
        //     .position( {
        //       x: 100,
        //       y: 100
        //     })
        //     .color(Color.Blue)
        //     .layoutWeight(1)
        //     .align(Alignment.Center)
        // }
      }
        .size({width: "100%", height: "100%"})
        .titleMode(NavigationTitleMode.Mini)
        .title("WebView")
    }.width('100%')
    .height('100%')
  }
}