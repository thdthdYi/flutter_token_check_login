import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_token_loninflow/model/user_model.dart';
import 'package:flutter_token_loninflow/repository/auth_repository.dart';
import 'package:flutter_token_loninflow/repository/user_me_repository.dart';
import 'package:flutter_token_loninflow/utils/data.dart';
// ignore: depend_on_referenced_packages
import 'package:riverpod/riverpod.dart';

class UserStateNotifier extends StateNotifier<UserModelBase?> {
  final AuthRepository authrepository;
  final UserMeRepository repository;
  final FlutterSecureStorage storage;

  UserStateNotifier({
    required this.authrepository,
    required this.repository,
    required this.storage,
  }) : super(UserModelLoading()) {
    //해당 class가 인스턴스화가 되면 가지고 있는 token을 기반으로
    //내정보 가져오기
    getMe();
  }

  //현재 사용자를 가져오는 함수
  Future<void> getMe() async {
    final refreshToken = await storage.read(key: REFRESH_TOKEN_KEY);
    final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);

//Token이 없는 경우에는 가져오지 않도록.
    if (refreshToken == null || accessToken == null) {
      state = null; //token이 없으면 상태 또한 null이 되어서 로그아웃 상태로 돌아감.
      return;
    }

    final resp = await repository.getMe();

    state = resp;
  }

//UserModelBase로 받는 이유는 데이터가 어떤 형식으로 들어올지 모르기 때문에.
//> login이 될지, 안될지, loaing을 반환해야할지 등
  Future<UserModelBase> login(
      {required String username, required String password}) async {
    try {
      //로그인을 시도하면 loading화면을 띄워줌
      state = UserModelLoading();

      //request > authrepository에서 만들어준 Token Encoding을 이용한 로그인 기능 사용
      final resp =
          await authrepository.login(username: username, password: password);

//받은 응답을 storage에 넣어줌
      await storage.write(key: REFRESH_TOKEN_KEY, value: resp.refreshToken);
      await storage.write(key: ACCESS_TOKEN_KEY, value: resp.accessToken);

      //Token을 발급받았으니, 서버에서 해당되는 사용자를 가져오기 위함.
      //user를 넣지 않으면 로그인한 상태인지 알 수 없음 > 유효한 토큰임
      final userResp = await repository.getMe();

      return userResp;
    } catch (e) {
      //error
      state = UserModelError(message: '로그인에 실패했습니다.');

      return Future.value(state);
    }
  }

//로그아웃 기능을 가진 함수
  Future<void> logout() async {
    state = null;

//동시에 사용하기 위해 넣어줌
    await Future.wait([
      //로그아웃이므로 token을 모두 지워줘야함.
      storage.delete(key: REFRESH_TOKEN_KEY),
      storage.delete(key: ACCESS_TOKEN_KEY),
    ]);
  }
}
