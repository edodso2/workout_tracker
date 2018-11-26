import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:path_provider/path_provider.dart';

import '../services/exercise_service.dart';
import '../services/exercise_service_flutter.dart';
import '../scoped_models/workouts.dart';
import '../scoped_models/exercises.dart';
import '../widgets/workout_calendar.dart';
import '../widgets/exercises.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  List<Widget> _widgetOptions;

  _HomePageState() {
    // Create the exercises model
    Function getDir = getApplicationDocumentsDirectory;
    ExerciseService exerciseService = ExerciseServiceFlutter(getDir);
    ExercisesModel exercisesModel = ExercisesModel(
      exerciseService: exerciseService,
    );

    // Set the tabs/options
    _widgetOptions = [
      Center(child: Text('Welcome')),
      ScopedModel<ExercisesModel>(
        model: exercisesModel,
        child: WorkoutCalendar(),
      ),
      ScopedModel<ExercisesModel>(
        model: exercisesModel,
        child: Exercises(),
      ),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget loadingView() {
    return Scaffold(
      appBar: AppBar(
        title: Text('Workout Tracker'),
      ),
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget homeView() {
    return Scaffold(
      appBar: AppBar(
        title: Text('Workout Tracker'),
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: buildBottomNavigationBar(),
    );
  }

  Widget buildBottomNavigationBar() {
    return BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          title: Text('Home'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_today),
          title: Text('Calendar'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.directions_bike),
          title: Text('Exercises'),
        ),
      ],
      currentIndex: _selectedIndex,
      fixedColor: Theme.of(context).primaryColor,
      onTap: (i) => _onItemTapped(i),
    );
  }

  @override
  Widget build(BuildContext context) {
    final workoutsModel = ScopedModel.of<WorkoutsModel>(context);

    if (workoutsModel.loading) {
      return loadingView();
    } else {
      return homeView();
    }
  }
}
