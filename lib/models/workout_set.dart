class WorkoutSet {
  final int reps;
  final int weight;

  WorkoutSet({
    required this.reps,
    required this.weight
  });

  Map<String, Object> toJson() {
    return {
      "reps": reps,
      "weight": weight,
    };
  }

  static WorkoutSet fromJson(Map<String, dynamic> json) {
    return WorkoutSet(
      reps: json['reps'] as int,
      weight: json['weight'] as int,
    );
  }
}