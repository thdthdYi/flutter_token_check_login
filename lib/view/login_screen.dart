import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'nextpage.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String username = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    //storage open > 프로그램 빌드할 때마다 로그인이 풀리는 것을 방지
    final storage = FlutterSecureStorage(); //storage open

    final dio = Dio();

    //localhost ipㄴ
    final emulatorIp = '10.0.2.2:3000';
    final simulatorIp = '127.0.0.1:3000';

    String path = '';

    final ip = Platform.isIOS ? simulatorIp : emulatorIp;

    return SingleChildScrollView(
      //drag로 키보드 숨기기 가능
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child: SafeArea(
        top: true,
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(
                height: 500.0,
              ),
              TextFormField(
                  decoration: InputDecoration(
                    hintText: '아이디',
                  ),
                  onChanged: (String value) {
                    //입력값 저장
                    username = value;
                  }),
              const SizedBox(
                height: 8.0,
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: '비밀번호',
                ),
                onChanged: (String value) {
                  password = value;
                },
                //hidden
                obscureText: true,
              ),
              const SizedBox(
                height: 16.0,
              ),
              ElevatedButton(
                onPressed: () async {
                  //ID:비밀번호
                  final rawString = '$username:$password';

                  //일반 String을 Base64로 바꿈
                  Codec<String, String> stringToBase64 = utf8.fuse(base64);

                  //rawString encode
                  String token = stringToBase64.encode(rawString);

                  //로그인버튼을 누르면 해당 아이피, path로 요청
                  final resp = await dio.post('http://$ip/$path',
                      options:
                          Options(headers: {'authorization': 'Basic $token'}));

                  //resp에서 token 가져오기
                  final refreshToken = resp.data['refreshToken'];
                  final accessToken = resp.data['accessToken'];

                  //저장소에 값 넣어주기
                  await storage.write(
                      key: 'REFRESH_TOKEN_KEY', value: refreshToken);
                  await storage.write(
                      key: 'ACCESS_TOKEN_KEY', value: accessToken);

                  //토큰 인증이 되면 다음 화면으로 넘어감
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => NextPage(),
                    ),
                  );
                },
                //----------------------------------------------------------
                child: Text('로그인'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
