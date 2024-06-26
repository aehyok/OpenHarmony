// xxx.ets
import ComponentUtils from '@ohos.arkui.UIContext';

@Component
export struct NewsTabList {
  @State currentIndex: number = 0
  @State animationDuration: number = 300
  @State indicatorLeftMargin: number = 0
  @State indicatorWidth: number = 0
  private tabsWidth: number = 0
  private componentUtils: ComponentUtils.ComponentUtils = this.getUIContext().getComponentUtils()

  @Builder
  tabBuilder(index: number, name: string) {
    Column() {
      Text(name)
        .fontSize(16)
        .fontColor(this.currentIndex === index ? '#007DFF' : '#182431')
        .fontWeight(this.currentIndex === index ? 500 : 400)
        .id(index.toString())
        .onAreaChange((oldValue: Area,newValue: Area) => {
          if (this.currentIndex === index && (this.indicatorLeftMargin === 0 || this.indicatorWidth === 0)){
            if (newValue.position.x != undefined) {
              let positionX = Number.parseFloat(newValue.position.x.toString())
              this.indicatorLeftMargin = Number.isNaN(positionX) ? 0 : positionX
            }
            let width = Number.parseFloat(newValue.width.toString())
            this.indicatorWidth = Number.isNaN(width) ? 0 : width
          }
        })
    }.width('100%')
  }

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      Tabs({ barPosition: BarPosition.Start }) {
        TabContent() {
          Column() {
            Text("最新动态")
          }.width('100%').height('100%')
        }.tabBar(this.tabBuilder(0, '最新动态'))

        TabContent() {
          Column(){
            Text("党建宣传")
          }.width('100%').height('100%')
        }.tabBar(this.tabBuilder(1, '党建宣传'))

        TabContent() {
          Column(){
            Text("便民信息")
          }.width('100%').height('100%')
        }.tabBar(this.tabBuilder(2, '便民信息'))

        TabContent() {
          Column(){
            Text("三务公开")
          }.width('100%').height('100%')
        }.tabBar(this.tabBuilder(3, '三务公开'))
      }
      .onAreaChange((oldValue: Area,newValue: Area)=> {
        let width = Number.parseFloat(newValue.width.toString())
        this.tabsWidth = Number.isNaN(width) ? 0 : width
      })
      .barWidth('100%')
      .barHeight(56)
      .width('100%')
      .height(296)
      .backgroundColor('#F1F3F5')
      .animationDuration(this.animationDuration)
      .onChange((index: number) => {
        this.currentIndex = index  // 监听索引index的变化，实现页签内容的切换。
      })
      .onAnimationStart((index: number, targetIndex: number, event: TabsAnimationEvent) => {
        // 切换动画开始时触发该回调。下划线跟着页面一起滑动，同时宽度渐变。
        this.currentIndex = targetIndex
        let targetIndexInfo = this.getTextInfo(targetIndex)
        this.startAnimateTo(this.animationDuration, targetIndexInfo.left, targetIndexInfo.width)
      })
      .onAnimationEnd((index: number,event: TabsAnimationEvent) => {
        // 切换动画结束时触发该回调。下划线动画停止。
        let currentIndicatorInfo = this.getCurrentIndicatorInfo(index,event)
        this.startAnimateTo(0,currentIndicatorInfo.left,currentIndicatorInfo.width)
      })
      .onGestureSwipe((index: number,event: TabsAnimationEvent) => {
        // 在页面跟手滑动过程中，逐帧触发该回调。
        let currentIndicatorInfo = this.getCurrentIndicatorInfo(index,event)
        this.currentIndex = currentIndicatorInfo.index
        this.indicatorLeftMargin = currentIndicatorInfo.left
        this.indicatorWidth = currentIndicatorInfo.width
      })

      Column()
        .height(2)
        .width(this.indicatorWidth)
        .margin({ left: this.indicatorLeftMargin, top:48})
        .backgroundColor('#007DFF')
    }.width('100%')
    .margin({
      left: 25,
      right: 25
    })
  }

  private getTextInfo(index: number): Record<string, number> {
    let rectangle = this.componentUtils.getRectangleById(index.toString())
    return { 'left': px2vp(rectangle.windowOffset.x), 'width': px2vp(rectangle.size.width) }
  }

  private getCurrentIndicatorInfo(index: number, event: TabsAnimationEvent): Record<string, number> {
    let nextIndex = index
    if (index > 0 && event.currentOffset > 0) {
      nextIndex--
    } else if (index < 3 && event.currentOffset < 0) {
      nextIndex++
    }
    let indexInfo = this.getTextInfo(index)
    let nextIndexInfo = this.getTextInfo(nextIndex)
    let swipeRatio = Math.abs(event.currentOffset / this.tabsWidth)
    let currentIndex = swipeRatio > 0.5 ? nextIndex : index  // 页面滑动超过一半，tabBar切换到下一页。
    let currentLeft = indexInfo.left + (nextIndexInfo.left - indexInfo.left) * swipeRatio
    let currentWidth = indexInfo.width + (nextIndexInfo.width - indexInfo.width) * swipeRatio
    return { 'index': currentIndex, 'left': currentLeft, 'width': currentWidth }
  }

  private startAnimateTo(duration: number, leftMargin: number, width: number) {
    animateTo({
      duration: duration, // 动画时长
      curve: Curve.Linear, // 动画曲线
      iterations: 1, // 播放次数
      playMode: PlayMode.Normal, // 动画模式
      onFinish: () => {
        console.info('play end')
      }
    }, () => {
      this.indicatorLeftMargin = leftMargin
      this.indicatorWidth = width
    })
  }
}
