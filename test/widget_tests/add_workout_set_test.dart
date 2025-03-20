import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:mockito/mockito.dart';

import 'package:workout_tracker/models/workout.dart';
import 'package:workout_tracker/models/workout_exercise.dart';
import 'package:workout_tracker/scoped_models/workouts.dart';
import 'package:workout_tracker/widgets/add_workout_set.dart';

import '../_shared/test_utility.dart';
import '../model_tests/workouts_model_test.mocks.dart';

void main() {
  testWidgets(
    'Should add workout set with default counter values',
    (WidgetTester tester) async {
      MockWorkoutsModel mockWorkoutsModel = MockWorkoutsModel(workoutService: MockWorkoutService());
      Widget mockApp = ScopedModel<WorkoutsModel>(
        model: mockWorkoutsModel,
        child: const MaterialApp(
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
      mockWorkoutsModel.workouts = workouts;

      await tester.pumpWidget(mockApp);

      Finder addButton = find.byKey(const Key('addWorkoutSetBtn'));

      await tester.tap(addButton);

      await tester.pump(); // bottom sheet show animation starts
      await tester.pump(const Duration(seconds: 1)); // animation done

      Finder addSetButton = find.byKey(const Key('addSetButton'));

      expect(addSetButton, findsOneWidget);

      await tester.tap(addSetButton);

      await tester.pump(); // bottom sheet hide animation starts
      await tester.pump(const Duration(seconds: 1)); // animation done

      expect(addSetButton, findsNothing);

      expect(mockWorkoutsModel.addWorkoutSetCalls.length, 1); // Check number of calls
      expect(mockWorkoutsModel.addWorkoutSetCalls[0].reps, 5); 
    },
  );
}
