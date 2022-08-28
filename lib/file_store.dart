import 'dart:collection';
import 'dart:io';

import 'package:collection/collection.dart';
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

  static Future<LinkedHashMap<String, int>> get localData async {
    final localFile = File(await localPath);
    localFile.create(recursive: true);

    if (!await localFile.exists()) {
      return LinkedHashMap(equals: const DeepCollectionEquality().equals);
    }
    final localData = await localFile.readAsString();
    if (localData.isEmpty) {
      return LinkedHashMap(equals: const DeepCollectionEquality().equals);
    }

    final yamlData = loadYaml(localData) as YamlMap;
    final data = LinkedHashMap<String, int>(
        equals: const DeepCollectionEquality().equals);

    for (final keyVal in yamlData.entries) {
      data[keyVal.key] = keyVal.value;
    }
    return data;
  }

  static Future<void> writeLocalData(LinkedHashMap<String, int> data) async {
    var yamlWriter = YAMLWriter();
    var yamlDocString = yamlWriter.write(data);
    var localFile = File(await localPath);
    await localFile.writeAsString(yamlDocString);
  }
}
