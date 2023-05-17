import "package:flutter/material.dart";

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import "package:flutter_token_loninflow/view/nextpage.dart";

import "login_screen.dart";

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final storage = FlutterSecureStorage(); //storage open

//시작 화면시 토큰 여부 검증
  @override
  void initState() {
    super.initState();

    checkToken();
  }

  void checkToken() async {
    //Token 불러오기
    final refreshToken = await storage.read(key: 'REFRESH_TOKEN_KEY');
    final accessToken = await storage.read(key: 'ACCESS_TOKEN_KEY');

    //Token 여부 검증
    if (refreshToken == null || accessToken == null) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (_) => LoginScreen(),
        ),
        (route) => false,
      );
    } else {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (_) => NextPage(),
        ),
        (route) => false,
      );
    }
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
            color: Colors.white,
          )
        ],
      ),
    );
  }
}
