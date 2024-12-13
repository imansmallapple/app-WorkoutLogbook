import DateUtil from '../Utils/DateUtils';
import { Exercise, WorkoutItem } from './WorkoutItem';
import systemDateTime from '@ohos.systemDateTime';
import { BusinessError } from '@ohos.base';
import { OptionDialog } from '../Component/exerciseOptionComponent'
import { Sport } from '../model/dailyExercise'

@Entry
@Component
export struct Workout {
  pathStack: NavPathStack = new NavPathStack()
  @State convertedDate: string = ''
  @StorageProp('date') date: number = DateUtil.beginTimeOfDay(new Date())
  @StorageLink('current_date') currentDate: string = ''
  optionDialogController: CustomDialogController = new CustomDialogController({
    builder: OptionDialog({}),
    alignment: DialogAlignment.Center
  })
  @State selectedDate: string = DateUtil.timestampToDate(new Date().getTime());
  @State arr: Sport[] = [
  {
    name: 'dancing',
    icon: $r('app.media.app_icon'),
    consume: 400,
    target: 2,
    num: 1,
    unit: "times"
  },
  {
    name: 'Jumping',
    icon: $r('app.media.app_icon'),
    consume: 400,
    target: 2,
    num: 2,
    unit: "hours"
  },
  ]

  @Builder
  PagesMap(name: string) {
    if (name == "Workout List") {
      WorkoutItem()
    }
  }

  aboutToAppear(): void {
    AppStorage.setOrCreate("PathStack", this.pathStack)
    systemDateTime.getCurrentTime((error: BusinessError, time: number) => {
      this.convertedDate = DateUtil.timestampToDate(time);
    });
  }

  build() {
    Column() {
      Column() {
        Column() {
          Row() {
            Text(`${this.selectedDate}`)
              .fontSize(15)
              .fontWeight(500)
            Image($r('app.media.drop_icon'))
              .width(15)
              .margin({ left: 10 })
          }
          .width('50%')
          .height(50)
          .backgroundColor(Color.White)
          .margin({
            bottom: 30
          })
          .borderRadius(10)
          .justifyContent(FlexAlign.Center)
          .onClick(() => {
            CalendarPickerDialog.show({
              selected: new Date(this.selectedDate),
              onAccept: (value) => {
                console.info("Calendar onAccept:" + JSON.stringify(value));
                this.selectedDate = DateUtil.timestampToDate(value.getTime()); // 更新选中的日期
              },
              onCancel: () => {
                console.info("Calendar onCancel");
              },
              onChange: (value) => {
                console.info("Calendar onChange:" + JSON.stringify(value));
                this.selectedDate = DateUtil.timestampToDate(value.getTime()); // 实时更新选中的日期
              },
            });

          })
          .shadow({
            radius: 20,
            offsetX: 10,
            offsetY: 10,
            color: '#8044a04f'
          })
          .margin({ top: 30 })

          Row() {
            Text('Have you worked out today?')
              .fontSize(18)
              .fontColor('#ff0b256e')
          }
          .width('80%')
          .height('20%')
          .margin({
            bottom: ('10%')
          })
          .justifyContent(FlexAlign.Center)
        }
        .justifyContent(FlexAlign.Start)
        .backgroundColor(Color.White)
        .width('100%')
      }

      Button() {
        Column() {
          Text('+     Add workout')
            .fontSize(20)
            .fontColor(Color.White)
        }
      }
      .onClick(() => {
        this.optionDialogController.open()
      })
      .backgroundColor('#b770c805')
      .type(ButtonType.Normal)
      .borderRadius(20)
      .fontWeight(800)
      .padding({
        top: 10,
        bottom: 10,
        left: 30,
        right: 30
      })
      .zIndex(1)
      .shadow({
        radius: 30,
        offsetY: 10,
        color: Color.Gray
      })

      Column() {
        Text("Task List")
          .fontSize(13)
          .fontWeight(700)
          .margin({ left: 20, top: 20, bottom: 10 })
        if (this.arr.length !== 0) {
          Column() {
            List() {
              ForEach(this.arr, (item: Sport) => {
                ListItem() {
                  Row({ space: 10 }) {
                    Image($r('app.media.app_icon'))
                      .width(50)
                      .height(50)
                    Text(item.name)
                      .fontSize(13)
                      .fontWeight(600)
                      .opacity(0.8)
                    Blank()
                    if (item.num == item.target) {
                      Text('Consume ' + item.consume * (item.num as number) + ' Calories')
                        .fontSize(13)
                        .fontWeight(600)
                        .margin({ right: 10 })
                        .fontColor('#e90e5e85')
                    }
                  }
                  .width('100%')
                  .backgroundColor(Color.White)
                  .borderRadius(15)
                  .margin({ bottom: 10 })
                }
                .width('90%')
              })
            }
            .width('100%')
            .alignListItem(ListItemAlign.Center)
          }
          .width('100%')
        }
        else {
          Column({ space: 8 }) {
            Image($r('app.media.startIcon'))
              .width(100)
              .height(100)
            Text('No task, please add')
              .fontSize(20)
              .opacity(0.4)
          }
          .width('100%')
          .margin({top: 20})
        }
      }
      .width('100%')
      .height('100%')
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .height('100%')
  }
}

