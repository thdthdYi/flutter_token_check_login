import "package:dio/dio.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "package:flutter_token_loninflow/view/nextpage.dart";

import "../utils/data.dart";
import "login_screen.dart";

class SplashScreen extends ConsumerWidget {
  //router 등록
  static String get routeName => 'splash';

  //auth_provider에서 login 로직을 모두 설계해뒀기 때문에
  //해당 로직을 주석처리해도 동작함을 확인 완료.

//   const SplashScreen({Key? key}) : super(key: key);

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//시작 화면시 토큰 여부 검증
//   @override
//   void initState() {
//     super.initState();

//     checkToken();
//   }

//   void checkToken() async {
//     final dio = Dio();

//     String path = 'auth/token';

//     //Token 불러오기
//     final refreshToken = await storage.read(key: REFRESH_TOKEN_KEY);

//     try {
// // ignore: use_build_context_synchronously

//       //refresh token을 이용해 access token을 발급받을 수 있음.
//       //로그인 시 refresh token 발급 - refresh token을 이용해 만료된 access token 발급
//       //access token을 이용해 api 정보 접근
//       // ignore: unused_local_variable
//       final resp = await dio.post('http://$ip/$path',
//           options: Options(headers: {'authorization': 'Bearer $refreshToken'}));
//       // ignore: use_build_context_synchronously
//       Navigator.of(context).pushAndRemoveUntil(
//         MaterialPageRoute(
//           builder: (_) => const NextPage(),
//         ),
//         (route) => false,
//       );
//     } catch (e) {
//       //에러시 로그인 화면으로 이동하여 다시 로그인함.
//       // ignore: use_build_context_synchronously
//       Navigator.of(context).pushAndRemoveUntil(
//         MaterialPageRoute(
//           builder: (_) => const LoginScreen(),
//         ),
//         (route) => false,
//       );
//     }

//     //Token 여부 검증
//     //----------- 현재는 token이 있는지 없는지만 확인하는 과정 -----------
//     // if (refreshToken == null || accessToken == null) {

//     // } else {

//     // }
//     //---------------------------------------------------------
//   }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SizedBox(
        //넓이 최대 > 가운데 정렬
        width: MediaQuery.of(context).size.width,
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Splash_Screen'),
            SizedBox(
              height: 16.0,
            ),
            CircularProgressIndicator(
              color: Colors.blue,
            )
          ],
        ),
      ),
    );
  }
}
