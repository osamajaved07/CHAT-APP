// ignore_for_file: unused_import, unused_local_variable, no_leading_underscores_for_local_identifiers, dead_code, deprecated_member_use, unused_field, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<String> createAccountWithEmail(String email, String password) async {
    // FirebaseFirestore _firestore = FirebaseFirestore.instance;

    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      // After creating the account, save user data in Firestore
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        await _firestore.collection('users').doc(user.uid).set({
          'email': email,
          'status': 'Online',
          'uid': user.uid,
        });
      }
      user!.updateProfile(displayName: email);

      return "Account Created";

      // _firestore.collection('users').doc();
    } on FirebaseAuthException catch (e) {
      return e.message.toString();
    }
  }

  Future<String> loginWithEmail(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
            email: email,
            password: password);
      await updateUserStatus('Online');

           
      return "Login Successfully";
    } on FirebaseAuthException catch (e) {
      return e.message.toString();
    }
  }

  Future logout() async {
    await FirebaseAuth.instance.signOut();
  }

  Future updateUserStatus(String status) async {
    User? user = _auth.currentUser;
    if (user != null) {
      await _firestore.collection('users').doc(user.uid).update({
        'status': status,
      });
      print('User status updated to: $status');
    }
  }

  Future<bool> isLoogedIn() async {
    var user = FirebaseAuth.instance.currentUser;
    return user != null;
  }

  // for login with Google
  Future<String> continueWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      //send auth request
      final GoogleSignInAuthentication gAuth = await googleUser!.authentication;

      //obtain new creditionals
      final creds = GoogleAuthProvider.credential(
          accessToken: gAuth.accessToken, idToken: gAuth.idToken);

      //signin with credentials
      await FirebaseAuth.instance.signInWithCredential(creds);
      return "Google account login successfull...";
    } on FirebaseAuthException catch (e) {
      return e.message.toString();
    }
  }
}
