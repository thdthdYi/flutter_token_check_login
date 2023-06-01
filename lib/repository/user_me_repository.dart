import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_token_loninflow/model/user_model.dart';
import 'package:flutter_token_loninflow/provider/storage_provider.dart';
import 'package:retrofit/retrofit.dart';
// ignore: depend_on_referenced_packages
import 'package:riverpod/riverpod.dart';

import '../utils/data.dart';

part 'user_me_repository.g.dart';

//retrofit라이브러리를 사용하면서 API요청을 만들기 위한 repository 파일

//provider 만들기
final userMeRepositoryProvider = Provider<UserMeRepository>((ref) {
  final dio = Dio();
  // ignore: unused_local_variable
  final storage = ref.watch(secureStorageProvider);

  return UserMeRepository(dio, baseUrl: 'http://$ip/user/me');
});

// http ://$ip/user/me
@RestApi() //annotation
//repository는 인스턴스화가 되지 않도록 abstract로 선언
abstract class UserMeRepository {
  //retrofit 구조에 맞게 작성.
  factory UserMeRepository(Dio dio, {String baseUrl}) = _UserMeRepository;

  @GET('/')
  @Headers({
    'accessToken': 'true',
  })
  //반환받는 값
  Future<UserModel> getMe(); //함수정의 > 위의 annotation을 통해서 정의할 수 있음
  // > retrofit이 code생성을 통해 정의함.
}
