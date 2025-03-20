import './workout_exercise.dart';

class Workout {
  final DateTime date;
  final List<WorkoutExercise> workoutExercises;

  Workout({
    required this.date,
    required this.workoutExercises,
  });

  Map<String, Object> toJson() {
    final workoutExercisesJson = workoutExercises
        .map((workoutExercise) => workoutExercise.toJson())
        .toList();

    return {
      "date": date.toString(),
      "workoutExercises": workoutExercisesJson,
    };
  }

  static Workout fromJson(Map<String, dynamic> json) {
    final workoutExercises = (json['workoutExercises'])
        .map<WorkoutExercise>(
          (workoutExercise) => WorkoutExercise.fromJson(workoutExercise),
        )
        .toList();

    return Workout(
      date: DateTime.parse(json['date']),
      workoutExercises: workoutExercises,
    );
  }
}
