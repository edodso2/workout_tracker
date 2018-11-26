import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:scoped_model/scoped_model.dart';

import 'package:workout_tracker/scoped_models/workouts.dart';
import 'package:workout_tracker/models/workout.dart';
import 'package:workout_tracker/models/workout_exercise.dart';
import 'package:workout_tracker/models/workout_set.dart';

/// Contains various utility functions that can be used
/// by all the tests in order to simplify the code in tests.

class MockMainModel extends Mock implements WorkoutsModel {}

class TestUtility {
  final WorkoutsModel model = MockMainModel();

  TestUtility();

  runMockApp(
    WidgetTester tester,
    Widget homeWidget,
  ) async {
    Widget mockApp = ScopedModel<WorkoutsModel>(
      model: model,
      child: MaterialApp(home: homeWidget),
    );

    await tester.pumpWidget(mockApp);
  }

  static WorkoutExercise createWorkoutExercise({bool hasSets = false, String name}) {
    WorkoutExercise workoutExercise;
    String exerciseName = name != null ? name : 'Deadlift';
    WorkoutSet workoutSet1 = WorkoutSet(reps: 10, weight: 135);
    List<WorkoutSet> workoutSets = [
      workoutSet1,
    ];

    if (hasSets) {
      workoutExercise = WorkoutExercise(
        name: exerciseName,
        workoutSets: workoutSets,
      );
    } else {
      workoutExercise = WorkoutExercise(
        name: exerciseName,
        workoutSets: [],
      );
    }

    return workoutExercise;
  }

  static Workout createWorkout({bool hasExercises = false, bool hasSets = false}) {
    Workout workout;
    DateTime date = DateTime(2018, 11, 10);
    List<WorkoutExercise> workoutExercises = [
      createWorkoutExercise(hasSets: hasSets),
    ];

    if (hasExercises) {
      workout = Workout(date: date, workoutExercises: workoutExercises);
    } else {
      workout = Workout(date: date, workoutExercises: []);
    }

    return workout;
  }
}
