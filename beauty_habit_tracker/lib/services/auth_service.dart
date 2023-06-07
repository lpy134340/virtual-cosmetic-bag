import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  getCurrentUserUID() async {
    // ignore: await_only_futures
    final User? user = await _auth.currentUser;
    final uid = user?.uid;
    return uid;
  }

  Future<void> signIn(email, password) async {
    if (email == "" || password == "" || email == null || password == null) {
      throw Exception("Both email and password are needed.");
    }
    try {
      // ignore: unused_local_variable
      final credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw Exception('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        throw Exception('Wrong password provided for that user.');
      }
    }
  }
}
