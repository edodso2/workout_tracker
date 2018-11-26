import '../models/workout.dart';

abstract class WorkoutService {
  Future<List<Workout>> loadWorkouts();

  Future saveWorkouts(List<Workout> workouts);
}