import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_token_loninflow/model/user_model.dart';
import 'package:flutter_token_loninflow/provider/user_provider.dart';
import 'package:flutter_token_loninflow/view/splash_screen.dart';
import 'package:go_router/go_router.dart';

import '../view/login_screen.dart';
import '../view/nextpage.dart';

final authProvider = ChangeNotifierProvider<AuthProvider>((ref) {
  return AuthProvider(ref: ref);
});

class AuthProvider extends ChangeNotifier {
  final Ref ref;

  AuthProvider({
    required this.ref,
  }) {
    ref.listen<UserModelBase?>(userProvider, (previous, next) {
      //UserProvider에서 변경사항이 생겼을 때만 AuthProvider에서 알려줌
      if (previous != next) {
        notifyListeners();
      }
    });
  }

//goroute 만들어주기
  List<GoRoute> get routes => [
        GoRoute(
          path: '/nextPage',
          name: NextPage.routeName, //이름은 겹치면 안됌.
          builder: (_, __) => const NextPage(),
        ),
        GoRoute(
          path: '/splash',
          name: SplashScreen.routeName, //이름은 겹치면 안됌.
          builder: (_, __) => SplashScreen(),
        ),
        GoRoute(
          path: '/login',
          name: LoginScreen.routeName, //이름은 겹치면 안됌.
          builder: (_, __) => const LoginScreen(),
        ),
      ];

  logout() {
    ref.read(userProvider.notifier).logout();
  }

//앱을 처음 시작할 때 토큰이 존재하는지 확인 후 보내줄 스크린을 확인하는 과정 - splash screen
  FutureOr<String?> redirectLogic(BuildContext _, GoRouterState state) {
    //유저상태
    final UserModelBase? user = ref.read(userProvider);
    //로그인 중
    final logginIn = state.location == '/login';

    //유저 정보가 없는데 로그인중이라면 로그인 페이지
    //로그인 중이 아니면 로그인 페이지로 이동
    if (user == null) {
      return logginIn ? null : '/login';
    }

    //user가 null이 아님
    // 1) UserModel
    //사용자 정보가 있는 상태, 로그인 중이거나 현재위치가 SplashScreen이면 nextpage로 이동
    if (user is UserModel) {
      return logginIn || state.location == 'splash' ? '/' : null;
    }

    //2) UserMoelError > token이 잘 못 된 경우.
    //로그인하는 중이 아니라면 로그인할 수 있도록
    if (user is UserModelError) {
      return !logginIn ? '/login' : null;
    }
    return null;
  }
}
