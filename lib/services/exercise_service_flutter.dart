import 'dart:convert';
import 'dart:io';

import './exercise_service.dart';
import '../models/exercise.dart';

class ExerciseServiceFlutter extends ExerciseService {
  final Future<Directory> Function() getDirectory;

  ExerciseServiceFlutter(
    this.getDirectory,
  );

  Future<List<Exercise>> loadExercises() async {
    final file = await _getLocalFile();
    final string = await file.readAsString();
    final json = JsonDecoder().convert(string);
    final todos = (json['exercises'])
        .map<Exercise>((exercise) => Exercise.fromJson(exercise))
        .toList();

    return todos;
  }

  Future<File> saveExercises(List<Exercise> exercises) async {
    final file = await _getLocalFile();

    return file.writeAsString(JsonEncoder().convert({
      'exercises': exercises.map((exercise) => exercise.toJson()).toList(),
    }));
  }

  Future<File> _getLocalFile() async {
    final dir = await getDirectory();

    return File('${dir.path}/ExercisesStorage.json');
  }

  Future<FileSystemEntity> clean() async {
    final file = await _getLocalFile();

    return file.delete();
  }
}
