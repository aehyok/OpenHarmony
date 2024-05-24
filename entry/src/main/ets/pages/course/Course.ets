import { PullToRefresh } from '@ohos/pulltorefresh'
import router from '@ohos.router';

const NEWS_RESOLVE_SUCCESS : string = '刷新成功';
const NEWS_REFRESH_TIME: number = 1500; // 数据刷新时间
const NEWS_MOCK_DATA_COUNT: number = 20;

class BasicDataSource implements IDataSource {
  private listeners: DataChangeListener[] = [];

  public totalCount(): number {
    return 0;
  }

  public getData(index: number): Object {
    return index;
  }

  // 为LazyForEach组件向其数据源处添加listener监听
  registerDataChangeListener(listener: DataChangeListener): void {
    if (this.listeners.indexOf(listener) < 0) {
      this.listeners.push(listener);
    }
  }

  // 为对应的LazyForEach组件在数据源处去除listener监听
  unregisterDataChangeListener(listener: DataChangeListener): void {
    const pos = this.listeners.indexOf(listener);
    if (pos >= 0) {
      this.listeners.splice(pos, 1);
    }
  }

  // 通知LazyForEach组件需要重载所有子组件
  notifyDataReload(): void {
    this.listeners.forEach(listener => {
      listener.onDataReloaded();
    })
  }

  // 通知LazyForEach组件需要在index对应索引处添加子组件
  notifyDataAdd(index: number): void {
    this.listeners.forEach(listener => {
      listener.onDataAdd(index);
    })
  }

  // 通知LazyForEach组件需要在index对应索引处添加子组件
  notifyDataChange(index: number): void {
    this.listeners.forEach(listener => {
      listener.onDataChange(index);
    })
  }

  // 通知LazyForEach组件需要在index对应索引处删除该子组件
  notifyDataDelete(index: number): void {
    this.listeners.forEach(listener => {
      listener.onDataDelete(index);
    })
  }

  notifyDataMove(from: number, to: number): void {
    this.listeners.forEach(listener => {
      listener.onDataMove(from, to);
    })
  }
}

class NewsData {
  ImageUrl: string
  Title: string
  Price: number
  NormalPrice: number
  Des: string
  Remark?: string

  constructor(imageUrl: string, title: string , price: number, normalPrice: number, des: string, remark: string) {
    this.ImageUrl = imageUrl;
    this.Title = title;
    this.Price = price;
    this.NormalPrice = normalPrice;
    this.Des = des;
    this.Remark = remark;
  }
}


// class NewsData {
//   newsId: string
//   newsTitle: string | Resource
//   newsContent: string | Resource
//   newsTime: string | Resource
//
//   toString(): string {
//     return this.newsId + ' ' + this.newsTitle + ' ' + this.newsContent + ' ' + this.newsTime;
//   }
//
//   constructor(id: string, title: string | Resource, content: string | Resource, time: string | Resource) {
//     this.newsId = id;
//     this.newsTitle = title;
//     this.newsContent = content;
//     this.newsTime = time;
//   }
// }


// 懒加载列表对象
class NewsDataSource extends BasicDataSource {
  dataArray: Array<NewsData> = [];

  public totalCount(): number {
    return this.dataArray.length;
  }

  public getData(index: number): Object {
    return this.dataArray[index];
  }

  public addData(index: number, data: NewsData): void {
    this.dataArray.splice(index, 0, data);
    this.notifyDataAdd(index);
  }

  public pushData(data: NewsData): void {
    this.dataArray.push(data);
    this.notifyDataAdd(this.dataArray.length - 1);
  }

  public clear(): void {
    this.dataArray = [];
  }
}


function getNewsData(index: number): Array<NewsData> {
  let dataList: Array<NewsData> = []
  let startInex = index * 20;
  let enIndex = (index + 1) * 20;

  for (let i = startInex; i < enIndex; i++) {
    let item: NewsData = new NewsData(`image${i}`, `手写python虚拟机${i}`, i + 1, i + 10 + 1, `${i}海纳 华为资深编译及专家，原huawei高级资深副总裁级别人物`, "");
    dataList.push(item)
  }
  return dataList;
}


@Entry
@Component
export struct Course {
  @State newsData: NewsDataSource = new NewsDataSource();

  @State isRefreshing: boolean = false
  @State isLoadMore: boolean = false
  @State currentIndex: number = 0
  private scroller: Scroller = new Scroller();


  aboutToAppear() {
    const newsModelMockData: Array<NewsData> = getNewsData(1)
    for (let j = 0; j < NEWS_MOCK_DATA_COUNT; j++) {
      this.newsData.pushData(newsModelMockData[j]);
    }
  }

  @Builder customRefreshComponent()
  {
    Stack()
    {
      Row()
      {
        LoadingProgress().height(32)
        Text("正在刷新...").fontSize(16).margin({left:20})
      }
      .alignItems(VerticalAlign.Center)
    }.width("100%").align(Alignment.Center).margin({
      bottom: 10
    })
  }

  @Builder
  private getListView() {
    List({
      space: 3, scroller: this.scroller
    }) {
      LazyForEach(this.newsData, (item: NewsData) => {
        ListItem() {
          Row() {
            Column()
            {
              Image($r('app.media.output'))
                .border({
                  radius: 4
                })
                .height(80)
            }
            .width("30%")

            Column()
            {
              Row() {
                Flex({
                  direction: FlexDirection.Column,
                  alignContent: FlexAlign.Start,
                }){
                  Text(item.Title)
                    .fontSize(14)
                    .padding({
                      top: 2,
                      bottom: 4
                    })

                  Text(item.Des)
                    .fontSize(12)
                    .maxLines(1)
                    .textOverflow({ overflow: TextOverflow.Ellipsis})
                    .fontColor("F8F7FC")
                    .padding({
                      bottom: 4,
                      right: 4
                    })

                  Text("28讲 | 781人已学习")
                    .fontSize(12)
                    .fontColor(Color.Gray)
                    .padding({
                      bottom: 4
                    })

                  Flex({
                    justifyContent: FlexAlign.SpaceBetween
                  }){
                    Flex({
                      direction: FlexDirection.Row,
                      alignItems: ItemAlign.Center
                    }){
                      Text("新人首单")
                        .fontSize(10)
                        .fontColor("#d87a6b")
                        .margin(2)
                        .padding({
                          left:4,
                          right: 4
                        })
                        .border({
                          width:1,
                          color: "#d87a6b",
                          radius: 4
                        })
                      Text(`￥${item.Price} `)
                        .fontColor(Color.Orange)

                      Text(`￥${item.NormalPrice}`)
                        .decoration({
                          type: TextDecorationType.LineThrough,
                          color: Color.Grey
                        })
                        .fontColor(Color.Grey)
                        .fontSize(12)
                    }

                    Text("查看")
                      .fontColor(Color.Orange)
                      .textAlign(TextAlign.Center)
                      .fontSize(10)
                      .width(30)
                      .border({
                        width: 1,
                        radius: 3,
                        color: Color.Orange,
                        style: BorderStyle.Solid
                      })
                      .onClick(() => {
                        AlertDialog.show({
                          title: '课程',
                          message: '请确认是否跳转到课程详情',
                          autoCancel: true,
                          alignment: DialogAlignment.Center,
                          offset: { dx: 0, dy: -20 },
                          gridCount: 3,
                          confirm: {
                            value: '跳转',
                            action: () => {
                              console.info('Button-clicking callback')
                            }
                          },
                          cancel: () => {
                            console.info('Closed callbacks')
                          }
                        }
                        )
                      })
                  }
                }
                .padding({
                  left: 4
                })
              }
            }
            .width("70%")
          }
          .height(80)
          .margin({
            bottom:20
          })
        }.onClick(() => {
          router.pushUrl({
            url: "pages/course/Detail"
          })
        })
      })
    }
    .backgroundColor(Color.White)
    .width("95%")
    .height("95%")
    .margin(10)
    .padding(10)
    .lanes(1)
    .scrollBar(BarState.Off)
    .listDirection(Axis.Vertical)
    .alignListItem(ListItemAlign.Center)
    .edgeEffect(EdgeEffect.None)
    .onReachEnd(() => {
      this.currentIndex = this.currentIndex + 1;
      // this.isLoadMore = true
      // setTimeout(() => {
      //   let list = GetData(this.currentIndex);
      //   this.dataLists.push(...list);
      //   this.isLoadMore = false
      // }, 2000)

      console.log(`第几行${this.currentIndex}2222`);
    })
  }

  build() {
    Column() {
      Navigation(){
        PullToRefresh({
          // TODO: 知识点：使用PullToRefresh组件时需要先绑定数据与主体布局。若使用LazyForEach组件渲染列表时，需将UI方法使用@Builder修饰并传入customList属性中。
          // 必传项，列表组件所绑定的数据
          data: $newsData,
          // refreshText: "正在刷新课程列表",
          // loadText: "正在加载课程列表",
          // 必传项，需绑定传入主体布局内的列表或宫格组件
          scroller: this.scroller,
          // 必传项，自定义主体布局，内部有列表或宫格组件
          customList: () => {
            // 一个用@Builder修饰过的UI方法
            this.getListView();
          },
          // TODO: 知识点：设置onRefresh下拉刷新回调方法，该方法必须返回一个Promise类型。
          onRefresh: () => {
            return new Promise<string>((resolve, reject) => {
              // 模拟网络请求操作，请求网络1.5秒后得到数据，通知组件，变更列表数据
              setTimeout(() => {
                this.newsData.clear();

                getNewsData(1).forEach((item) => {
                  this.newsData.pushData(item);
                })

                resolve(NEWS_RESOLVE_SUCCESS)
              }, NEWS_REFRESH_TIME);
            });
          },
          // TODO: 知识点：设置onLoadMore上滑加载更多数据回调方法，该方法必须返回一个Promise类型。
          onLoadMore: () => {
            return new Promise<string>((resolve, reject) => {
              // 模拟网络请求操作，请求网络1.5秒后得到数据，通知组件，变更列表数据
              setTimeout(() => {
                let newsModelMockData: Array<NewsData> = getNewsData(this.currentIndex)
                for (let j = 0; j < NEWS_MOCK_DATA_COUNT; j++) {
                  this.newsData.pushData(newsModelMockData[j]);
                }
                resolve(NEWS_RESOLVE_SUCCESS)
              }, NEWS_REFRESH_TIME);
            });
          },
          customLoad: null,
          customRefresh: null
        })
      }
      .size({width: "100%", height: "100%"})
      .titleMode(NavigationTitleMode.Free)
      .title("WebView")
    }
    .height("100%")
  }
}