import 'package:test/test.dart';
import 'package:mockito/mockito.dart';

import 'package:workout_tracker/models/workout.dart';
import 'package:workout_tracker/models/workout_exercise.dart';
import 'package:workout_tracker/models/workout_set.dart';
import 'package:workout_tracker/scoped_models/main.dart';
import 'package:workout_tracker/services/exercise_service.dart';

/// This test will test all the functions of the model/state management.
/// The UI tests can then assume that the model functions all work and be
/// much more lightweight.
main() {
  group('WorkoutModel', () {
    test('should get workout index from date', () async {
      final model = MainModel(
        exerciseService: MockExerciseService(),
      );

      final date1 = DateTime(2018, 11, 10); // nov 10, 2018
      final date2 = DateTime(2018, 10, 9); // oct 9, 2018
      final workoutExercises1 = [WorkoutExercise(name: 'Deadlift', workoutSets: [])];
      final workoutExercises2 = [WorkoutExercise(name: 'Deadlift', workoutSets: [WorkoutSet(reps: 10, weight: 135)])];
      final workout1 = Workout(date: date1, workoutExercises: workoutExercises1);
      final workout2 = Workout(date: date2, workoutExercises: workoutExercises2);

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
