import { Sport } from '../model/dailyExercise'
import { SportDetailDialog } from '../Component/SportDetailDialog'
import { SportData } from '../Data/sportData';

AppStorage.setOrCreate<Sport>("current_sport", new Sport());

@Entry
@Component
struct AddSport {
  @StorageLink("current_sport") current_sport: Sport = new Sport();
  @State num: number = 0
  controller: CustomDialogController = new CustomDialogController({
    builder: SportDetailDialog({
      num: $num
    })
  })
  arr: Sport[] = SportData

  build() {
    Column() {
      Row() {
        Image($r('app.media.back_icon'))
          .width(25)
      }
      .margin({ top: 10, left: 10, bottom: 10 })
      .onClick(() => {
        this.getUIContext().getRouter().back()
      })

      // Text(`num:${this.num}`)

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
                Text(item.consume + ' calories/' + item.unit)
                  .fontSize(10)
                  .fontWeight(600)
                  .opacity(0.7)
              }
              .alignItems(HorizontalAlign.Start)

              Blank()
              Button() {
                Image($r('app.media.add'))
                  .width(20)
              }
              .backgroundColor(Color.Transparent)
              .onClick(() => {
                // todo: Trigger select sport action
                this.current_sport = item
                // console.info(`item icon:${item.icon.toString()}`)
                this.current_sport.num = this.num
                this.num = 0
                AppStorage.setOrCreate("current_sport", this.current_sport);
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