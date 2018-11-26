import 'package:test_api/test_api.dart';
import 'package:mockito/mockito.dart';

import 'package:workout_tracker/models/workout.dart';
import 'package:workout_tracker/models/workout_exercise.dart';
import 'package:workout_tracker/models/workout_set.dart';
import 'package:workout_tracker/scoped_models/main.dart';
import 'package:workout_tracker/services/exercise_service.dart';
import 'package:workout_tracker/services/workout_service.dart';

/// This test will test all the functions of the model/state management.
/// The UI tests can then assume that the model functions all work and be
/// much more lightweight.
///
/// NOTE: alot of the tests below depend on the 'getWorkoutOnDate' function
/// to ensure the workout was added. Although its not that good for keeping
/// the tests specific and single purpose it does keep them from repeating
/// logic that is already implemented in the model...
main() {
  group('WorkoutModel', () {
    MainModel model;
    ExerciseService exerciseService;
    DateTime date;

    setUp(() {
      date = DateTime(2018, 11, 10); // nov 10, 2018
      exerciseService = MockExerciseService();
      
      when(exerciseService.loadExercises()).thenAnswer((_) => Future.value([]));

      model = MainModel(
        exerciseService: exerciseService,
        workoutService: MockWorkoutService(),
      );
    });

    test('should create blank workout', () async {
      model.createWorkout(date);

      expect(model.getWorkoutOnDate(date), isNot(-1));
    });

    test('getWorkoutOnDate should return -1 when workout not found', () async {
      expect(model.getWorkoutOnDate(date), -1);
    });

    test('should add workouts', () async {
      // create the workout dates
      final date1 = DateTime(2018, 11, 10); // nov 10, 2018
      final date2 = DateTime(2018, 10, 9); // oct 9, 2018

      // create exercises for workout
      final workoutExercises1 = [
        WorkoutExercise(name: 'Deadlift', workoutSets: []),
      ];
      final workoutExercises2 = [
        WorkoutExercise(
          name: 'Deadlift',
          workoutSets: [WorkoutSet(reps: 10, weight: 135)],
        )
      ];

      // create workouts
      final workout1 = Workout(
        date: date1,
        workoutExercises: workoutExercises1,
      );
      final workout2 = Workout(
        date: date2,
        workoutExercises: workoutExercises2,
      );

      model.addWorkout(workout1);
      model.addWorkout(workout2);

      final workout1Index = model.getWorkoutOnDate(date1);
      final workout2Index = model.getWorkoutOnDate(date2);

      expect(model.workouts[workout1Index], workout1);
      expect(model.workouts[workout2Index], workout2);
    });
  });
}

class MockExerciseService extends Mock implements ExerciseService {}
class MockWorkoutService extends Mock implements WorkoutService {}
