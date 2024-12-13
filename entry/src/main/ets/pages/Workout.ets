import DateUtil from '../Utils/DateUtils';
import { WorkoutItem } from './WorkoutItem';
import systemDateTime from '@ohos.systemDateTime';
import { BusinessError } from '@ohos.base';
import { CalenderDialog } from '../Component/calender'
import { OptionDialog } from '../Component/exerciseOptionComponent'

@Entry
@Component
export struct Workout {
  pathStack: NavPathStack = new NavPathStack()
  private tabController: TabsController = new TabsController()
  @State convertedDate: string = ''
  @StorageProp('date') date: number = DateUtil.beginTimeOfDay(new Date())
  @StorageLink('current_date') currentDate: string = ''
  optionDialogController: CustomDialogController = new CustomDialogController({
    builder: OptionDialog({}),
    alignment: DialogAlignment.Center
  })
  @State selectedDate: string = DateUtil.timestampToDate(new Date().getTime());

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
    Stack() {
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

          Row() {
            Text('Have you worked out today?')
              .fontSize(18)
              .fontColor('#ff0b256e')
          }
          .width('80%')
          .height('20%')
          .margin({
            bottom: ('80%')
          })
          .justifyContent(FlexAlign.Center)
        }
        .justifyContent(FlexAlign.Center)
        .backgroundColor(Color.White)
        .height('100%')
        .width('100%')
      }
      .height('100%')

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
        Column() {
          Image($r('app.media.calendar_icon'))
            .width(30)
            .onClick(() => {

            })

          Text('Choose another day if you want')
            .fontColor('#9f777676')
        }
        .alignItems(HorizontalAlign.End)
      }
      .alignItems(HorizontalAlign.End)
      .justifyContent(FlexAlign.End)
      .width('80%')
      .height('30%')
      .zIndex(0)
    }
    .alignContent(Alignment.Center)
    .width('100%')
    .height('100%')
  }
}

