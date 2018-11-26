import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import './pages/workouts_page.dart';
import './router_param_parser.dart';
import './scoped_models/workouts.dart';
import './pages/home_page.dart';
import './pages/add_exercise_page.dart';

class App extends StatelessWidget {
  final WorkoutsModel model;

  App({
    @required this.model,
  });

  @override
  Widget build(BuildContext context) {
    final app = MaterialApp(
      title: 'Workout Tracker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        accentColor: Colors.red,
      ),
      routes: {
        '/': (BuildContext context) => HomePage(),
        '/addExercise': (BuildContext context) => AddExercisePage(),
      },
      onGenerateRoute: _parseRouteParams,
    );

    return ScopedModel<WorkoutsModel>(
      model: model,
      child: app,
    );
  }

  Route<dynamic> _parseRouteParams(RouteSettings settings) {
    String workoutsPageRouteName = 'workouts';
    RouterParamParser parser = RouterParamParser([
      workoutsPageRouteName,
    ]);
    ParsedRoute route = parser.parse(settings);

    if (route == null) return null;
  
    if (route.name == workoutsPageRouteName) {
      final int year = int.parse(route.params[0]);
      final int month = int.parse(route.params[1]);
      final int day = int.parse(route.params[2]);

      return MaterialPageRoute<bool>(
        builder: (BuildContext context) =>
            WorkoutsPage(year: year, month: month, day: day),
      );
    }

    return null;
  }
}
