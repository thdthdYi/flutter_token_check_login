import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_token_loninflow/provider/user_provider.dart';

import '../model/user_model.dart';
import '../utils/data.dart';
import 'nextpage.dart';

class LoginScreen extends ConsumerStatefulWidget {
  static String get routeName => 'login';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  String username = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    final dio = Dio();
    String path = 'auth/login';
    final state = ref.watch(userProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('login Screen'),
      ),
      body: SingleChildScrollView(
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
                    decoration: const InputDecoration(
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
                  decoration: const InputDecoration(
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
                  // onPressed: () async {
                  onPressed: state is UserModelLoading
                      ? null
                      : () async {
                          ref
                              .read(userProvider.notifier)
                              .login(username: username, password: password)
                              .then((user) {
                            if (user != null) {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => const NextPage(),
                                ),
                              );
                            }
                          });

                          // //-------------token을 이용한 로그인 로직 과정 ------------------
                          // //ID:비밀번호
                          // final rawString = '$username:$password';

                          // //일반 String을 Base64로 바꿈
                          // Codec<String, String> stringToBase64 = utf8.fuse(base64);

                          // //rawString encode
                          // String token = stringToBase64.encode(rawString);

                          // //로그인버튼을 누르면 해당 아이피, path로 요청
                          // final resp = await dio.post('http://$ip/$path',
                          //     options: Options(
                          //         headers: {'authorization': 'Basic $token'}));

                          // //resp에서 token 가져오기
                          // final refreshToken = resp.data['refreshToken'];
                          // final accessToken = resp.data['accessToken'];

                          // //저장소에 값 넣어주기
                          // await storage.write(
                          //     key: REFRESH_TOKEN_KEY, value: refreshToken);
                          // await storage.write(
                          //     key: ACCESS_TOKEN_KEY, value: accessToken);

                          // //토큰 인증이 되면 다음 화면으로 넘어감
                          // // ignore: use_build_context_synchronously
                          // Navigator.of(context).push(
                          //   MaterialPageRoute(
                          //     builder: (_) => const NextPage(),
                          //   ),
                          // );
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                  ),
                  //----------------------------------------------------------
                  child: const Text('로그인'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
