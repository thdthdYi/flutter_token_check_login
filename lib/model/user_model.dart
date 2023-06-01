//로그인이 되었을 때 불러올 수 있는 id와 username

import 'package:json_annotation/json_annotation.dart';

import '../utils/data_utils.dart';

part 'user_model.g.dart';

abstract class UserModelBase {}

//error
class UserModelError extends UserModelBase {
  final String message;

  UserModelError({required this.message});
}

//loading
class UserModelLoading extends UserModelBase {}

//login 성공 > id와 username 불러오기
@JsonSerializable()
class UserModel extends UserModelBase {
  final String id;
  final String username;
  @JsonKey(
    fromJson: DataUtils.pathToUrl,
  )
  final String imageUrl;

  UserModel({required this.id, required this.username, required this.imageUrl});

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}
