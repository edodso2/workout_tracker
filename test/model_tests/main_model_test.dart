import 'package:test_api/test_api.dart';
import 'package:mockito/mockito.dart';
import 'package:workout_tracker/models/exercise.dart';
import 'package:workout_tracker/scoped_models/main.dart';
import 'package:workout_tracker/services/exercise_service.dart';
import 'package:workout_tracker/services/workout_service.dart';

/// This test will test all the functions of the model/state management.
/// The UI tests can then assume that the model functions all work and be
/// much more lightweight.
main() {
  group('MainModel', () {
    MainModel model;
    ExerciseService exerciseService;
    WorkoutService workoutService;

    setUp(() {
      exerciseService = MockExerciseService();
      workoutService = MockWorkoutService();

      when(exerciseService.loadExercises()).thenAnswer((_) => Future.value([]));

      model = MainModel(
        exerciseService: exerciseService,
        workoutService: workoutService,
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

class MockWorkoutService extends Mock implements WorkoutService {}
