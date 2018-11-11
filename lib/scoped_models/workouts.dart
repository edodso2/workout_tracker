import 'package:scoped_model/scoped_model.dart';

import '../models/workout.dart';
import '../models/workout_exercise.dart';

mixin WorkoutsModel on Model {
  List<Workout> _workouts = [];

  List<Workout> get workouts {
    // list.from creates a new instance so that
    // the workouts array cannot be modified in
    // memory by Widgets.
    return List.from(_workouts);
  }

  int getWorkoutOnDate(DateTime date) {
    return _workouts.indexWhere((Workout workout) => workout.date == date);
  }

  void addWorkout(Workout workout) {
    _workouts.add(workout);
    notifyListeners();
  }

  void addWorkoutExercise(
    int index,
    WorkoutExercise workoutExercise,
  ) {
    _workouts[index].workoutExercises.add(workoutExercise);
    notifyListeners();
  }
}
