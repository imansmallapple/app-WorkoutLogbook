import { Exercise, exerciseList } from './WorkoutItem'


@Entry
@Component
export struct ItemDetail {
  private exerciseList: Exercise[] = exerciseList
  pathStack: NavPathStack = new NavPathStack()
  @State workoutType: string = ''

  build() {
    NavDestination() {
      Text(`${this.workoutType}`)
      Grid() {
        ForEach(this.exerciseList, (item: Exercise, index: number) => {
          if (item.target_muscle.includes(this.workoutType)) {
            GridItem() {
              Text(item.name)
            }
            .borderWidth(1)
          }
        })
      }
      .rowsTemplate('1fr 1fr 1fr 1fr 1fr')
      .columnsTemplate('1fr 1fr 1fr 1fr')
    }
    .title('ItemDetail')
    .onReady((context: NavDestinationContext) => {
      this.workoutType = context.pathInfo.param as string
      this.pathStack = context.pathStack
    })
  }
}

