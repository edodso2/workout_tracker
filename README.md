# Workout Tracker
A simple workout tracker for tracking weightlifting workouts. Built with Flutter.

![Workout_Tracker_Demo mov](https://user-images.githubusercontent.com/12009947/67638477-fdf7ed00-f8ba-11e9-81fe-f92cca20a0e8.gif)

## Features
1. adding exercises
2. creating workouts on a specified date
3. adding exercises to the workout
4. adding the number of sets and reps completed for the exercise
5. persist exercises & workouts to disk

## Future features:
1. data visualization for progress, such as plotting max weight lifted on a line chart.

## Architecture
State management follows the [scoped model](https://pub.dartlang.org/packages/scoped_model) and data is persisted to disk via JSON. The code is highly modularized to support automated tests and to keep the tests single purpose. I referenced the [flutter architecture samples](https://github.com/brianegan/flutter_architecture_samples) repository which was extremely helpful since there are many ways to architect a flutter application and architecture gets a little more complex when trying to architect a testable application.

This application has two models the exercise model and workouts model. The idea is that since the application is a workout tracker the entire app needs the workouts model however; the exercise model should only be provided to the pages/widgets where it is needed. Currently all the pages need the exercises model for various reasons but I have chosen to keep the models separate for now to make the application more scalable.
