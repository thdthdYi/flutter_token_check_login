import 'package:json_annotation/json_annotation.dart';

part 'login_response.g.dart';

//로그인했을 때 응답을 받아오는 형태

@JsonSerializable()
class LoginResponse {
  final String refreshToken;
  final String accessToken;

  LoginResponse({
    required this.refreshToken,
    required this.accessToken,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);
}
