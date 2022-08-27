import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:yaml/yaml.dart';
import 'package:yaml_writer/yaml_writer.dart';

class FileStore {
  static const localFileName = 'password_generator.yml';

  static Future<String> get localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  static Future<Map<String, int>> get localData async {
    var localFile =
        File('${await localPath}${Platform.pathSeparator}$localFileName');

    if (!await localFile.exists()) {
      return {};
    }

    final yamlData = loadYaml(await localFile.readAsString()) as YamlMap;
    final Map<String, int> data =
        yamlData.map((key, value) => MapEntry(key, value));
    return data;
  }

  static Future<void> writeLocalData(Map<String, int> data) async {
    var yamlWriter = YAMLWriter();
    var yamlDocString = yamlWriter.write(data);
    var localFile =
        File('${await localPath}${Platform.pathSeparator}$localFileName');
    await localFile.writeAsString(yamlDocString);
  }
}
