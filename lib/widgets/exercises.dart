import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../scoped_models/main.dart';

class Exercises extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(builder: (
      BuildContext context,
      Widget child,
      MainModel model,
    ) {
      return Container(
        margin: EdgeInsets.only(bottom: 30.0),
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    padding: EdgeInsets.only(
                      top: 15.0,
                      left: 15.0,
                      right: 15.0,
                    ),
                    child: Text(model.exercises[index].name),
                  );
                },
                itemCount: model.exercises.length,
              ),
            ),
            RaisedButton(
              color: Theme.of(context).accentColor,
              textColor: Colors.white,
              child: Text('Add Excercise'),
              onPressed: () {
                Navigator.pushNamed(context, '/addExercise');
              },
            )
          ],
        ),
      );
    });
  }
}
