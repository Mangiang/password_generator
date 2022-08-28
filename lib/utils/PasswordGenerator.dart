import 'dart:collection';
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

  static List<int> generateKeyHash(PasswordState state) {
    final blacklistSumChar = sumBlacklist(state.blacklist);

    final keyByteArray = utf8.encode(state.passphrase1 +
        state.passphrase2 +
        state.desiredLength.toString() +
        utf8.decode([blacklistSumChar]) +
        (state.includeLowerCase ? 'L' : '') +
        (state.includeUpperCase ? 'U' : '') +
        (state.includeNumbers ? 'N' : '') +
        (state.includeSymbols ? 'S' : ''));
    return hashSHA256(keyByteArray);
  }

  static int sumBlacklist(String blacklist) {
    final Iterable<List<int>> blacklistBytesArray =
        blacklist.split('').map((elt) => utf8.encode(elt));
    final Iterable<int> blacklistBytes = blacklistBytesArray.map((elt) =>
        elt.reduce((int previousValue, int currentValue) =>
            previousValue + currentValue));
    final blacklistSum = blacklistBytes.fold(0, (int prev, elt) => prev + elt);
    final blacklistSumCharacter =
        blacklistSum % ("~".codeUnitAt(0) - "!".codeUnitAt(0)) +
            "!".codeUnitAt(0);
    return blacklistSumCharacter;
  }

  static Future<String> getPassword(
      PasswordState state, bool increaseRegenerationCount) async {
    final passphrase1 = state.passphrase1;
    final passphrase2 = state.passphrase2;
    final desiredLength = state.desiredLength;
    final data = await FileStore.localData;

    final keyHash = generateKeyHash(state);
    final hashCount =
        await getHashCount(keyHash, data, increaseRegenerationCount);
    final byteArray = utf8.encode(passphrase1 + passphrase2);
    final hash = repeatHash256(byteArray, hashCount);

    final encodedPassphrase2 = utf8.encode(passphrase2);
    final charsPool = getShuffledCharactersPool(encodedPassphrase2,
        includeLowercase: state.includeLowerCase,
        includeUppercase: state.includeUpperCase,
        includeNumbers: state.includeNumbers,
        includeSymbols: state.includeSymbols,
        blacklist: state.blacklist);

    if (charsPool.isEmpty) return "";

    final encodedResult = getFinalPassword(hash, charsPool, desiredLength);
    return utf8.decode(encodedResult);
  }

  static List<int> getFinalPassword(
      List<int> hash, List<int> charsPool, int desiredLength) {
    final List<int> result = [];
    final hashLength = hash.length;
    final charPoolLength = charsPool.length;
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

    final saltLength = salt.length;
    final charPoolLength = charsPool.length;
    for (int charIdx = 0; charIdx < charsPool.length; charIdx++) {
      final charValue = charsPool[charIdx];
      final rawIdx =
          charValue + salt[(charValue + charIdx) % saltLength] * charIdx;

      final tmp = charsPool[rawIdx % charPoolLength];
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

  static Future<int> getHashCount(List<int> keyBytes,
      LinkedHashMap<String, int> map, bool increaseRegenerationCount) async {
    final key = utf8.decode(keyBytes);
    if (!map.containsKey(key)) {
      map[key] = 1;

      await FileStore.writeLocalData(map);
    }

    if (increaseRegenerationCount) {
      map[key] = map[key]! + 1;
      await FileStore.writeLocalData(map);
    }

    return map[key]!;
  }

  static List<int> hashSHA256(List<int> bytes) =>
      utf8.encode(sha256.convert(bytes).toString());

  static Future<void> removeFromDataFile(PasswordState state) async {
    final data = await FileStore.localData;
    final map = data.map((key, value) => MapEntry(key, value))
        as LinkedHashMap<String, int>;

    final hashStr = utf8.decode(generateKeyHash(state));
    if (map.remove(hashStr) != null) {
      await FileStore.writeLocalData(map);
    }
  }
}
