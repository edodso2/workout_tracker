import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:workout_tracker/models/exercise.dart';
import 'package:workout_tracker/scoped_models/exercises.dart';
import 'package:workout_tracker/services/exercise_service.dart';

@GenerateNiceMocks([MockSpec<ExerciseService>()])
import 'exercise_model_test.mocks.dart';

/// This test will test all the functions of the exercise model.
/// The UI tests can then assume that the model functions all work and be
/// much more lightweight.
void main() {
  group('ExerciseModel', () {
    late ExercisesModel model;
    late ExerciseService mockExerciseService;

    final exercise = Exercise(name: 'test');

    setUp(() {
      mockExerciseService = MockExerciseService();

      // Setup the mock to return an empty list for loadExercises
      when(mockExerciseService.loadExercises())
          .thenAnswer((_) async => <Exercise>[]);

      // Setup the mock to complete successfully for saveExercises
      when(mockExerciseService.saveExercises([exercise]))
          .thenAnswer((_) async => null);

      model = ExercisesModel(exerciseService: mockExerciseService);
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

      when(mockExerciseService.loadExercises()).thenAnswer(
        (_) async => exercises,
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
      when(mockExerciseService.loadExercises())
          .thenAnswer((_) async => []);

      await model.loadExercises();

      model.addExercise(exercise);

      verify(mockExerciseService.saveExercises([exercise])).called(1);
    });
  });
}
