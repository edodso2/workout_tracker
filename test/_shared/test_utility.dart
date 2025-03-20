import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:workout_tracker/models/exercise.dart';
import 'package:workout_tracker/scoped_models/exercises.dart';

import 'package:workout_tracker/scoped_models/workouts.dart';
import 'package:workout_tracker/models/workout.dart';
import 'package:workout_tracker/models/workout_exercise.dart';
import 'package:workout_tracker/models/workout_set.dart';

import '../model_tests/workouts_model_test.mocks.dart';

/// Contains various utility functions that can be used
/// by all the tests in order to simplify the code in tests.

// Mockito seems to have trouble with scoped model so using
// manual. Will convert to Provider soon anyway.
class MockExercisesModel extends ExercisesModel {
  final addExerciseCalls = <Exercise>[];

  MockExercisesModel({required super.exerciseService});

  @override
  void addExercise(Exercise exercise) {
    addExerciseCalls.add(exercise);
    notifyListeners();
  }
}

class MockWorkoutsModel extends WorkoutsModel {
  @override
  var workouts = <Workout>[];
  int workoutsOnDate = -1;

  final createWorkoutCalls = <DateTime>[];
  final addWorkoutExerciseCalls = <Exercise>[];
  final addWorkoutSetCalls = <WorkoutSet>[];

  MockWorkoutsModel({required super.workoutService});

  @override
  int getWorkoutOnDate(DateTime date) {
    return workoutsOnDate;
  }

  @override
  createWorkout(DateTime date) {
    createWorkoutCalls.add(date);
    notifyListeners();
  }

  @override
  void addWorkoutExercise(
    int index,
    WorkoutExercise workoutExercise,
  ) {
    addWorkoutExerciseCalls.add(workoutExercise);
    notifyListeners();
  }

  @override
  void addWorkoutSet(
    int workoutIndex,
    int workoutExerciseIndex, {
    reps,
    weight,
  }) {
    addWorkoutSetCalls.add(WorkoutSet(
      reps: reps,
      weight: weight,
    ));
    notifyListeners();
  }
}

class TestUtility {
  final WorkoutsModel model =
      MockWorkoutsModel(workoutService: MockWorkoutService());

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

  static WorkoutExercise createWorkoutExercise(
      {bool hasSets = false, required String name}) {
    WorkoutExercise workoutExercise;
    String exerciseName = name;
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

  static Workout createWorkout(
      {bool hasExercises = false, bool hasSets = false}) {
    Workout workout;
    DateTime date = DateTime(2018, 11, 10);
    List<WorkoutExercise> workoutExercises = [
      createWorkoutExercise(hasSets: hasSets, name: 'Deadlift'),
    ];

    if (hasExercises) {
      workout = Workout(date: date, workoutExercises: workoutExercises);
    } else {
      workout = Workout(date: date, workoutExercises: []);
    }

    return workout;
  }
}
