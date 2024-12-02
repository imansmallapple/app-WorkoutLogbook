import { Exercise } from './WorkoutItem'

@Entry
@Component
export struct Record {
  pathStack: NavPathStack = new NavPathStack()
  @StorageLink('selectedExerciseList') selectedExercise: Exercise[] = []

  onPageShow(): void {
    AppStorage.setOrCreate("PathStack", this.pathStack)
  }

  build() {
    NavDestination() {
      Column() {
        Column({ space: 10 }) {
          List() {
            ForEach(this.selectedExercise, (item: Exercise) => {
              ListItem() {
                Text(item.name)
              }
            })
          }
          Row() {
            Text('date')
          }
        }
      }
      .width('100%')
      .height('100%')
    }
    .title('Record')
    .onReady((context: NavDestinationContext) => {
      this.pathStack = context.pathStack
    })
  }
}