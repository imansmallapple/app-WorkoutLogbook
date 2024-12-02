import { Exercise, exerciseList } from './WorkoutItem'

PersistentStorage.persistProp<Exercise[]>('selectedExerciseList', [])

@Entry
@Component
export struct ItemDetail {
  private exerciseList: Exercise[] = exerciseList
  pathStack: NavPathStack = new NavPathStack()
  @State workoutType: string = ''
  @StorageLink('selectedExerciseList') selectedExercise: Exercise[] = []

  build() {
    NavDestination() {
      Column() {

        Grid() {
          ForEach(this.exerciseList, (item: Exercise, index: number) => {
            if (item.target_muscle.includes(this.workoutType)) {
              GridItem() {
                Column() {
                  Image(this.selectedExercise.includes(item) ? $r('app.media.selected_icon'):$r('app.media.unselected_icon'))
                    .width(20)
                  Text(item.name)
                }
                .width('100%')
                .height('100%')
              }
              .borderWidth(1)
              .onClick(() => {
                this.selectedExercise.push(item)
              })
            }
          })
        }
        .rowsTemplate('1fr 1fr 1fr 1fr 1fr')
        .columnsTemplate('1fr 1fr 1fr')
        .height('50%')

        Column() {
          List() {
            ForEach(this.selectedExercise, (item: Exercise) => {
              ListItem() {
                Text(item.name)
              }
            })
          }
        }
        .height('50%')
      }
    }
    .title('ItemDetail')
    .onReady((context: NavDestinationContext) => {
      this.workoutType = context.pathInfo.param as string
      this.pathStack = context.pathStack
    })
  }
}

