import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:mockito/mockito.dart';

import 'package:workout_tracker/models/workout.dart';
import 'package:workout_tracker/models/workout_exercise.dart';
import 'package:workout_tracker/router_param_parser.dart';
import 'package:workout_tracker/scoped_models/workouts.dart';
import 'package:workout_tracker/widgets/workout_calendar.dart';

/// This file will contain UI tests for the add exercise widget page
/// and will mock the MainModel. The MainModel is tested under the
/// model_tests folder.
void main() {
  NavigatorObserver mockObserver;
  DateTime date;
  WorkoutsModel model;
  List<Workout> workouts;
  List<WorkoutExercise> workoutExercises;

  setUp(() {
    mockObserver = MockNavigatorObserver();
    model = MockMainModel();

    date = DateTime(2018, 11, 10);
    workoutExercises = [
      WorkoutExercise(name: 'Deadlift', workoutSets: []),
      WorkoutExercise(name: 'Bench Press', workoutSets: []),
    ];
    workouts = [
      Workout(date: date, workoutExercises: workoutExercises),
    ];

    when(model.workouts).thenReturn(workouts);
  });

  testWidgets('Should navigate to workouts page', (WidgetTester tester) async {
    /// Note this test does not actually test the navigation since we do not want
    /// to have this test be responsible for loading the workouts page. Therefore
    /// this test will only check to ensure that when a calendar tile is clicked
    /// the right route name and params are passed to the navigator. This assumes
    /// that the RouterparamParser is working.
    ParsedRoute parsedRoute;
    Widget mockApp = ScopedModel<WorkoutsModel>(
      model: model,
      child: MaterialApp(
        home: Scaffold(
          body: SingleChildScrollView(
            child: WorkoutCalendar(),
          ),
        ),
        navigatorObservers: [mockObserver],

        /// using the same parser that app uses here which takes away from the
        /// focus of the test. Ideally this would be mocked but I could not
        /// find a clean way to mock it.
        onGenerateRoute: (settings) {
          RouterParamParser parser = RouterParamParser(['workouts']);
          parsedRoute = parser.parse(settings);
          return null; // we don't want to actually route anywhere
        },

        /// just route to some blank page...
        onUnknownRoute: (settings) => TestUtils.blankPage(),
      ),
    );

    await tester.pumpWidget(mockApp);

    Finder day = find.text(date.day.toString());
    await tester.tap(day);

    expect(parsedRoute.name, 'workouts');
    expect(parsedRoute.params[0], date.year.toString());
    expect(parsedRoute.params[1], date.month.toString());
    expect(parsedRoute.params[2], date.day.toString());
  });

  /// TODO: this test is useful but it does not really belong in this file
  /// this test is actually testin the calendar_day widget and a new test
  /// file should be created for that widget.
  testWidgets('Should show marked dates', (WidgetTester tester) async {
    Widget mockApp = ScopedModel<WorkoutsModel>(
      model: model,
      child: MaterialApp(
        home: Scaffold(
          body: SingleChildScrollView(
            child: WorkoutCalendar(),
          ),
        ),
      ),
    );

    await tester.pumpWidget(mockApp);

    Finder eventMarker1 = find.descendant(
        of: find.byKey(Key('day${date.day.toString()}')),
        matching: find.byType(Material));
    RenderPhysicalShape actualMarker1 = tester.renderObject(eventMarker1);

    Finder eventMarker2 = find.descendant(
        of: find.byKey(Key('day11')), matching: find.byType(Material));
    RenderPhysicalShape actualMarker2 = tester.renderObject(eventMarker2);

    expect(actualMarker1.color == Colors.redAccent, true);
    expect(actualMarker2.color == Colors.transparent, true);
  });
}

class MockMainModel extends Mock implements WorkoutsModel {}

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

class TestUtils {
  static blankPage() {
    return MaterialPageRoute(builder: (context) => Container());
  }
}
