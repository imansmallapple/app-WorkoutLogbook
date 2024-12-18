import { Exercise } from './WorkoutItem'
import { Record } from '../model/record'
import { Sport } from '../model/dailyExercise'
import router from '@ohos.router'
import TimeUtil from '../Utils/TimeUtils'

PersistentStorage.persistProp<Record[]>('records', [])

interface RouterParams {
  record: Record
}

@Entry
@Component
export struct RecordPage {
  @StorageLink('selectedExerciseList') selectedExercise: Exercise[] = []
  // @State records: Record[] = AppStorage.get("recordList") ?? []
  // @State records: Record[] = []
  @State record: Record = new Record()
  @StorageLink('records') records: Record[] = []
  @State totalTime: number = 0
  @State totalCalories: number = 0

  aboutToAppear(): void {
    console.info('RecordPage aboutToAppear triggered');
    console.info(`Number of records: ${this.records.length}`);
    this.records.forEach((item: Record, index: number) => {
      console.info(`Record ${index}: Date = ${item.date}`);
    });
  }

  onPageShow() {
    const params = router.getParams() as RouterParams
    this.record = params.record
    this.records.push(this.record)
    this.updateTotals(); // 更新总计
  }
  updateTotals(): void {
    this.totalTime = 0;
    this.totalCalories = 0;

    this.records.forEach((record: Record) => {
      record.sports.forEach((sport: Sport) => {
        this.totalTime += sport.usedTime;
        this.totalCalories += sport.burnedCalories;
      });
    });

    console.info(`Updated totals: Time = ${this.totalTime}, Calories = ${this.totalCalories}`);
  }

  @Builder
  NavigationComponent() {
    Row() {
      Row() {
        Row() {
          Image($r('app.media.back_icon'))
            .width(20)
        }
        .onClick(() => {
          router.back()
        })
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

        if (this.records.length == 0) {
          Column({ space: 8 }) {
            Image($r('app.media.startIcon'))
              .width(100)
              .height(100)
            Text('No records')
              .fontSize(20)
              .opacity(0.4)
          }
          .width('100%')
          .height('100%')
          .justifyContent(FlexAlign.Center)
        } else {
          Row() {
            Column() {
              List() {
                ForEach(this.records, (item: Record, index: number) => {
                  ListItem() {
                    Column() {
                      Row() {
                        Text(`${item.date}`)
                          .fontSize(18)
                          .fontColor('#f735028a')
                          .fontWeight(500)
                      }
                      .width('100%')

                      Row() {
                        // Stores all sports of this day
                        List() {
                          ForEach(item.sports, (sport: Sport, index: number) => {
                            ListItem() {
                              Column() {
                                Row({space: 10}) {
                                  Text(`${sport.name}`)
                                    .fontSize(18)
                                    .fontColor('#f735028a')
                                    .fontWeight(600)
                                    .margin({
                                      left: 10
                                    })
                                    .height(30)
                                  Text(`Burned calories: ${sport.burnedCalories}`)
                                    .fontSize(15)
                                    .fontWeight(500)
                                    .fontColor('#ff800303')
                                }

                                Row() {
                                  Text(`${TimeUtil.formatMilliseconds(sport.usedTime)}/${TimeUtil.formatHoursToHM(sport.num as number)}`)
                                    .fontSize(10)
                                    .fontColor('#f735028a')
                                    .fontWeight(600)
                                    .margin({
                                      right: 5
                                    })
                                }
                                .justifyContent(FlexAlign.End)
                                .width('100%')
                                .height(15)
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
                              .margin({ bottom: 15 })
                            }
                          })
                        }
                      }
                      Row(){
                        Text(`Total time:${TimeUtil.formatMilliseconds(this.totalTime)}, consumed calories:${this.totalCalories}`)
                          .fontWeight(500)
                          .fontColor('#ff01273e')
                      }
                    }
                  }
                })
              }
            }
          }
          .width('100%')
          .height('100%')
          .justifyContent(FlexAlign.Start)
          .alignItems(VerticalAlign.Top)
        }
      }
    }
    .width('100%')
    .height('100%')
  }
}