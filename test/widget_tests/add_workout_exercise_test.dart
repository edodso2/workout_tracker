import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:scoped_model/scoped_model.dart';

import 'package:workout_tracker/models/exercise.dart';
import 'package:workout_tracker/models/workout_exercise.dart';
import 'package:workout_tracker/scoped_models/exercises.dart';
import 'package:workout_tracker/scoped_models/workouts.dart';
import 'package:workout_tracker/widgets/add_workout_exercise.dart';

import '../_shared/test_utility.dart';
import '../model_tests/exercise_model_test.mocks.dart';
import '../model_tests/workouts_model_test.mocks.dart';

void main() {
  testWidgets(
    'Should call addWorkoutExercise when modal returns',
    (WidgetTester tester) async {
      MockWorkoutsModel mockWorkoutsModel = MockWorkoutsModel(workoutService: MockWorkoutService());
      MockExercisesModel mockExercisesModel = MockExercisesModel(exerciseService: MockExerciseService());
      Widget mockApp = ScopedModel<WorkoutsModel>(
        model: mockWorkoutsModel,
        child: MaterialApp(
          home: ScopedModel<ExercisesModel>(
            model: mockExercisesModel,
            child: const AddWorkoutExercise(
                1, MockExerciseListModal.showListModal),
          ),
        ),
      );
      WorkoutExercise workoutExercise =
          WorkoutExercise(name: 'Deadlift', workoutSets: []);

      await tester.pumpWidget(mockApp);

      Finder button = find.byKey(const Key('addExercisesButton'));
      await tester.tap(button);

      expect(mockWorkoutsModel.addWorkoutExerciseCalls.length, 1);
      expect(mockWorkoutsModel.addWorkoutExerciseCalls[0].name, workoutExercise.name); 
    },
  );
}

class MockExerciseListModal {
  static Future<Exercise> showListModal(
    BuildContext context,
    List<dynamic> items,
  ) {
    return Future.value(Exercise(name: 'Deadlift'));
  }
}
