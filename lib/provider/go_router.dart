import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_token_loninflow/provider/auth_provider.dart';
import 'package:go_router/go_router.dart';

//GoRouter를 반환하는 값을 만들 수 있음
//어디서든 똑같은 GoRouter 사용 가능
final routerProvider = Provider<GoRouter>((ref) {
  //watch - authProvider가 변경될 때마다 다시 빌드
  //read - 한번만 읽고 값이 변경되도 다시 빌드하지 않음 > 읽어드리는 순간의 값만 반영
  //항상 같은 GoRouter 인스턴스 값을 읽어야하기 때문에

  final provider = ref.read(authProvider);

  //GoRouter반환
  //어디서든 동일한 인스턴스 값을 가져올 수 있음
  return GoRouter(
    routes: provider.routes,
    initialLocation: '/splash',
    refreshListenable: provider,
    redirect: provider.redirectLogic,
  );
});
