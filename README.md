# Workout Tracker

A simple workout tracker for tracking weighlifting workouts.

## Features

1. adding exercises
2. creating workouts on a specified date
3. adding exercises to the workout
4. adding the number of sets and reps completed for the exercise
5. persist exercises & workouts to disk


Possible future features:

1. data visualization for progress, such as plotting max wight lifted on a line chart.

## Architecture

State management follows the [scoped model](https://pub.dartlang.org/packages/scoped_model) and data is persisted to disk via JSON. The code is highly modularized to support automated tests and to keep the tests single purpose. I referenced the [flutter architecture samples](https://github.com/brianegan/flutter_architecture_samples) repository which was extremely helpful since there are many ways to architect a flutter application and architecture gets a little more complex when trying to architect a testable application.


