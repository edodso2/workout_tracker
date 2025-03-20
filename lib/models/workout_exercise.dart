import './workout_set.dart';
import './exercise.dart';

class WorkoutExercise extends Exercise {
  final List<WorkoutSet> workoutSets;

  WorkoutExercise({
    required name,
    required this.workoutSets,
  }) : super(name: name);

  @override
  Map<String, Object> toJson() {
    final workoutSetsJson =
        workoutSets.map((workoutSet) => workoutSet.toJson()).toList();

    return {
      "name": name,
      "workoutSets": workoutSetsJson,
    };
  }

  static WorkoutExercise fromJson(Map<String, dynamic> json) {
    final workoutSet = (json['workoutSets'])
        .map<WorkoutSet>((workoutSet) => WorkoutSet.fromJson(workoutSet))
        .toList();

    return WorkoutExercise(
      name: json['name'] as String,
      workoutSets: workoutSet,
    );
  }
}
