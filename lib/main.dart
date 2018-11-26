import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import './app.dart';
import './services/exercise_service_flutter.dart';
import './services/workout_service_flutter.dart';

void main() {
  var dir = getApplicationDocumentsDirectory;
  var exerciseService = ExerciseServiceFlutter(dir);
  var workoutService = WorkoutServiceFlutter(dir);

  runApp(App(
    exerciseService: exerciseService,
    workoutService: workoutService,
  ));
}
