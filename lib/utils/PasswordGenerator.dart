import 'dart:collection';
import 'dart:convert';

import 'package:crypto/crypto.dart';
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

  static String getPassword(PasswordState state) {
    String passphrase1 = state.passphrase1;
    String passphrase2 = state.passphrase2;
    int desiredLength = state.desiredLength;
    HashMap<List<int>, int> map = HashMap<List<int>, int>();

    List<int> byteArray = utf8.encode(passphrase1 + passphrase2);
    List<int> hash = repeatHash256(byteArray, map);

    List<int> encodedPassphrase2 = utf8.encode(passphrase2);
    List<int> charsPool = getShuffledCharactersPool(encodedPassphrase2,
        includeLowercase: state.includeLowerCase,
        includeUppercase: state.includeUpperCase,
        includeNumbers: state.includeNumbers,
        includeSymbols: state.includeSymbols);

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
      bool includeSymbols = true}) {
    List<int> charsPool = [
      ...(includeUppercase ? uppercase : []),
      ...(includeLowercase ? lowercase : []),
      ...(includeNumbers ? numbers : []),
      ...(includeSymbols ? symbols : [])
    ];

    if (charsPool.isEmpty) return charsPool;

    int saltLength = salt.length;
    int charPoolLength = charsPool.length;
    for (int charIdx = 0; charIdx < charsPool.length; charIdx++) {
      int charValue = charsPool[charIdx];
      int rawIdx = charValue + salt[(charValue + charIdx) % saltLength] * charIdx;

      int tmp = charsPool[rawIdx % charPoolLength];
      charsPool[charIdx] = tmp;
      charsPool[rawIdx % charPoolLength] = charValue;
    }

    return charsPool;
  }

  static List<int> repeatHash256(List<int> bytes, HashMap<List<int>, int> map) {
    List<int> hash = hashSHA256(bytes);
    int count = getHashCount(hash, map);

    for (int i = 0; i < count; i++) {
      hash = hashSHA256(hash);
    }

    return hash;
  }

  static int getHashCount(List<int> key, HashMap<List<int>, int> map) {
    if (!map.containsKey(key)) {
      map[key] = 1;
    }

    return map[key]!;
  }

  static List<int> hashSHA256(List<int> bytes) =>
      utf8.encode(sha256.convert(bytes).toString());
}
