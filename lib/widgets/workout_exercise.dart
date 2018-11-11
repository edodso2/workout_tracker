import 'package:flutter/material.dart';

class WorkoutExercise extends StatelessWidget {
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
              'Deadlift',
              textAlign: TextAlign.left,
            ),
            SizedBox(height: 10.0),
            Container(
              height: 30.0,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  Chip(
                    label: Text('5 x 225'),
                    backgroundColor: Theme.of(context).accentColor,
                    labelStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 12.0,
                    ),
                  ),
                  SizedBox(width: 8.0),
                  InkWell(
                    child: Icon(
                      Icons.add_circle,
                      color: Theme.of(context).accentColor,
                      size: 30.0,
                    ),
                    borderRadius: BorderRadius.circular(50.0),
                    onTap: () => {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
