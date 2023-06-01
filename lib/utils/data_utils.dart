//아이디 : 비밀번호 - refresh Token 발급

import 'dart:convert';

import 'data.dart';

class DataUtils {
  static String pathToUrl(String path) {
    return 'http://$ip/$path';
  }

  static List<String> listPathsToUrls(List paths) {
    return paths.map((e) => pathToUrl(e)).toList();
  }

//일반 String을 Base64로 바꿈
  static String plainTobase64(String rawString) {
    Codec<String, String> stringToBase64 = utf8.fuse(base64);

    //rawString encode
    String encoded = stringToBase64.encode(rawString);

    return encoded;
  }
}
