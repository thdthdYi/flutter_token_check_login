import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_token_loninflow/model/user_model.dart';
import 'package:flutter_token_loninflow/provider/user_provider.dart';

final authProvider = ChangeNotifierProvider<AuthProvider>((ref) {
  return AuthProvider(ref: ref);
});

class AuthProvider extends ChangeNotifier {
  final Ref ref;

  AuthProvider({required this.ref}) {
    ref.listen<UserModelBase?>(userProvider, (previous, next) {
      //UserProvider에서 변경사항이 생겼을 때만 AuthProvider에서 알려줌
      if (previous != next) {
        notifyListeners();
      }
    });
  }
}
