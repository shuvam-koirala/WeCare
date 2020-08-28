import 'package:firebase_auth/firebase_auth.dart';

class Service {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<String> get user {
    return _auth.onAuthStateChanged.map((FirebaseUser user) => user?.uid);
  }

  @override
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.exception);
    }
  }

  Future currentUser() async {
    try {
      FirebaseUser user = await _auth.currentUser();
      return user.uid;
    } catch (e) {
      print(e.exception);
    }
  }
}
