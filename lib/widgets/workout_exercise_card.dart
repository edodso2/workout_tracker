import 'package:flutter/material.dart';

import '../widgets/add_workout_set.dart';
import '../models/workout_set.dart';
import '../models/workout_exercise.dart';

class WorkoutExerciseCard extends StatelessWidget {
  final int workoutIndex;
  final int exerciseIndex;
  final WorkoutExercise exercise;

  WorkoutExerciseCard(
    this.workoutIndex,
    this.exerciseIndex,
    this.exercise, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
      child: Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              exercise.name,
              textAlign: TextAlign.left,
            ),
            SizedBox(height: 10.0),
            Container(
              height: 30.0,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: _buildSetsList(context, exercise.workoutSets),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildSetsList(
    BuildContext context,
    List<WorkoutSet> workoutSets,
  ) {
    List<Widget> setsList = [];

    // create the array of chips to display the workout sets
    for (var i = 0; i < workoutSets.length; i++) {
      final WorkoutSet workoutSet = workoutSets[i];

      setsList.add(GestureDetector(
        key: Key('workoutSet$i'),
        onTap: () => {},
        child: Chip(
          label: Text('${workoutSet.reps} x ${workoutSet.weight}'),
          backgroundColor: Theme.of(context).accentColor,
          labelStyle: TextStyle(
            color: Colors.white,
            fontSize: 12.0,
          ),
        ),
      ));

      setsList.add(SizedBox(width: 8.0));
    }

    // add the plus icon for adding a new set
    setsList.add(AddWorkoutSet(
      workoutIndex,
      exerciseIndex,
      key: Key('addWorkoutSet'),
    ));

    return setsList;
  }
}
