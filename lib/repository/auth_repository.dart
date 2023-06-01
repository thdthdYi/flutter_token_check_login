import 'package:dio/dio.dart';
import 'package:flutter_token_loninflow/model/login_response.dart';
import 'package:flutter_token_loninflow/model/token_response.dart';

import '../utils/data.dart';
import '../utils/data_utils.dart';

class AuthRepository {
  final String baseUrl;
  final Dio dio;

  AuthRepository({
    required this.baseUrl,
    required this.dio,
  });

//응답을 받아오기 위한 model
  Future<LoginResponse> login(

      //rawString에 필요한 파라미터
      {required String username,
      required String password}) async {
    //DataUtils에 encode 함수로 응답 encode
    final serialized = DataUtils.plainTobase64('$username:$password');

    final resp = await dio.post('http://$baseUrl/login', //path에 post
        //encode된 token을 authorization에 넣어줌
        options: Options(headers: {'authorization': 'Basic $serialized'}));

    return LoginResponse.fromJson(resp.data);
  }

//token을 받아오기 위한 작업
  Future<TokenResponse> token() async {
    //final refreshToken = await storage.read(key: REFRESH_TOKEN_KEY);

    final resp = await dio.post('$baseUrl/token',
        options: Options(headers: {'refreshToken': 'true'}));
    return TokenResponse.fromJson(resp.data);
  }
}
