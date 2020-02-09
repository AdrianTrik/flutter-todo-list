import 'package:firebase_auth/firebase_auth.dart';

class UserService {
  static Future<FirebaseUser> getCurrentUser() async {
    return await FirebaseAuth.instance.currentUser();
  }

  static Future<FirebaseUser> login() async {
    final user = await getCurrentUser();
    if (user != null) {
      return user;
    } else {
      final result = await FirebaseAuth.instance.signInAnonymously();
      return result.user;
    }
  }
}
