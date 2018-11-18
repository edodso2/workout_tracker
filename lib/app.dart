import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import './scoped_models/main.dart';
import './services/exercise_service.dart';
import './pages/home_page.dart';
import './pages/workouts_page.dart';
import './pages/add_exercise_page.dart';

class App extends StatelessWidget {
  final ExerciseService exerciseService;

  App({
    @required this.exerciseService,
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
      onGenerateRoute: _routeParamParser,
    );

    return ScopedModel<MainModel>(
      model: MainModel(
        exerciseService: exerciseService,
      ),
      child: app,
    );
  }

  Route<dynamic> _routeParamParser(RouteSettings settings) {
    final List<String> pathElements = settings.name.split('/');
    if (pathElements[0] != '') {
      return null;
    }
    if (pathElements[1] == 'workouts') {
      final int year = int.parse(pathElements[2]);
      final int month = int.parse(pathElements[3]);
      final int day = int.parse(pathElements[4]);

      return MaterialPageRoute<bool>(
        builder: (BuildContext context) => WorkoutsPage(year: year, month: month, day: day),
      );
    }
    return null;
  }
}
