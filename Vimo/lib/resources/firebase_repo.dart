import 'package:Vimo/resources/firebase_methods.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseRepo {
  Firebasemethods _firebaseMethods = Firebasemethods();
  Future<User> getCurrentUser() => _firebaseMethods.getCurrentUser();

  Future<UserCredential> signIn() => _firebaseMethods.signIn();
  Future<bool> authenticateUser(User user) =>
      _firebaseMethods.authenticateUser(user);

  Future<void> addDataToDb(User user) => _firebaseMethods.addDataToDb(user);
}
