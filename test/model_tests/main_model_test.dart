import 'package:test/test.dart';
import 'package:mockito/mockito.dart';
import 'package:workout_tracker/models/exercise.dart';
import 'package:workout_tracker/scoped_models/main.dart';
import 'package:workout_tracker/services/exercise_service.dart';

/// This test will test all the functions of the model/state management.
/// The UI tests can then assume that the model functions all work and be
/// much more lightweight.
main() {
  group('MainModel', () {
    test('should set loading to false after loaded', () async {
      final model = MainModel(
        exerciseService: ExerciseServiceStub([]),
      );

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
      final model = MainModel(
        exerciseService: ExerciseServiceStub(exercises),
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
      final exerciseService = MockExerciseService();
      final model = MainModel(
        exerciseService: exerciseService,
      );
      final exercise = Exercise(name: 'test');

      model.addExercise(exercise);

      verify(exerciseService.saveExercises([exercise])).called(1);
    });
  });
}

/// A mock is created to test that certain functions such as load/save
/// are called when they should be.
class MockExerciseService extends Mock implements ExerciseServiceStub {}

/// The service is stubbed out so that we can load exercises and
/// properly test the adding of new exercises to the list.
class ExerciseServiceStub extends ExerciseService {
  List<Exercise> mockExercises;

  ExerciseServiceStub(this.mockExercises);

  @override
  Future<List<Exercise>> loadExercises() {
    return Future.value(mockExercises);
  }

  @override
  Future saveExercises(List<Exercise> exercises) {
    return Future.sync(() => mockExercises = exercises);
  }
}
