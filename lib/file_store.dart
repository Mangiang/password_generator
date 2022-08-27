import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:yaml/yaml.dart';
import 'package:yaml_writer/yaml_writer.dart';

class FileStore {
  static const localFileDir = 'password_generator';
  static const localFileName = 'password_generator.yml';

  static Future<String> get localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return '${directory.path}${Platform.pathSeparator}$localFileDir${Platform.pathSeparator}$localFileName';
  }

  static Future<Map<String, int>> get localData async {
    final localFile = File(await localPath);
    localFile.create(recursive: true);

    if (!await localFile.exists()) {
      return {};
    }
    final localData = await localFile.readAsString();
    if (localData.isEmpty){
      return {};
    }

    final yamlData = loadYaml(localData) as YamlMap;
    final Map<String, int> data =
        yamlData.map((key, value) => MapEntry(key, value));
    return data;
  }

  static Future<void> writeLocalData(Map<String, int> data) async {
    var yamlWriter = YAMLWriter();
    var yamlDocString = yamlWriter.write(data);
    var localFile = File(await localPath);
    await localFile.writeAsString(yamlDocString);
  }
}
