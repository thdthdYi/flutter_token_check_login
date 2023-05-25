import "package:dio/dio.dart";
import "package:flutter/material.dart";

import "package:flutter_token_loninflow/view/nextpage.dart";

import "../utils/data.dart";
import "login_screen.dart";

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
//시작 화면시 토큰 여부 검증
  @override
  void initState() {
    super.initState();

    checkToken();
  }

  void checkToken() async {
    final dio = Dio();

    String path = '';

    //Token 불러오기
    final refreshToken = await storage.read(key: REFRESH_TOKEN_KEY);
    final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);

    try {
// ignore: use_build_context_synchronously

      //refresh token을 이용해 access token을 발급받을 수 있음.
      final resp = await dio.post('http://$ip/$path',
          options: Options(headers: {'authorization': 'Bearer $refreshToken'}));
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (_) => const NextPage(),
        ),
        (route) => false,
      );
    } catch (e) {
      //에러시 로그인 화면으로 이동하여 다시 로그인함.
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (_) => const LoginScreen(),
        ),
        (route) => false,
      );
    }

    //Token 여부 검증
    //----------- 현재는 token이 있는지 없는지만 확인하는 과정 -----------
    // if (refreshToken == null || accessToken == null) {

    // } else {

    // }
    //---------------------------------------------------------
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      //넓이 최대 > 가운데 정렬
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text('Splash_Screen'),
          SizedBox(
            height: 16.0,
          ),
          CircularProgressIndicator(
            color: Colors.blue,
          )
        ],
      ),
    );
  }
}
