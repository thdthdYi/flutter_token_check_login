import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

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
    final dio = Dio();

    //localhost
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
                    username = value;
                  }),
              const SizedBox(
                height: 8.0,
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: '아이디',
                ),
                onChanged: (String value) {
                  password = value;
                },
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

                  //로그인버튼을 누르면 해당 아이피로 요청
                  final resp = await dio.post('http://$ip/$path',
                      options:
                          Options(headers: {'authorization': 'Basic $token'}));

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
