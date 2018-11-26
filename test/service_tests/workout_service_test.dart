import 'dart:io';

import 'package:test_api/test_api.dart';
import 'package:workout_tracker/models/workout.dart';
import 'package:workout_tracker/services/workout_service_flutter.dart';

import '../_shared/TestUtility.dart';

main() {
  group('WorkoutService', () {
    final List<Workout> workouts = [
      TestUtility.createWorkout(hasExercises: true, hasSets: true),
    ];
    final directory = Directory.systemTemp.createTemp('__storage_test__');
    final storage = WorkoutServiceFlutter(
      () => directory,
    );

    tearDownAll(() async {
      final tempDirectory = await directory;

      tempDirectory.deleteSync(recursive: true);
    });

    test('Should persist Workouts to disk', () async {
      final file = await storage.saveWorkouts(workouts);

      expect(file.existsSync(), isTrue);
    });

    test('Should load Workouts from disk', () async {
      final loadedWorkouts = await storage.loadWorkouts();

      expect(loadedWorkouts[0].date, workouts[0].date);
      expect(
        loadedWorkouts[0].workoutExercises[0].name,
        workouts[0].workoutExercises[0].name,
      );
      expect(
        loadedWorkouts[0].workoutExercises[0].workoutSets[0].reps,
        workouts[0].workoutExercises[0].workoutSets[0].reps,
      );
    });
  });
}
