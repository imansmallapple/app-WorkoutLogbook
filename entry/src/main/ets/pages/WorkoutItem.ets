import { ItemDetail } from './ItemDetail';
import { Workout } from './Workout';
import router from '@ohos.router';

export interface Exercise {
  name: string;
  target_muscle: string[];
}

const typeList: string[] = [
  'Shoulder',
  'Check',
  'Biceps',
  'Obliques',
  'Abductors',
  'Quads',
  'Abdomen',
  'Forearm',
  'Adductors',
  'Triceps',
  'Lower back',
  'Hamstrings',
  'Calves',
  'Traps',
  'Lats',
  'Glutes',
  'Cardio'
];

export const exerciseList: Exercise[] = [
  {
    name: 'Triceps Pushdown',
    target_muscle: ["Triceps"]
  },
  {
    name: 'Triceps Pushdown \n- Rope Attachment',
    target_muscle: ["Triceps"]
  },
  {
    name: 'Standing Dumbbell\nTriceps Extension',
    target_muscle: ["Triceps"]
  },
  {
    name: 'Skullcrusher',
    target_muscle: ["Triceps"]
  },
  {
    name: 'Cable Rope Overhead',
    target_muscle: ["Triceps"]
  },
  {
    name: 'Weighted Bench Dip',
    target_muscle: ["Triceps"]
  },
  {
    name: 'Dumbbell One-Arm\n Triceps Extension',
    target_muscle: ["Triceps"]
  },
  {
    name: 'Reverse Grip Triceps Pushdown',
    target_muscle: ["Triceps"]
  },
  {
    name: 'Dip Machine',
    target_muscle: ["Triceps"]
  },
  {
    name: 'Triceps Pushdown',
    target_muscle: ["Triceps"]
  },
  {
    name: 'Seated Triceps Press',
    target_muscle: ["Triceps"]
  },
  {
    name: 'Plank',
    target_muscle: ["Abdomen", "Obliques", "Lower back"]
  },
  {
    name: 'Dombbell Sumo Deadlift',
    target_muscle: ["Quads", "Lats", "Lower back", "Glutes", "Hamstrings", "Forearm", "Traps"]
  },
  {
    name: 'Barbell Deadlift',
    target_muscle: ["Quades", "Lats", "Lower back", "Glutes", "Hamstrings", "Forearm", "Traps"]
  },
  {
    name: 'Hyperextensions(Back Extensions)',
    target_muscle: ["Abdomen", "Lower back"]
  },
  {
    name: 'Barbell Sumo Deadlifts',
    target_muscle: ["Quads", "Lats", "Lower back", "Glutes", "Hamstrings", "Forearm", "Traps"]
  },
  {
    name: 'Plank Standing Leg',
    target_muscle: ["Abdomen", "Lower back", "Quads"]
  },
  {
    name: 'Ab wheel rollout',
    target_muscle: ["Abdomen", "Obliques", "Lower back"]
  },
  {
    name: 'Good Morning',
    target_muscle: ["Lower back", "Glutes", "Hamstrings"]
  },
  {
    name: 'Superman',
    target_muscle: ["Abdomen", "Lower back"]
  },
  {
    name: 'Seated Back\nExtension Machine',
    target_muscle: ["Abdomen", "Lower back"]
  },
  {
    name: 'Single Leg Deadlift',
    target_muscle: ["Quads", "Lats", "Lower back", "Glutes", "Hamstrings", "Forearm", "Traps"]
  },
  {
    name: 'Flutter Kicks',
    target_muscle: ["Abdomen", "Lower back"]
  },
  {
    name: 'Weighted Ball Hyperextension',
    target_muscle: ["Abdomen", "Lower back"]
  },
  {
    name: 'Cable Deadlifts',
    target_muscle: ["Quads", "Lats", "Lower back", "Glutes", "Hamstrings"]
  }
]

@Entry
@Component
export struct WorkoutItem {
  private searchController: SearchController = new SearchController()
  @State exerciseList: Exercise[] = exerciseList
  pathStack: NavPathStack = new NavPathStack()
  @State changeValue: string = ''
  @State isFiltered: boolean = false
  @State filteredExercise: Exercise[] = []
  @State isShouldFocus: boolean = false

  @Builder
  PagesMap(name: string) {
    if (name == 'ItemDetail') {
      ItemDetail()
    } else if (name == 'Workout') {
      Workout()
    }
  }

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

        Search({
          value: this.changeValue,
          placeholder: 'Search training type',
          controller: this.searchController,
        })
          .borderStyle(BorderStyle.Solid)
          .borderWidth(1)
          .borderRadius(10)
          .borderColor('#41000000')
          .margin({left: 10})
          .searchIcon({
            src: $r('app.media.search_icon'),
          })
          .focusable(true)
          .width("80%")
          .height(40)
          .backgroundColor("#F5F5F5")
          .placeholderColor(Color.Grey)
          .placeholderFont({ size: 14, weight: 400 })
          .textFont({ size: 14, weight: 400 })
          .onChange((value: string) => {
            this.changeValue = value
            if (value == '') {
              this.isFiltered = false
            }
            this.isFiltered = true
            const filteredExercise = this.exerciseList.filter((exercise: Exercise) => {
              return exercise.name.toLowerCase().includes(value.toLowerCase())
            });
            this.filteredExercise = filteredExercise
          })
          .onTouch(() => {
            this.isShouldFocus = true
          })
          .focusable(this.isShouldFocus)
      }
      .layoutWeight(1)
      .justifyContent(FlexAlign.Start)
    }
    .width('100%')
    .height('10%')
    .backgroundColor('#00ffffff')
    .shadow({
      radius:5,
      offsetY: 8,
      color: '#1b000000'
    })
  }

  build() {
    Column() {

      this.NavigationComponent()


      // Grid() {
      //   ForEach(this.workoutList, (item: string, index: number) => {
      //     if (item == 'Cardio') {
      //       GridItem() {
      //         Text(item)
      //       }
      //       .borderWidth(1)
      //       .columnStart(1)
      //       .columnEnd(4)
      //     }
      //     else {
      //       GridItem() {
      //         Text(item)
      //       }
      //       .borderWidth(1)
      //       .onClick(() => {
      //         let tmp: string = item
      //         this.pathStack.pushPathByName('ItemDetail', tmp)
      //       })
      //     }
      //   })
      // }
      // .rowsTemplate('1fr 1fr 1fr 1fr 1fr')
      // .columnsTemplate('1fr 1fr 1fr 1fr')
      List() {
        ForEach(this.exerciseList, (item: Exercise, index: number) => {
          ListItem() {
            Column() {
              Row() {
                Text(`${item.name}`)
                  .fontSize(20)
                  .margin({ left: 25 })
                  .layoutWeight(1)
                Image($r('app.media.add_icon'))
                  .width(30)
                  .margin({ right: 40 })
              }
              .justifyContent(FlexAlign.End)
              .width('95%')
              .height(100)
              .borderRadius(20)
              .margin(10)
              .shadow({
                radius: 10,
                color: '#ff7dc87d',
                offsetY: 10
              })
            }
          }
        })
      }
    }
  }
}

