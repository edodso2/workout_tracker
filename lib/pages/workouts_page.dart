import 'package:flutter/material.dart';

import '../widgets/workout_exercise.dart';

/// This page will show the workout for a specified date.
/// Depending on the date there are some rules:
/// Past date: workout cannot be edited in any way
/// Current date: workout exercises can be added and sets/reps can be added
/// Future date: workout exercises can be added but sets/reps can not be added
class WorkoutsPage extends StatelessWidget {
  /// the index of the workout in the workouts model/state
  /// array. Should be -1 if no worktout.
  final int index;

  WorkoutsPage(
    this.index,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Workouts'),
      ),
      body: Container(
        margin: EdgeInsets.only(bottom: 30.0),
        child: Column(
          children: <Widget>[
            Expanded(
              child: index >= 0 ? buildWorkoutList() : buildNoWorkouts(),
            ),
            RaisedButton(
              color: Theme.of(context).accentColor,
              textColor: Colors.white,
              child: Text('Add Excercise'),
              onPressed: () => {},
            )
          ],
        ),
      ),
    );
  }

  Widget buildWorkoutList() {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return WorkoutExercise();
      },
      itemCount: 3,
    );
  }

  Widget buildNoWorkouts() {
    return Center(
      child: Text('No exercises found.'),
    );
  }
}
