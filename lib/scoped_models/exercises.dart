import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../services/exercise_service.dart';
import '../models/exercise.dart';

class ExercisesModel extends Model {
  ExerciseService exerciseService;
  List<Exercise> _exercises = [];
  bool loading = false;

  List<Exercise> get exercises {
    // list.from creates a new instance so that
    // the exercises array cannot be modified in
    // memory by Widgets.
    return List.from(_exercises);
  }

  ExercisesModel({@required this.exerciseService});

  // @override
  // void addListener(listener) {
  //   super.addListener(listener);
  //   loadExercises();
  // }

  loadExercises() {
    loading = true;
    exerciseService
        .loadExercises()
        .then((exercises) => _exercises = exercises)
        .catchError((_) => _exercises = [])
        .whenComplete(() {
      loading = false;
      notifyListeners();
    });
  }

  void addExercise(Exercise exercise) {
    _exercises.add(exercise);
    exerciseService.saveExercises(_exercises);
    notifyListeners();
  }
}
