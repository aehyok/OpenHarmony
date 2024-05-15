import promptAction from '@ohos.promptAction';

@Component
export struct ToggleView {
  @State BOnSt:promptAction.ShowToastOptions = {'message': 'Bluetooth is on.'}
  @State BOffSt:promptAction.ShowToastOptions = {'message': 'Bluetooth is off.'}
  // 标签
  @State label: string = "";

  // 录入值
  @State value: boolean = false;
  @State placeholder: string = "";
  build() {
    Row(){
      Column(){
        Text(this.label)
      }.width("20%")

      Column(){
        Toggle({ type: ToggleType.Switch, isOn: this.value })
          .margin({left: 200,right :10})
          .onChange((isOn: boolean) => {
            if(isOn) {
              promptAction.showToast(this.BOnSt)
            } else {
              promptAction.showToast(this.BOffSt)
            }
          })
      }.width("80%")
    }
  }
}