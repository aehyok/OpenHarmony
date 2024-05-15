@Component
export struct TextView {
  // 标签
  @State label: string = "";

  // 录入值
  @State value: string = "";
  @State placeholder: string = "";
  build() {
    Row(){
      Column(){
        Text(this.label)
      }.width("20%")

      Column(){
        TextInput({
          text: this.value,
          placeholder: this.placeholder
        })
      }.width("80%")
    }
  }
}