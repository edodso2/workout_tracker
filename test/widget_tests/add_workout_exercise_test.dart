import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:mockito/mockito.dart';

import 'package:workout_tracker/models/exercise.dart';
import 'package:workout_tracker/models/workout_exercise.dart';
import 'package:workout_tracker/scoped_models/exercises.dart';
import 'package:workout_tracker/scoped_models/workouts.dart';
import 'package:workout_tracker/widgets/add_workout_exercise.dart';

void main() {
  testWidgets(
    'Should call addWorkoutExercise when modal returns',
    (WidgetTester tester) async {
      WorkoutsModel workoutsModel = MockWorkoutsModel();
      ExercisesModel exercisesModel = MockExercisesModel();
      Widget mockApp = ScopedModel<WorkoutsModel>(
        model: workoutsModel,
        child: MaterialApp(
          home: ScopedModel<ExercisesModel>(
            model: exercisesModel,
            child: const AddWorkoutExercise(
                1, MockExerciseListModal.showListModal),
          ),
        ),
      );
      WorkoutExercise workoutExercise = WorkoutExercise(name: 'Deadlift');

      await tester.pumpWidget(mockApp);

      Finder button = find.byKey(const Key('addExercisesButton'));
      await tester.tap(button);

      verify(workoutsModel.addWorkoutExercise(1, workoutExercise)).called(1);
    },
  );
}

class MockWorkoutsModel extends Mock implements WorkoutsModel {}

class MockExercisesModel extends Mock implements ExercisesModel {}

class MockExerciseListModal {
  static Future<Exercise> showListModal(
    BuildContext context,
    List<dynamic> items,
  ) {
    return Future.value(Exercise(name: 'Deadlift'));
  }
}
