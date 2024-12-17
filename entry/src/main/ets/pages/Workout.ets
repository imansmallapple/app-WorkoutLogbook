import DateUtil from '../Utils/DateUtils';
import { Exercise, WorkoutItem } from './WorkoutItem';
import systemDateTime from '@ohos.systemDateTime';
import { BusinessError } from '@ohos.base';
import { OptionDialog } from '../Component/exerciseOptionComponent'
import { Sport } from '../model/dailyExercise'
import { Record } from '../model/record'
import promptAction from '@ohos.promptAction';
import router from '@ohos.router';

// PersistentStorage.persistProp<Record[]>('recordList', [])
PersistentStorage.persistProp<Sport[]>('todaySports', [])
AppStorage.setOrCreate<Record[]>("recordList", []);

export class FinishObject {
  date: string = ''
  isFinish: boolean = false
}

export class SportSchedule {
  date: string = ''
  sports: Sport[] = []
}

@Entry
@Component
export struct Workout {
  @State convertedDate: string = ''
  @StorageProp('date') date: number = DateUtil.beginTimeOfDay(new Date())
  @StorageLink('current_date') currentDate: string = ''
  optionDialogController: CustomDialogController = new CustomDialogController({
    builder: OptionDialog({}),
    alignment: DialogAlignment.Center
  })
  @State selectedDate: string = DateUtil.timestampToDate(new Date().getTime());
  @StorageProp('recordList') records: Record[] = []
  @State todaySports: Sport[] = AppStorage.get("todaySports") ?? []
  @State todayRecord: Record = new Record()
  @State finishObj: FinishObject = new FinishObject()
  @State isTodayFinish: boolean = false
  @State num: number = 0
  @State sportSchedule: SportSchedule = new SportSchedule()

  @Builder
  PagesMap(name: string) {
    if (name == "Workout List") {
      WorkoutItem()
    }
  }

  aboutToAppear(): void {
    console.info('aboutToAppear')

    systemDateTime.getCurrentTime((error: BusinessError, time: number) => {
      this.convertedDate = DateUtil.timestampToDate(time);
    });
  }

  onPageShow(): void {
    console.info('onPageShow')
  }

  aboutToRecycle(): void {
    console.info('recycle')
  }

  build() {
    Column() {
      Column() {
        Column() {
          Row() {
            Text(`${this.selectedDate}`)
              .fontSize(15)
              .fontWeight(500)
            // Image($r('app.media.drop_icon'))
            //   .width(15)
            //   .margin({ left: 10 })
          }
          .width('50%')
          .height(50)
          .backgroundColor(Color.White)
          .margin({
            bottom: 30
          })
          .borderRadius(10)
          .justifyContent(FlexAlign.Center)
          // .onClick(() => {
          //   CalendarPickerDialog.show({
          //     selected: new Date(this.selectedDate),
          //     onAccept: (value) => {
          //       console.info("Calendar onAccept:" + JSON.stringify(value));
          //       this.selectedDate = DateUtil.timestampToDate(value.getTime()); // 更新选中的日期
          //     },
          //     onCancel: () => {
          //       console.info("Calendar onCancel");
          //     },
          //     onChange: (value) => {
          //       console.info("Calendar onChange:" + JSON.stringify(value));
          //       this.selectedDate = DateUtil.timestampToDate(value.getTime()); // 实时更新选中的日期
          //     },
          //   });
          //
          // })
          .shadow({
            radius: 20,
            offsetX: 10,
            offsetY: 10,
            color: '#8044a04f'
          })
          .margin({ top: 30 })

          Row() {
            if (this.finishObj.date !== this.selectedDate) {
              Text('Have you worked out today?')
                .fontSize(18)
                .fontColor('#ff0b256e')
            }
            else {
              Text('Good Job! Keep going~')
                .fontSize(18)
                .fontColor('#ff0b256e')
            }
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
        // this.optionDialogController.open()
        router.pushUrl({
          url: 'pages/AddSport'
        })
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
      .margin({
        bottom: 25
      })

      Column() {
        Row() {
          Text("Task List")
            .fontSize(13)
            .fontWeight(700)
            .margin({ left: 20, top: 20, bottom: 10 })
          Blank()
          if (this.finishObj.date !== this.selectedDate) {

            Button('Finish')
              .type(ButtonType.Normal)
              .borderRadius(5)
              .width(80)
              .fontSize(15)
              .margin({ right: 10 })
              .backgroundColor(Color.Black)
              .onClick(() => {
                if (this.todaySports.length == 0) {
                  promptAction.showToast({
                    message: "Please add a sport first!"
                  })
                }
                else {
                  this.finishObj.date = this.selectedDate
                  this.finishObj.isFinish = true

                  this.records.push(this.todayRecord)
                  console.info(`${this.todayRecord.date}`)
                  this.todayRecord.sports = this.todaySports
                  this.todayRecord.date = this.selectedDate
                  AppStorage.setOrCreate<Record[]>("recordList", this.records);

                  promptAction.showToast({
                    message: 'Task finished! Keep going~'
                  })
                  router.pushUrl({ url: 'pages/Record',
                    params: {
                      record: this.todayRecord
                    }
                  })
                }
              })
          }
        }
        .width('100%')

        if (this.finishObj.date == this.selectedDate) {
          Column({ space: 8 }) {
            Image($r('app.media.startIcon'))
              .width(100)
              .height(100)
            Text('Congratulations, you finished all tasks!')
              .fontSize(20)
              .opacity(0.4)
          }
          .width('100%')
          .margin({ top: 20 })
        } else {
          if (this.todaySports.length !== 0) {
            Column() {
              List() {
                ForEach(this.todaySports, (item: Sport) => {
                  ListItem() {
                    Row({ space: 10 }) {
                      Image($r('app.media.app_icon'))
                        .width(60)
                        .height(60)
                      Text(item.name)
                        .fontSize(13)
                        .fontWeight(600)
                        .opacity(0.8)
                      Text(`Left:${item.num} hours`)
                        .fontSize(13)
                        .fontWeight(600)
                        .opacity(0.8)
                      Blank()
                      Text(`${(item.num as number) * item.consume} calories`)
                        .fontSize(13)
                        .fontWeight(600)
                        .opacity(0.8)

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
            .margin({ top: 20 })
          }
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

