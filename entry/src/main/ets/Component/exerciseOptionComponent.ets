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
      .height('10%')
      Column({space: 10}) {
        Row({ space: 10 }) {
          Image($r('app.media.daily_sport_icon'))
            .width(40)
          Text('Daily exercise')
        }
        .alignItems(VerticalAlign.Center)
        .justifyContent(FlexAlign.Center)
        .width('90%')
        .height('35%')
        .backgroundColor(Color.White)
        .borderRadius(20)
        .margin({
          top:'5%'
        })
        .shadow({
          radius: 50,
          offsetY: 10,
          color: '#6f37a441'
        })

        Row({ space: 10 }) {
          Image($r('app.media.strength_icon'))
            .width(40)
          Text('Strength training')
        }
        .alignItems(VerticalAlign.Center)
        .justifyContent(FlexAlign.Center)
        .width('90%')
        .height('35%')
        .backgroundColor(Color.White)
        .borderRadius(20)
        .onClick(()=>{
          router.pushUrl({url: 'pages/WorkoutItem'})
        })
        .shadow({
          radius: 20,
          offsetY: 10,
          color: '#6f37a441'
        })
      }
    }
    .borderRadius(20)
    .width('100%')
    .height('30%')
    .backgroundColor(Color.White)

  }
}