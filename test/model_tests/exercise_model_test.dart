import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:workout_tracker/models/exercise.dart';
import 'package:workout_tracker/scoped_models/exercises.dart';
import 'package:workout_tracker/services/exercise_service.dart';

/// This test will test all the functions of the exercise model.
/// The UI tests can then assume that the model functions all work and be
/// much more lightweight.
main() {
  group('ExerciseModel', () {
    ExercisesModel model;
    ExerciseService exerciseService;

    setUp(() {
      exerciseService = MockExerciseService();

      when(exerciseService.loadExercises()).thenAnswer((_) => Future.value([]));

      model = ExercisesModel(
        exerciseService: exerciseService,
      );
    });

    test('should set loading to false after loaded', () async {
      await model.loadExercises();

      expect(model.loading, false);
    });

    test('should add exercise', () async {
      final exercise1 = Exercise(name: 'Deadlift');
      final exercise2 = Exercise(name: 'Bench Press');
      final exercise3 = Exercise(name: 'Curls');
      final exercises = [
        exercise1,
        exercise2,
      ];

      when(exerciseService.loadExercises()).thenAnswer(
        (_) => Future.value(exercises),
      );

      await model.loadExercises();

      model.addExercise(exercise3);

      expect(model.exercises, [
        exercise1,
        exercise2,
        exercise3,
      ]);
    });

    test('should save exercises', () async {
      /// Note: we do not test the actual write to disc. That is tested under
      /// service tests.
      final exercise = Exercise(name: 'test');

      when(exerciseService.loadExercises()).thenAnswer((_) => Future.value([]));

      await model.loadExercises();

      model.addExercise(exercise);

      verify(exerciseService.saveExercises([exercise])).called(1);
    });
  });
}

class MockExerciseService extends Mock implements ExerciseService {}
