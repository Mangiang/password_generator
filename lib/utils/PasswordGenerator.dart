import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:password_generator/file_store.dart';
import 'package:password_generator/state/PasswordState.dart';

class PasswordGenerator {
  static List<int> lowercase = [
    for (var charIdx = "a".codeUnitAt(0);
        charIdx <= "z".codeUnitAt(0);
        charIdx++)
      charIdx
  ];
  static List<int> uppercase = [
    for (var charIdx = "A".codeUnitAt(0);
        charIdx <= "Z".codeUnitAt(0);
        charIdx++)
      charIdx
  ];
  static List<int> numbers = [
    for (var charIdx = "0".codeUnitAt(0);
        charIdx <= "9".codeUnitAt(0);
        charIdx++)
      charIdx
  ];
  static List<int> symbols = [
        for (var charIdx = "!".codeUnitAt(0);
            charIdx <= "/".codeUnitAt(0);
            charIdx++)
          charIdx
      ] +
      [
        for (var charIdx = ":".codeUnitAt(0);
            charIdx <= "@".codeUnitAt(0);
            charIdx++)
          charIdx
      ] +
      [
        for (var charIdx = "[".codeUnitAt(0);
            charIdx <= "`".codeUnitAt(0);
            charIdx++)
          charIdx
      ] +
      [
        for (var charIdx = "{".codeUnitAt(0);
            charIdx <= "~".codeUnitAt(0);
            charIdx++)
          charIdx
      ];

  static Future<String> getPassword(PasswordState state) async {
    String passphrase1 = state.passphrase1;
    String passphrase2 = state.passphrase2;
    int desiredLength = state.desiredLength;
    final data = await FileStore.localData;
    final Map<List<int>, int> map =
        data.map((key, value) => MapEntry(utf8.encode(key), value));

    List<int> keyByteArray = utf8.encode(passphrase2 + passphrase1);
    List<int> keyHash = hashSHA256(keyByteArray);
    List<int> byteArray = utf8.encode(passphrase1 + passphrase2);
    final hashCount = await getHashCount(keyHash, map);
    List<int> hash = repeatHash256(byteArray, hashCount);

    List<int> encodedPassphrase2 = utf8.encode(passphrase2);
    List<int> charsPool = getShuffledCharactersPool(encodedPassphrase2,
        includeLowercase: state.includeLowerCase,
        includeUppercase: state.includeUpperCase,
        includeNumbers: state.includeNumbers,
        includeSymbols: state.includeSymbols,
        blacklist: state.blacklist);

    if (charsPool.isEmpty) return "";

    List<int> encodedResult = getFinalPassword(hash, charsPool, desiredLength);
    return utf8.decode(encodedResult);
  }

  static List<int> getFinalPassword(
      List<int> hash, List<int> charsPool, int desiredLength) {
    List<int> result = [];
    int hashLength = hash.length;
    int charPoolLength = charsPool.length;
    for (int i = 0; i < desiredLength; i++) {
      result.add(charsPool[(hash[i % hashLength] * i) % charPoolLength]);
    }

    return result;
  }

  static List<int> getShuffledCharactersPool(List<int> salt,
      {bool includeLowercase = true,
      bool includeUppercase = true,
      bool includeNumbers = true,
      bool includeSymbols = true,
      String blacklist = ""}) {
    List<int> blacklistChar = utf8.encode(blacklist);
    List<int> charsPool = [
      ...(includeUppercase ? uppercase : []),
      ...(includeLowercase ? lowercase : []),
      ...(includeNumbers ? numbers : []),
      ...(includeSymbols ? symbols : [])
    ];
    charsPool = charsPool.where((elt) => !blacklistChar.contains(elt)).toList();

    if (charsPool.isEmpty) return charsPool;

    int saltLength = salt.length;
    int charPoolLength = charsPool.length;
    for (int charIdx = 0; charIdx < charsPool.length; charIdx++) {
      int charValue = charsPool[charIdx];
      int rawIdx =
          charValue + salt[(charValue + charIdx) % saltLength] * charIdx;

      int tmp = charsPool[rawIdx % charPoolLength];
      charsPool[charIdx] = tmp;
      charsPool[rawIdx % charPoolLength] = charValue;
    }

    return charsPool;
  }

  static List<int> repeatHash256(List<int> bytes, int hashCount) {
    List<int> hash = hashSHA256(bytes);

    for (int i = 0; i < hashCount; i++) {
      hash = hashSHA256(hash);
    }

    return hash;
  }

  static Future<int> getHashCount(
      List<int> key, Map<List<int>, int> map) async {
    if (!map.containsKey(key)) {
      map[key] = 1;
      await updateDataFile(map);
    }

    return map[key]!;
  }

  static List<int> hashSHA256(List<int> bytes) =>
      utf8.encode(sha256.convert(bytes).toString());

  static Future<void> updateDataFile(Map<List<int>, int> map) async {
    final data = map.map((key, value) => MapEntry(utf8.decode(key), value));
    await FileStore.writeLocalData(data);
  }

  static Future<void> removeFromDataFile(PasswordState state) async {
    String passphrase1 = state.passphrase1;
    String passphrase2 = state.passphrase2;
    final data = await FileStore.localData;
    final Map<List<int>, int> map =
        data.map((key, value) => MapEntry(utf8.encode(key), value));

    List<int> keyByteArray = utf8.encode(passphrase2 + passphrase1);
    List<int> keyHash = hashSHA256(keyByteArray);

    if (map.containsKey(keyHash)) {
      map.remove(keyHash);
      final data = map.map((key, value) => MapEntry(utf8.decode(key), value));
      await FileStore.writeLocalData(data);
    }
  }
}
