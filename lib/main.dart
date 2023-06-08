import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_token_loninflow/provider/go_router.dart';

import 'package:flutter_token_loninflow/view/splash_screen.dart';

void main() {
  runApp(
      //riverpod provider를 사용하기 위해 먼저 선언 필요.
      const ProviderScope(child: _App()));
}

class _App extends ConsumerWidget {
  const _App({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //프로그램 어디서든 해당 router를 볼 수 있음.
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: router,
    );
  }
}
