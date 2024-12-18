import { Sport } from '../model/dailyExercise';

@Component
export default struct TaskItem {
  private item?: Sport;
  @State isComplete: boolean = false;
  @State isStart: boolean = false;

  @Builder
  labelIcon(icon: string | Resource) { // Define a method named 'labelIcon' to build label icons
    Image(icon)// Create an Image component with the icon parameter as the source
      .objectFit(ImageFit.Contain)// Set the image object fit to 'Contain'
      .width("25vp")// Set image width to 28vp
      .height("25vp")// Set image height to 28vp
      .margin("10vp") // Set margin to 20vp
  }

  build() {
    Row({ space: 10 }) {
      Image($r('app.media.app_icon'))
        .width(60)
        .height(60)
      Text(this.item.name)
        .fontSize(13)
        .fontWeight(600)
        .opacity(0.8)
      Text(`Left:${this.item.num} hours`)
        .fontSize(13)
        .fontWeight(600)
        .opacity(0.8)
      Blank()
      Text(`${(this.item.num as number) * this.item.consume} calories`)
        .fontSize(13)
        .fontWeight(600)
        .opacity(0.8)
      if (this.item.num == this.item.target) {
        Text('Consume ' + this.item.consume * (this.item.num as number) + ' Calories')
          .fontSize(13)
          .fontWeight(600)
          .margin({ right: 10 })
          .fontColor('#e90e5e85')
      }
      Row() {
        if (!this.isComplete && !this.isStart) {
          this.labelIcon($r('app.media.start_icon'))
        } else if(this.isStart && !this.isComplete) {
          this.labelIcon($r('app.media.pause_icon'))
        } else if(this.isComplete){
          Text('Complete')
        }
      }
      .onClick(()=>{
        this.isStart = !this.isStart
      })
    }
    .width('100%')
    .backgroundColor(Color.White)
    .borderRadius(15)
    .margin({ bottom: 10 })

  }
}