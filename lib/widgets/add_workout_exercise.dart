import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../scoped_models/exercises.dart';
import '../scoped_models/workouts.dart';
import '../models/workout_exercise.dart';
import '../models/exercise.dart';

/// The purpose of this widget is to encapsulate all of the neceassary logic
/// needed to add a workout exercise to a workout. To do this the widget
/// will make use of the ScopedModel. The only object his widget needs to
/// complete its job is the index of the workout the exercise should be added to.
///
/// NOTE: main reason for making this a seperate component was because the
/// workouts_page widget was getting cluttered with all the scenarios it has
/// and the widget test file was getting large.

class AddWorkoutExercise extends StatelessWidget {
  final int index;
  final Function showModal;

  const AddWorkoutExercise(
    this.index,
    this.showModal, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    WorkoutsModel workoutsModel = ScopedModel.of<WorkoutsModel>(context);
    ExercisesModel exercisesModel = ScopedModel.of<ExercisesModel>(context);

    return ElevatedButton(
      key: const Key('addExercisesButton'),
      child: const Text('Add Excercise'),
      onPressed: () {
        showModal(
          context,
          exercisesModel.exercises,
        ).then((Exercise? exercise) {
          if (exercise != null) {
            workoutsModel.addWorkoutExercise(
              index,
              WorkoutExercise(name: exercise.name, workoutSets: []),
            );
          }
        });
      },
    );
  }
}
