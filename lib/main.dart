import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import './app.dart';
import './services/exercise_service_flutter.dart';

void main() {
  var exerciseService = ExerciseServiceFlutter(
    getApplicationDocumentsDirectory,
  );

  runApp(App(
    exerciseService: exerciseService,
  ));
}
