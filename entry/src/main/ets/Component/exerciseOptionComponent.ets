import router from '@ohos.router'

@CustomDialog
@Preview
@Component
export struct OptionDialog {
  controller: CustomDialogController = new CustomDialogController({
    builder: OptionDialog()
  })

  build() {
    Column() {
      Row(){
        Text("Choose your exercise preference")
      }
      Column({space: 10}) {
        Row({ space: 10 }) {
          Text('Daily exercise')
          Image($r('app.media.daily_sport_icon'))
            .width(40)
        }
        .alignItems(VerticalAlign.Center)
        .justifyContent(FlexAlign.Center)
        .width('90%')
        .height('40%')
        .backgroundColor(Color.Pink)
        .borderRadius(20)
        .margin({
          top:'5%'
        })

        Row({ space: 10 }) {
          Text('Strength training')
          Image($r('app.media.strength_icon'))
            .width(40)
        }
        .alignItems(VerticalAlign.Center)
        .justifyContent(FlexAlign.Center)
        .width('90%')
        .height('40%')
        .backgroundColor(Color.Gray)
        .borderRadius(20)
        .onClick(()=>{
          router.pushUrl({url: 'pages/WorkoutItem'})
        })
      }
    }
    .borderRadius(20)
    .width('100%')
    .height('50%')
    .backgroundColor(Color.Orange)

  }
}