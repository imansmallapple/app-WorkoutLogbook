import { Sport } from '../model/dailyExercise'
import router from '@ohos.router'

@Entry
@Component
struct AddSport {
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
      .onClick(()=>{
        router.back()
      })
      List({space: 10}){
        ForEach(this.arr, (item:Sport)=>{
          ListItem(){
            Row(){
                // todo: Content to be added
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