import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class JsonPreferences {
  File jsonFile;
  Directory dir;
  String fileName = "preferences.json";
  bool fileExists = false;
  Map<String, dynamic> fileContent;

  init() async {
    Directory directory = await getApplicationDocumentsDirectory();
    this.dir = directory;
    this.jsonFile = new File(this.dir.path + '/' + this.fileName);
    this.fileExists = this.jsonFile.existsSync();
    if (fileExists) {
      this.fileContent = json.decode(this.jsonFile.readAsStringSync());
    } else {
      createFile({"first_attempt": true, "dark_mode": false}, this.dir);
    }
  }

  void createFile(Map<String, dynamic> content, Directory dir) {
    print("Creating file!");
    File file = new File(this.dir.path + "/" + this.fileName);
    file.createSync();
    this.fileExists = true;
    file.writeAsStringSync(json.encode(content));
  }

  void writeToFile(String key, dynamic value) {
    print("Writing to file!");
    Map<String, dynamic> content = {key: value};
    if (this.fileExists) {
      print("File exists");
      Map<String, dynamic> jsonFileContent = json.decode(
        this.jsonFile.readAsStringSync(),
      );
      jsonFileContent.addAll(content);
      jsonFile.writeAsStringSync(json.encode(jsonFileContent));
    } else {
      print("File does not exist!");
      createFile({}, this.dir);
    }
    fileContent = json.decode(jsonFile.readAsStringSync());
  }

  // ignore: missing_return
  Map<String, dynamic> readFromFile() {
    if (this.fileExists) {
      Map<String, dynamic> jsonFileContent = json.decode(
        this.jsonFile.readAsStringSync(),
      );
      return jsonFileContent;
    }
  }
}
