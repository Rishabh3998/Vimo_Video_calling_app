import 'dart:ffi';
import 'package:Vimo/Models/user.dart';
import 'package:Vimo/utils/utilities.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Firebasemethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  GoogleSignIn _googleSignIn = GoogleSignIn();
  static final FirebaseFirestore firestore = FirebaseFirestore.instance;

  //User class
  Cust user = Cust();

  Future<User> getCurrentUser() async {
    User currentuser;
    currentuser = await _auth.currentUser;
    return currentuser;
  }

  Future<UserCredential> signIn() async {
    GoogleSignInAccount _signInAccount = await _googleSignIn.signIn();
    GoogleSignInAuthentication _signInAuthentication =
        await _signInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: _signInAuthentication.accessToken,
        idToken: _signInAuthentication.idToken);

    UserCredential user = await _auth.signInWithCredential(credential);
    return user;
  }

  Future<bool> authenticateUser(User user) async {
    QuerySnapshot result = await firestore
        .collection("Users")
        .where("email", isEqualTo: user.email)
        .get();

    final List<DocumentSnapshot> docs = result.docs;

    return docs.length == 0 ? true : false;
  }

  Future<Void> addDataToDb(User currentUser) async {
    String username = Utils.getUsername(currentUser.email);

    user = Cust(
        uid: currentUser.uid,
        email: currentUser.email,
        name: currentUser.displayName,
        profilePhoto: currentUser.photoURL,
        username: username);

    firestore.collection("Users").doc(currentUser.uid).set(user.toMap(user));
  }
}
