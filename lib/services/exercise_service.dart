import 'dart:async';
import 'dart:core';

import '../models/exercise.dart';

/// A class that Loads and Persists exercises. The data layer of the app.
///
/// How and where it stores the entities should defined in a concrete
/// implementation, such as exercise_service_flutter or exercise_service_web.
///
/// The domain layer should depend on this abstract class, and each app can
/// inject the correct implementation depending on the environment, such as
/// web or Flutter.
abstract class ExerciseService {
  /// Loads exercises first from File storage
  Future<List<Exercise>> loadExercises();

  // Persists exercises to local disk
  Future saveExercises(List<Exercise> todos);
}