import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:workout_tracker/models/workout_exercise.dart';
import 'package:workout_tracker/widgets/workout_exercise_card.dart';

import '../_shared/test_utility.dart';

void main() {
  // helper function for running the test app
  runMockApp(
    WidgetTester tester, {
    bool withWorkoutSets = false,
  }) async {
    WorkoutExercise workoutExercise = TestUtility.createWorkoutExercise(
      hasSets: withWorkoutSets,
    );
    WorkoutExerciseCard workoutExerciseCard = WorkoutExerciseCard(
      0,
      0,
      workoutExercise,
    );

    TestUtility testUtility = TestUtility();

    await testUtility.runMockApp(tester, workoutExerciseCard);
  }

  testWidgets(
    'Should display workout name',
    (WidgetTester tester) async {
      await runMockApp(tester, withWorkoutSets: false);

      Finder title = find.text('Deadlift');

      expect(title, findsOneWidget);
    },
  );

  testWidgets(
    'Should only display add button if no sets/reps for workout',
    (WidgetTester tester) async {
      await runMockApp(tester, withWorkoutSets: false);

      Finder workoutSet0Widget = find.byKey(const Key('workoutSet0'));
      Finder addWorkoutSetBtn = find.byKey(const Key('addWorkoutSet'));

      expect(workoutSet0Widget, findsNothing);
      expect(addWorkoutSetBtn, findsOneWidget);
    },
  );

  testWidgets(
    'Should display workout sets and reps',
    (WidgetTester tester) async {
      await runMockApp(tester, withWorkoutSets: true);

      Finder workoutSet0Widget = find.byKey(const Key('workoutSet0'));
      Finder addWorkoutSetBtn = find.byKey(const Key('addWorkoutSet'));

      expect(workoutSet0Widget, findsOneWidget);
      expect(addWorkoutSetBtn, findsOneWidget);
    },
  );
}
