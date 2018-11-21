import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import './counter.dart';
import '../models/workout_set.dart';
import '../scoped_models/main.dart';

class AddWorkoutSet extends StatefulWidget {
  final int workoutIndex;
  final int exerciseIndex;

  AddWorkoutSet(
    this.workoutIndex,
    this.exerciseIndex, {
    Key key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _AddWorkoutSetState();
  }
}

class _AddWorkoutSetState extends State<AddWorkoutSet> {
  int reps;
  int weight;

  @override
  void initState() {
    super.initState();
    reps = 5;
    weight = 135;
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(builder: (
      BuildContext context,
      Widget child,
      MainModel model,
    ) {
      return InkWell(
        key: Key('addWorkoutSetBtn'),
        child: Icon(
          Icons.add_circle,
          color: Theme.of(context).accentColor,
          size: 30.0,
        ),
        borderRadius: BorderRadius.circular(50.0),
        onTap: () {
          showModal(context).then((update) {
            if (update != null && update) {
              model.addWorkoutSet(
                widget.workoutIndex,
                widget.exerciseIndex,
                WorkoutSet(
                  reps: reps,
                  weight: weight,
                ),
              );
            }
          });
        },
      );
    });
  }

  Future<dynamic> showModal(
    BuildContext context,
  ) {
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Column(
          children: <Widget>[
            Counter(
              startingValue: 5,
              onChanged: (value) {
                setState(() {
                  reps = value;
                });
              },
            ),
            Counter(
              startingValue: 135,
              increment: 5,
              onChanged: (value) {
                setState(() {
                  weight = value;
                });
              },
            ),
            RaisedButton(
              child: Text('Add Set'),
              onPressed: () => Navigator.pop(context, true),
            )
          ],
        );
      },
    );
  }
}
