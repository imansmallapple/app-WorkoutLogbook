import { Sport } from '../model/dailyExercise';

@Component
export default struct TaskItem {
  @State item: Sport = new Sport()
  @State isComplete: boolean = false;
  @State isStart: boolean = false;
  @State leftTime: number = 0.01;
  @State timeUsed: number = 0
  @Link burnedCalories: number;
  timerController: TextTimerController = new TextTimerController()

  @Builder
  labelIcon(icon: string | Resource) {
    Image(icon)
      .objectFit(ImageFit.Contain)
      .width("25vp")
      .height("25vp")
      .margin({ left: 15 })
  }

  startSport() {
    this.timerController.start()
  }

  pauseSport() {
    this.timerController.pause()
  }

  showBurnedCalories(goal: number, elapsedTime: number, totalTime: number) {
    this.burnedCalories = parseInt(((elapsedTime / totalTime) * goal).toFixed(1))
  }

  build() {
    Row({ space: 10 }) {
      Image(this.item.icon)
        .width(60)
        .height(60)

      Column() {
        Text(this.item.name)
          .fontSize(13)
          .fontWeight(600)
          .opacity(this.isComplete ? 0.4 : 0.8)
          .decoration({
            type: this.isComplete ? TextDecorationType.LineThrough : TextDecorationType.None
          })
        if (!this.isComplete) {
          TextTimer({
            controller: this.timerController,
            isCountDown: true,
            count: (this.item.num as number) * 3600000
          })
            .onTimer((utc, elapsedTime) => {
              this.timeUsed = elapsedTime
              const remainingTime = (this.item.num as number) * 3600000 - elapsedTime
              this.showBurnedCalories(((this.item.num as number) * this.item.consume), elapsedTime, (this.item.num as number) * 3600000)
              this.item.burnedCalories = this.burnedCalories
              this.item.usedTime = elapsedTime
              if (remainingTime <= 0) {
                this.item.isFinish = true
                this.isComplete = true
                console.info('stoped')
              }
            })
        }
      }

      Blank()
      Text(`Consumed: ${this.item.burnedCalories} calories`)
        .fontSize(13)
        .fontWeight(600)
        .opacity(this.isComplete ? 0.4 : 0.8)
        .decoration({
          type: this.isComplete ? TextDecorationType.LineThrough : TextDecorationType.None
        })

      Row() {
        if (!this.isComplete && !this.isStart) {
          this.labelIcon($r('app.media.start_icon'))
        } else if (this.isStart && !this.isComplete) {
          this.labelIcon($r('app.media.pause_icon'))
        } else if (this.isComplete) {
          this.labelIcon($r('app.media.complete_icon'))
        }
      }
      .margin({left: 50})
    }
    .width('100%')
    .backgroundColor(Color.White)
    .borderRadius(15)
    .margin({ bottom: 10, right: 10 })
    .onClick(() => {
      this.isStart = !this.isStart
      this.isStart ? this.startSport() : this.pauseSport()
    })

  }
}