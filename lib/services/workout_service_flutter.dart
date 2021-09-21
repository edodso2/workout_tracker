import 'dart:convert';
import 'dart:io';

import '../models/workout.dart';
import './doc_reader_service.dart';
import './workout_service.dart';

class WorkoutServiceFlutter extends WorkoutService {
  final Future<Directory> Function() getDirectory;
  DocReaderService docReaderService;

  WorkoutServiceFlutter(
    this.getDirectory,
  ) {
    docReaderService = DocReaderService(getDirectory, 'WorkoutsStorage');
  }

  @override
  Future<List<Workout>> loadWorkouts() async {
    final json = await docReaderService.readFromDisk();
    final workouts = (json['workouts'])
        .map<Workout>((workout) => Workout.fromJson(workout))
        .toList();

    return workouts;
  }

  @override
  Future<File> saveWorkouts(List<Workout> workouts) async {
    final String json = const JsonEncoder().convert({
      'workouts': workouts.map((workout) => workout.toJson()).toList(),
    });

    return docReaderService.writeToDisk(json);
  }
}
