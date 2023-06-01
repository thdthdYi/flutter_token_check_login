//localhost ip
import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const emulatorIp = '10.0.2.2:3000';
const simulatorIp = '127.0.0.1:3000';

final ip = Platform.isIOS ? simulatorIp : emulatorIp;

//token key 선언
// ignore: constant_identifier_names
const ACCESS_TOKEN_KEY = 'ACCESS_TOKEN_KEY'; //해당서버 유효기간 - 5분

// ignore: constant_identifier_names
const REFRESH_TOKEN_KEY = 'REFRESH_TOKEN_KEY'; //해당서버 유효기간 - 하루

//storage open > 프로그램 빌드할 때마다 로그인이 풀리는 것을 방지s
const storage = FlutterSecureStorage(); //storage open

