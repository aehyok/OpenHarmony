import { sceneManager } from '@kit.StoreKit'
import router from '@ohos.router'

interface  ModuleData {
  iconUrl: string
  name: string
  key?: string
}

const moduleDataList: Array<ModuleData> = []
moduleDataList.push({ iconUrl: "app.media.zpqz", name: "webView", key: "webView"})
moduleDataList.push({ iconUrl: "app.media.ckbt", name: "随手拍2"})
moduleDataList.push({ iconUrl: "app.media.fwzx", name: "随手拍3"})
moduleDataList.push({ iconUrl: "app.media.lxcw", name: "随手拍4"})
moduleDataList.push({ iconUrl: "app.media.msjl", name: "随手拍5"})
moduleDataList.push({ iconUrl: "app.media.nhcs", name: "随手拍6"})
moduleDataList.push({ iconUrl: "app.media.ssp", name: "随手拍7"})
moduleDataList.push({ iconUrl: "app.media.xyss", name: "随手拍8"})

@Entry
@Component
export struct ModuleList {
  @State numbers: String[] = ['0', '1', '2', "3"]

  build() {
    Grid() {
      ForEach(moduleDataList, (item: ModuleData) => {
          GridItem({
            style:GridItemStyle.PLAIN,
          }) {
            Flex({
              alignItems: ItemAlign.Center,
              justifyContent: FlexAlign.Start,
              direction: FlexDirection.Column
            }) {
              Image($r(item.iconUrl))
                .width("100%")
                .height("100%")
                .objectFit(ImageFit.Contain)
              Text(item.name)
                .fontSize(13)
            }
          }
          .onClick(() => {
            if(item.key === 'webView') {
              router.pushUrl({
                url: "pages/webView/Index"
              })
            } else {
              router.pushUrl({
                url: "pages/Second"
              })
            }
          })
          // .backgroundColor(Color.Red)
          .height(80)
      })
    }
    .columnsTemplate('1fr 1fr 1fr 1fr')
    .rowsTemplate('1fr 1fr')
    .columnsGap(14)
    .rowsGap(1)
    .height(185)
    .width("100% - 10")
    .margin({
      left: 25,
      right: 25,
      top:10
    })
  }
}