import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:workout_tracker/models/exercise.dart';
import 'package:workout_tracker/services/exercise_service_flutter.dart';

main() {
  group('ExerciseService', () {
    final exercises = [Exercise(name: 'Deadlift')];
    final directory = Directory.systemTemp.createTemp('__storage_test__');
    final storage = ExerciseServiceFlutter(
      () => directory,
    );

    tearDownAll(() async {
      final tempDirectory = await directory;

      tempDirectory.deleteSync(recursive: true);
    });

    test('Should persist Exercises to disk', () async {
      final file = await storage.saveExercises(exercises);

      expect(file.existsSync(), isTrue);
    });

    test('Should load Exercises from disk', () async {
      final loadedExercises = await storage.loadExercises();

      expect(loadedExercises[0].name, exercises[0].name);
    });
  });
}
