import { Exercise } from './WorkoutItem'

@Entry
@Component
export struct Record {
  pathStack: NavPathStack = new NavPathStack()
  @StorageLink('selectedExerciseList') selectedExercise: Exercise[] = []

  @Builder
  NavigationComponent() {
    Row() {
      Row() {
        Row() {
          Image($r('app.media.back_icon'))
            .width(20)
        }
        .width('10%')
        .justifyContent(FlexAlign.Center)

        Row() {
          Text('Training history')
            .fontSize(20)
            .fontWeight(600)
            .fontColor('#ff280b66')
        }
        .width('80%')
        .justifyContent(FlexAlign.Center)
      }
      .layoutWeight(1)
      .justifyContent(FlexAlign.Start)
    }
    .width('100%')
    .height('10%')
    .backgroundColor('#00ffffff')
    .shadow({
      radius: 5,
      offsetY: 8,
      color: '#1b000000'
    })
  }

  build() {
    Column() {
      this.NavigationComponent()
      Column({ space: 10 }) {
        List() {
          ForEach(this.selectedExercise, (item: Exercise) => {
            ListItem() {
              Text(item.name)
            }
          })
        }

        Row() {
          Column() {

            Row() {
              Text('24th November 2024')
                .fontSize(18)
                .fontColor('#f735028a')
                .fontWeight(500)
            }
            .width('100%')

            Row() {
              Divider()
                .width(38)
                .strokeWidth(2)
                .color(Color.Green)
            }
            .width('100%')
            .justifyContent(FlexAlign.Start)

            Column({ space: 10 }) {
              Column() {
                Row() {
                  Text('Seated Triceps press')
                    .fontSize(18)
                    .fontColor('#f735028a')
                    .fontWeight(600)
                    .margin({
                      left: 10
                    })
                    .height(30)
                }

                Row() {
                  Text('20m04s')
                    .fontSize(10)
                    .fontColor('#f735028a')
                    .fontWeight(600)
                    .margin({
                      right: 5
                    })
                }
                .justifyContent(FlexAlign.End)
                .width('100%')
                .height(10)
              }
              .alignItems(HorizontalAlign.Start)
              .width('95%')
              .height(50)
              .borderRadius(10)
              .shadow({
                radius: 10,
                offsetY: 10,
                color: '#5b5ea237'
              })

              Column() {
                Row() {
                  Text('Seated Triceps press')
                    .fontSize(18)
                    .fontColor('#f735028a')
                    .fontWeight(600)
                    .margin({
                      left: 10
                    })
                    .height(30)
                }

                Row() {
                  Text('20m04s')
                    .fontSize(10)
                    .fontColor('#f735028a')
                    .fontWeight(600)
                    .margin({
                      right: 5
                    })
                }
                .justifyContent(FlexAlign.End)
                .width('100%')
                .height(10)
              }
              .alignItems(HorizontalAlign.Start)
              .width('95%')
              .height(50)
              .borderRadius(10)
              .shadow({
                radius: 10,
                offsetY: 10,
                color: '#5b5ea237'
              })
            }
            Row(){
              Text('Total: 48m49s')
                .fontColor('#f735028a')
                .fontSize(15)
            }
            .width('100%')
            .margin({top: 5})
            .justifyContent(FlexAlign.End)
          }
        }
        .width('100%')
        .height('20%')
        .borderWidth(1)
        .justifyContent(FlexAlign.Start)
        .alignItems(VerticalAlign.Top)
      }
    }
    .width('100%')
    .height('100%')
  }
}