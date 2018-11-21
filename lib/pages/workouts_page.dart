import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../widgets/exercise_list_modal.dart';
import '../widgets/add_workout_exercise.dart';
import '../models/workout.dart';
import '../scoped_models/main.dart';
import '../models/workout_exercise.dart';
import '../widgets/workout_exercise_card.dart';

/// This page will show the workout for a specified date.
/// Depending on the date there are some rules:
/// Past date: workout cannot be edited in any way
/// Current date: workout exercises can be added and sets/reps can be added
/// Future date: workout exercises can be added but sets/reps can not be added
/// If there is no workout for the specified date then the page will display
/// the option to create a new workout.
class WorkoutsPage extends StatelessWidget {
  final int year;
  final int month;
  final int day;

  WorkoutsPage({
    this.year,
    this.month,
    this.day,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Workouts'),
      ),
      body: ScopedModelDescendant<MainModel>(
        builder: (
          BuildContext context,
          Widget child,
          MainModel model,
        ) {
          final date = DateTime(year, month, day);
          int index = model.getWorkoutOnDate(date);

          return Container(
            margin: EdgeInsets.only(bottom: 30.0),
            child: index >= 0
                ? buildWorkoutList(
                    context,
                    model.workouts[index],
                    index,
                  )
                : buildNoWorkouts(context, model, date),
          );
        },
      ),
    );
  }

  /// Workout found scenario widgets
  Widget buildWorkoutList(
    BuildContext context,
    Workout workout,
    int index,
  ) {
    return Column(
      children: <Widget>[
        Expanded(
          child: workout.workoutExercises.length > 0
              ? buildExerciseList(index, workout.workoutExercises)
              : Text(
                  'No exercises.',
                  key: Key('noExercisesMessage'),
                ),
        ),
        AddWorkoutExercise(
          index,
          ExerciseListModal.showListModal,
          key: Key('addWorkoutExerciseWidget'),
        ),
      ],
    );
  }

  Widget buildExerciseList(int workoutIndex, List<WorkoutExercise> exercises) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return WorkoutExerciseCard(workoutIndex, index, exercises[index]);
      },
      itemCount: exercises.length,
    );
  }

  /// Workout not found scenario widgets
  Widget buildNoWorkouts(BuildContext context, MainModel model, DateTime date) {
    return Column(
      children: <Widget>[
        Expanded(
          child: Text(
            'No workout for this date.',
            key: Key('noWorkoutMessage'),
          ),
        ),
        RaisedButton(
          key: Key('createButton'),
          color: Theme.of(context).accentColor,
          textColor: Colors.white,
          child: Text('Create Workout'),
          onPressed: () {
            model.createWorkout(date);
          },
        ),
      ],
    );
  }
}
