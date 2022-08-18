import 'dart:collection';
import 'dart:convert';

import 'package:crypto/crypto.dart';

class PasswordGenerator {
  static String getPassword(
      String passphrase1, String passphrase2, int desiredLength) {
    HashMap<List<int>, int> map = HashMap<List<int>, int>();

    List<int> byteArray = utf8.encode(passphrase1 + passphrase2);
    List<int> hash = repeatHash256(byteArray, map);

    List<int> encodedPassphrase2 = utf8.encode(passphrase2);
    List<int> encodedResult =
        getFinalPassword(hash, encodedPassphrase2, desiredLength);
    return utf8.decode(encodedResult);
  }

  static List<int> getFinalPassword(
      List<int> hash, List<int> salt, int desiredLength) {
    List<int> charsPool = getShuffledCharactersPool(salt);

    List<int> result = [];
    int hashLength = hash.length;
    int charPoolLength = charsPool.length;
    for (int i = 0; i < desiredLength; i++) {
      result.add(charsPool[(hash[i % hashLength] + i) % charPoolLength]);
    }

    return result;
  }

  static List<int> getShuffledCharactersPool(List<int> salt) {
    const int minChar = 33;
    const int maxChar = 126;

    List<int> charsPool =
        List<int>.generate(maxChar - minChar, (index) => index + minChar);
    int charCount = 0;
    int saltLength = salt.length;
    int charPoolLength = charsPool.length;
    for (int charValue = minChar; charValue < maxChar; charValue++) {
      int rawIdx =
          charValue + salt[(charValue + charCount) % saltLength] + charCount;
      charsPool[rawIdx % charPoolLength] = charValue;
      charCount++;
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

  static List<int> hashSHA256(List<int> bytes) => utf8.encode(sha256.convert(bytes).toString());
}
