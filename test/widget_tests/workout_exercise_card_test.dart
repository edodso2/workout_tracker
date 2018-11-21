import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:workout_tracker/models/workout_exercise.dart';
import 'package:workout_tracker/models/workout_set.dart';
import 'package:workout_tracker/scoped_models/main.dart';
import 'package:workout_tracker/widgets/workout_exercise_card.dart';

void main() {
  WorkoutSet workoutSet1 = WorkoutSet(reps: 10, weight: 135);
  List<WorkoutSet> workoutSets = [
    workoutSet1,
  ];

  WorkoutExercise workoutExerciseNoSets = WorkoutExercise(
    name: 'Deadlift',
    workoutSets: [],
  );
  WorkoutExercise workoutExerciseWithSets = WorkoutExercise(
    name: 'Deadlift',
    workoutSets: workoutSets,
  );

  testWidgets(
    'Should display workout name',
    (WidgetTester tester) async {
      await TestUtils.runMockApp(tester, workoutExerciseNoSets);

      Finder title = find.text('Deadlift');

      expect(title, findsOneWidget);
    },
  );

  testWidgets(
    'Should only display add button if no sets/reps for workout',
    (WidgetTester tester) async {
      await TestUtils.runMockApp(tester, workoutExerciseNoSets);

      Finder workoutSet0Widget = find.byKey(Key('workoutSet0'));
      Finder addWorkoutSetBtn = find.byKey(Key('addWorkoutSetBtn'));

      expect(workoutSet0Widget, findsNothing);
      expect(addWorkoutSetBtn, findsOneWidget);
    },
  );

  testWidgets(
    'Should display workout sets and reps',
    (WidgetTester tester) async {
      await TestUtils.runMockApp(tester, workoutExerciseWithSets);

      Finder workoutSet0Widget = find.byKey(Key('workoutSet0'));
      Finder addWorkoutSetBtn = find.byKey(Key('addWorkoutSetBtn'));

      expect(workoutSet0Widget, findsOneWidget);
      expect(addWorkoutSetBtn, findsOneWidget);
    },
  );

  testWidgets(
    'Should navigate to add sets/reps',
    (WidgetTester tester) async {
      // should this be a bottom sheet? if so then another widget & test is needed
    },
  );
}

class MockMainModel extends Mock implements MainModel {}

class TestUtils {
  static runMockApp(
    WidgetTester tester,
    WorkoutExercise workoutExercise,
  ) async {
    Widget mockApp = MaterialApp(home: WorkoutExerciseCard(workoutExercise));

    await tester.pumpWidget(mockApp);
  }
}
