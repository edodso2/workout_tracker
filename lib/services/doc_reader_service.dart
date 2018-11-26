import 'dart:convert';
import 'dart:io';

class DocReaderService {
  final String filename;
  final Future<Directory> Function() getDirectory;

  DocReaderService(this.getDirectory, this.filename);

  dynamic readFromDisk() async {
    final file = await _getLocalFile();
    final string = await file.readAsString();
    final json = JsonDecoder().convert(string);

    return json;
  }

  Future<File> writeToDisk(String json) async {
    final file = await _getLocalFile();

    return file.writeAsString(json);
  }

  Future<File> _getLocalFile() async {
    final dir = await getDirectory();

    return File('${dir.path}/$filename.json');
  }

  Future<FileSystemEntity> clean() async {
    final file = await _getLocalFile();

    return file.delete();
  }
}
