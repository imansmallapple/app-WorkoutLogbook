import { Exercise, exerciseList } from './WorkoutItem'

PersistentStorage.persistProp<Exercise[]>('selectedExerciseList', [])

@Entry
@Component
export struct ItemDetail {
  private exerciseList: Exercise[] = exerciseList
  @State workoutType: string = ''
  @StorageLink('selectedExerciseList') selectedExercise: Exercise[] = []

  build() {
    Column() {
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
}

