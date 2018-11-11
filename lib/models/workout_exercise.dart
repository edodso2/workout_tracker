import 'package:flutter/material.dart';

import './workout_set.dart';
import './exercise.dart';

class WorkoutExercise extends Exercise {
  final List<WorkoutSet> workoutSets;

  WorkoutExercise({
    @required name,
    this.workoutSets,
  }) : super(name: name);
}
