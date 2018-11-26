import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:workout_tracker/services/workout_service.dart';

import '../services/exercise_service.dart';
import '../models/exercise.dart';
import './workouts.dart';

// TODO: can the exercise model code be moved to seperate Class or file?
class MainModel extends Model with WorkoutsModel {
  final ExerciseService exerciseService;
  final WorkoutService workoutService;

  List<Exercise> _exercises = [];

  bool loading = false;

  List<Exercise> get exercises {
    // list.from creates a new instance so that
    // the exercises array cannot be modified in
    // memory by Widgets.
    return List.from(_exercises);
  }

  MainModel({@required this.exerciseService, @required this.workoutService});

  @override
  void addListener(listener) {
    super.addListener(listener);
    loading = true;
    loadExercises();
  }

  loadExercises() {
    exerciseService
        .loadExercises()
        .then((exercises) => _exercises = exercises)
        .catchError((_) => _exercises = [])
        .whenComplete(() {
          loading = false;
          notifyListeners();
        });
  }

  void addExercise(
    Exercise exercise
  ) {
    _exercises.add(exercise);
    exerciseService.saveExercises(_exercises);
    notifyListeners();
  }
}
