import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import './scoped_models/workouts.dart';
import './app.dart';
import './services/workout_service_flutter.dart';

void main() {
  var dir = getApplicationDocumentsDirectory;
  var workoutService = WorkoutServiceFlutter(dir);

  WorkoutsModel model = WorkoutsModel(
    workoutService: workoutService,
  );

  runApp(App(
    model: model,
  ));
}
