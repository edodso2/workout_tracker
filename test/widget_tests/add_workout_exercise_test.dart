import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:mockito/mockito.dart';

import 'package:workout_tracker/models/exercise.dart';
import 'package:workout_tracker/models/workout_exercise.dart';
import 'package:workout_tracker/scoped_models/main.dart';
import 'package:workout_tracker/widgets/add_workout_exercise.dart';

void main() {
  testWidgets(
    'Should call addWorkoutExercise when modal returns',
    (WidgetTester tester) async {
      MainModel model = MockMainModel();
      Widget mockApp = ScopedModel<MainModel>(
        model: model,
        child: MaterialApp(
          home: AddWorkoutExercise(1, MockExerciseListModal.showListModal),
        ),
      );
      WorkoutExercise workoutExercise = WorkoutExercise(name: 'Deadlift');

      await tester.pumpWidget(mockApp);

      Finder button = find.byKey(Key('addExercisesButton'));
      await tester.tap(button);

      verify(model.addWorkoutExercise(1, workoutExercise)).called(1);
    },
  );
}

class MockMainModel extends Mock implements MainModel {}

class MockExerciseListModal {
  static Future<Exercise> showListModal(
    BuildContext context,
    List<dynamic> items,
  ) {
    return Future.value(Exercise(name: 'Deadlift'));
  }
}
