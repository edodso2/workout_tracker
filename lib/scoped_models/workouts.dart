import 'package:scoped_model/scoped_model.dart';

import '../models/workout_set.dart';
import '../models/workout.dart';
import '../models/workout_exercise.dart';

mixin WorkoutsModel on Model {
  List<Workout> _workouts = [];

  List<Workout> get workouts {
    /// list.from creates a new instance so that
    /// the workouts array cannot be modified in
    /// memory by Widgets.
    return List.from(_workouts);
  }

  /// Returns the index of the workout on the specified date. -1 returned
  /// if workout does not exist on that date.
  int getWorkoutOnDate(DateTime date) {
    return _workouts.indexWhere((Workout workout) => workout.date == date);
  }

  /// Creates a blank workout for a specified date
  void createWorkout(DateTime date) {
    final workout = Workout(date: date, workoutExercises: []);
    _workouts.add(workout);
    notifyListeners();
  }

  /// Adds an already created workout to the list of workouts
  /// this method is helpful when loading workouts from a data
  /// source.
  void addWorkout(Workout workout) {
    _workouts.add(workout);
    notifyListeners();
  }

  /// Add an exercise to the workout at the specified index.
  void addWorkoutExercise(
    int index,
    WorkoutExercise workoutExercise,
  ) {
    _workouts[index].workoutExercises.add(workoutExercise);
    notifyListeners();
  }

  /// Add an exercise set to the workout at the specified index.
  void addWorkoutSet(
    int workoutIndex,
    int workoutExerciseIndex, {
    reps,
    weight,
  }) {
    final WorkoutSet workoutSet = WorkoutSet(
      reps: reps,
      weight: weight,
    );
    _workouts[workoutIndex]
        .workoutExercises[workoutExerciseIndex]
        .workoutSets
        .add(workoutSet);
    notifyListeners();
  }
}
