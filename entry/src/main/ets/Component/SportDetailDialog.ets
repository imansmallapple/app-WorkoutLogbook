import DateUtil from '../Utils/DateUtils';
import { Callback } from '@ohos.base';

@Preview
@CustomDialog
export struct SportDetailDialog {
  @StorageProp('date') date: number = DateUtil.beginTimeOfDay(new Date())
  @State show: boolean = true
  keyboardArray: string[] = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '0', '.']
  controller: CustomDialogController
  @State val: string = ''
  @State num: number = 0
  @State calorie: number = 0

  @Builder
  confirmButton(text: string, color: ResourceColor | string, onClick: ((event: ClickEvent) => void)) {
    Button() {
      Text(text)
        .fontSize(20)
        .fontWeight(800)
        .opacity(0.9)
    }
    .width(100)
    .height(50)
    .type(ButtonType.Normal)
    .backgroundColor(color)
    .borderRadius(5)
    .padding({ left: 5, right: 5 })
    .margin({ top: 15 })
    .onClick(onClick)
  }

  clickNumber(number: string) {
    let val = this.val + number

    //Make sure only one '.' exists
    let firstIndex: number = val.indexOf('.')
    let lastIndex: number = val.lastIndexOf('.')
    if (firstIndex !== lastIndex || (lastIndex != -1 && lastIndex < val.length - 2)) {
      return
    }

    let amount = this.parseFloat(val)
    if (amount >= 999.9) {
      this.num = 999.0
      this.val = '999'
    } else {
      this.num = amount
      this.val = val
    }
  }

  parseFloat(str: string) {
    if (!str) {
      return 0
    }

    if (str.endsWith(('.'))) {
      str = str.substring(0, str.length - 1)
    }
    return parseFloat(str)
  }

  build() {
    Column() {
      Row() {
        Image($r('app.media.icon'))
          .width(20)
          .height(20)
          .onClick(() => {
            this.controller.close()
          })

        Blank()

        Text(DateUtil.timestampToDate(this.date))
          .fontSize(15)
          .fontWeight(600)
      }
      .width('95%')
      .justifyContent(FlexAlign.End)

      Column({ space: 10 }) {
        Image($r('app.media.icon'))
          .width(90)
          .height(90)
        Text('Swimming')
          .fontSize(20)
          .fontWeight(700)
          .fontColor(Color.Gray)
        Row() {
          TextInput({ text: this.num.toFixed(1) })
            .width('35%')
            .fontSize(35)
            .fontColor('#ff033ba7')
            .caretColor(Color.Transparent)
            .textAlign(TextAlign.Center)
            .copyOption(CopyOptions.None)
            .onClick(() => {
              this.show = true
            })
          Text('/ hour')
            .fontSize(35)
            .opacity(0.7)
            .fontWeight(800)
        }

        Panel(this.show) {
          Column() {
            Grid() {
              ForEach(this.keyboardArray, (item: string) => {
                GridItem() {
                  Text(item)
                    .fontSize(20)
                    .fontWeight(500)
                }
                .keyboardButtonStyle()
                .onClick(() => {
                  this.clickNumber(item)
                })
              })

              GridItem() {
                Text('Reset')
                  .fontSize(20)
                  .fontWeight(500)
              }
              .keyboardButtonStyle()
              .onClick(() => {
                this.val = ''
                this.num = 0
              })

              GridItem() {
                this.confirmButton('Save', '#ff0ef3eb', () => {
                  this.show = false
                })
              }
              .columnStart(0)
              .columnEnd(2)

            }
            .columnsTemplate('1fr 1fr 1fr')
            .columnsGap(4)
            .rowsGap(4)
            .width('95%')
            .padding({ top: 15 })
          }
        }
        .mode(PanelMode.Half)
        .halfHeight(1050)
        .type(PanelType.Temporary)
        .dragBar(false)
        .width('100%')

        Row({ space: 20 }) {
          this.confirmButton('Modify', '#ff6c7570', () => {
            this.show = true
          })
          this.confirmButton('Confirm', '#ff08dec0', () => {
            this.controller.close()
          })
        }

        Row() {
          Text('Estimated to consume ' + this.calorie * this.num + ' calories')
            .fontSize(20)
            .fontWeight(700)
            .opacity(0.7)
        }

      }
    }
    .width('95%')
    .height('95%')
    .alignItems(HorizontalAlign.Center)
  }
}

@Extend(GridItem)
function keyboardButtonStyle() {
  .backgroundColor(Color.White)
  .opacity(0.7)
  .height(50)
  .borderRadius(15)
}