import DateUtil from '../Utils/DateUtils';
import { WorkoutItem } from './WorkoutItem';
import DateDialog from '../Component/dateSelectionDialog'
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
  dateSelectionController: CustomDialogController = new CustomDialogController({
    builder: DateDialog({
      date: new Date(this.date)
    })
  })
  calenderDialogController: CustomDialogController = new CustomDialogController({
    builder: DateDialog({
      date: new Date(this.date)
    })
  })
  optionDialogController: CustomDialogController = new CustomDialogController({
    builder: OptionDialog({}),
    alignment: DialogAlignment.Center
  })

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
    Navigation(this.pathStack) {
      Stack() {
        Column() {
          Column() {


            // todo: 这一部分先拿来测试 date的数据，之后记得commit掉
            Text(`${this.currentDate}`)
            Row() {
              Text(`${this.currentDate == '' ? this.convertedDate : this.currentDate}`)
                .fontSize(15)
                .fontWeight(500)
              Image($r('app.media.drop_icon'))
                .width(15)
                .margin({ left: 10 })
            }
            .width('90%')
            .height(50)
            .backgroundColor(Color.White)
            .margin({
              bottom: 30
            })
            .borderRadius(20)
            .borderWidth(1)
            .justifyContent(FlexAlign.Center)
            .onClick(() => {
              this.dateSelectionController.open()
            })

            Row() {
              Text('Have you worked out today?')
                .fontSize(25)
                .fontColor(Color.Blue)
            }
            .width('80%')
            .height('20%')
            .margin({
              bottom: ('80%')
            })
          }
          .justifyContent(FlexAlign.Center)
          .backgroundColor(Color.Pink)
          .height('100%')
          .width('100%')
        }
        .height('100%')

        Button() {
          Column({ space: 10 }) {
            Text('Add workout')
              .fontSize(25)
            Image($r('app.media.add_icon'))
              .width(40)
          }
        }
        .onClick(() => {
          this.optionDialogController.open()
          // this.pathStack.pushPathByName("OptionPage", '');
          // this.pathStack.pushPathByName("Workout List", '');
        })
        .fontSize(25)
        .backgroundColor(Color.Gray)
        .type(ButtonType.Normal)
        .borderRadius(20)
        .fontWeight(800)
        .padding({
          top: 20,
          bottom: 20,
          left: 40,
          right: 40
        })
        .zIndex(1)

        Column() {
          Column() {
            Image($r('app.media.calendar_icon'))
              .width(30)
              .onClick(() => {
                this.calenderDialogController.open()
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
    .mode(NavigationMode.Stack)
    .titleMode(NavigationTitleMode.Mini)
    .title('Index')
    .navDestination(this.PagesMap)
    .hideBackButton(true)
  }
}

