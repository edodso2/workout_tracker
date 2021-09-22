import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import './app.dart';
import './scoped_models/workouts.dart';
import './scoped_models/exercises.dart';
import './services/workout_service_flutter.dart';
import './services/exercise_service_flutter.dart';

void main() {
  var getDir = getApplicationDocumentsDirectory;
  var workoutService = WorkoutServiceFlutter(getDir);
  var exercisesService = ExerciseServiceFlutter(getDir);

  WorkoutsModel workoutsModel = WorkoutsModel(
    workoutService: workoutService,
  );

  ExercisesModel exerciseModel = ExercisesModel(
    exerciseService: exercisesService,
  );

  runApp(App(
    workoutsModel: workoutsModel,
    exercisesModel: exerciseModel,
  ));
}
