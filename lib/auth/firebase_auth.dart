import 'package:firebase_auth/firebase_auth.dart';

class AuthHelper {
  static User? get user => FirebaseAuth.instance.currentUser;

  static bool get isUserSignedIn {
    if (user != null) {
      // User is signed In
      return true;
    }
    return false;
  }

  static Future<void> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    // ADD ERROR HANDLING
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email.trim(),
      password: password.trim(),
    );
  }

  static Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    // ADD ERROR HANDLING
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email.trim(),
      password: password.trim(),
    );
  }

  static Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
