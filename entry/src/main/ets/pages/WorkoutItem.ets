import { ItemDetail } from './ItemDetail';
import { Workout } from './Workout';

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
    name: 'Triceps Pushdown - Rope Attachment',
    target_muscle: ["Triceps"]
  },
  {
    name: 'Standing Dumbbell Triceps Extension',
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
    name: 'Dumbbell One-Arm Triceps Extension',
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
    name: 'Seated Back Extension Machine',
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
  @State workoutList: string[] = typeList
  pathStack: NavPathStack = new NavPathStack()

  @Builder
  PagesMap(name: string) {
    if (name == 'ItemDetail') {
      ItemDetail()
    } else if (name == 'Workout') {
      Workout()
    }
  }

  build() {
    Navigation(this.pathStack) {
      Grid() {
        ForEach(this.workoutList, (item: string, index: number) => {
          if (item == 'Cardio') {
            GridItem() {
              Text(item)
            }
            .borderWidth(1)
            .columnStart(1)
            .columnEnd(4)
          }
          else {
            GridItem() {
              Text(item)
            }
            .borderWidth(1)
            .onClick(() => {
              let tmp: string = item
              this.pathStack.pushPathByName('ItemDetail', tmp)
            })
          }
        })
      }
      .rowsTemplate('1fr 1fr 1fr 1fr 1fr')
      .columnsTemplate('1fr 1fr 1fr 1fr')
    }
    .mode(NavigationMode.Stack)
    .titleMode(NavigationTitleMode.Mini)
    .title('Workout List')
    .navDestination(this.PagesMap)
    .hideBackButton(true)
  }
}

