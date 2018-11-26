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
    docReaderService = DocReaderService(this.getDirectory, 'WorkoutsStorage');
  }

  Future<List<Workout>> loadWorkouts() async {
    final json = await docReaderService.readFromDisk();
    final workouts = (json['workouts'])
        .map<Workout>((workout) => Workout.fromJson(workout))
        .toList();

    return workouts;
  }

  Future<File> saveWorkouts(List<Workout> workouts) async {
    final String json = JsonEncoder().convert({
      'workouts': workouts.map((workout) => workout.toJson()).toList(),
    });

    return docReaderService.writeToDisk(json);
  }
}