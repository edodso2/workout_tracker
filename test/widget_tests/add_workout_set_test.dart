import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:mockito/mockito.dart';

import 'package:workout_tracker/models/workout.dart';
import 'package:workout_tracker/models/workout_exercise.dart';
import 'package:workout_tracker/models/workout_set.dart';
import 'package:workout_tracker/scoped_models/main.dart';
import 'package:workout_tracker/widgets/add_workout_set.dart';

void main() {
  testWidgets(
    'Should add workout set with default counter values',
    (WidgetTester tester) async {
      MainModel model = MockMainModel();
      Widget mockApp = ScopedModel<MainModel>(
        model: model,
        child: MaterialApp(
          home: Scaffold(body: AddWorkoutSet(0, 0)),
        ),
      );
      List<WorkoutExercise> workoutExercises = [
        WorkoutExercise(name: 'Deadlift', workoutSets: []),
        WorkoutExercise(name: 'Bench Press', workoutSets: []),
      ];
      List<Workout> workouts = [
        Workout(date: DateTime.now(), workoutExercises: workoutExercises),
      ];
      when(model.workouts).thenReturn(workouts);

      await tester.pumpWidget(mockApp);

      Finder addButton = find.byKey(Key('addWorkoutSetBtn'));

      await tester.tap(addButton);

      await tester.pump(); // bottom sheet show animation starts
      await tester.pump(const Duration(seconds: 1)); // animation done

      Finder addSetButton = find.byKey(Key('addSetButton'));

      expect(addSetButton, findsOneWidget);

      await tester.tap(addSetButton);

      await tester.pump(); // bottom sheet hide animation starts
      await tester.pump(const Duration(seconds: 1)); // animation done

      expect(addSetButton, findsNothing);

      verify(model.addWorkoutSet(
        0,
        0,
        reps: 5,
        weight: 135,
      )).called(1);
    },
  );
}

class MockMainModel extends Mock implements MainModel {}
