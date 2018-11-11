import 'package:flutter/material.dart';

import './workout_exercise.dart';

class Workout {
  final DateTime date;
  final List<WorkoutExercise> workoutExercises;

  Workout({
    @required this.date,
    this.workoutExercises,
  });
}
