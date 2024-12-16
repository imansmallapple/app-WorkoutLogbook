import { Sport } from '../model/dailyExercise'
import router from '@ohos.router'
import { SportDetailDialog } from '../Component/SportDetailDialog'

@Entry
@Component
struct AddSport {
  controller: CustomDialogController = new CustomDialogController({
    builder: SportDetailDialog()
  })
  arr: Sport[] = [
    {
      name: 'Dancing',
      icon: $r('app.media.icon'),
      consume: 600,
      unit: 'hours'
    },
    {
      name: 'Bicycle',
      icon: $r('app.media.icon'),
      consume: 600,
      unit: 'hours'
    }
  ]

  build() {
    Column() {
      Row() {
        Image($r('app.media.icon'))
          .width(25)
      }
      .margin({ top: 10, left: 10, bottom: 10 })
      .onClick(() => {
        router.back()
      })

      List({ space: 10 }) {
        ForEach(this.arr, (item: Sport) => {
          ListItem() {
            Row() {
              Image(item.icon)
                .width(60)
                .height(60)
                .margin({ right: 15 })
              Column() {
                Text(item.name)
                  .fontSize(15)
                  .fontWeight(500)
                Text(item.consume + ' calories ' + item.unit)
                  .fontSize(10)
                  .fontWeight(600)
                  .opacity(0.7)
              }
              .alignItems(HorizontalAlign.Start)

              Blank()
              Button() {
                Image($r('app.media.icon'))
                  .width(20)
              }
              .backgroundColor(Color.Transparent)
              .onClick(() => {
                // todo: Trigger select sport action
                this.controller.open()
              })
            }
            .width('100%')
            .justifyContent(FlexAlign.SpaceBetween)
          }
          .width('95%')
          .backgroundColor(Color.White)
          .padding(5)
        })
      }
      .width('100%')
      .alignListItem(ListItemAlign.Center)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.Gray)
    .alignItems(HorizontalAlign.Start)
  }
}