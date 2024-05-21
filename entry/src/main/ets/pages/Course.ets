interface Data {
  ImageUrl: string,
  Title: string,
  Price: number,
  NormalPrice: number,
  Des: string,
  Remark?: string
}

const GetData = (index: number) => {
  let dataList: Data[] = []
  let startInex = index * 20;
  let enIndex = (index + 1) * 20;

  for (let i = startInex; i < enIndex; i++) {
    let item: Data = {
      ImageUrl: `image${i}`,
      Title: `手写python虚拟机${i}`,
      Des: `${i}海纳 华为资深编译及专家，原huawei高级资深副总裁级别人物`,
      Price: i+1,
      NormalPrice: i+10+1,
    }
    dataList.push(item)
  }
  return dataList;
}

@Entry
@Component
export struct Course {
  @State dataLists: Data[] = GetData(0)
  @State currentIndex: number = 0
  build() {
    List() {
      ForEach(this.dataLists, (item: Data) => {
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
        }
      })
    }
    .backgroundColor(Color.White)
    .margin(10)
    .padding(10)
    .lanes(1)
    .scrollBar(BarState.Off)
    .listDirection(Axis.Vertical)
    .alignListItem(ListItemAlign.Center)
    .onReachEnd(() => {
      this.currentIndex = this.currentIndex + 1;
      let list = GetData(this.currentIndex);
      this.dataLists.push(...list);
      console.log(`第几行${this.currentIndex}2222`);
    })
  }
}