// ignore_for_file: unused_import, unused_local_variable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService{

  Future <String> createAccountWithEmail(String email ,String password) async {
    try{
      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
      return "Account Created";
      

    }
    on FirebaseAuthException catch(e){
      
      return e.message.toString();
    }

  }

  Future <String> loginWithEmail (String email, String password) async {
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      return "Login Successfully";
    }
    on FirebaseAuthException catch(e){
      
      

      return e.message.toString();
    }
    
  }

  Future logout() async {
    await FirebaseAuth.instance.signOut();
  }

  Future <bool> isLoogedIn() async {
    var user = FirebaseAuth.instance.currentUser;
    return user != null;
  }

  // for login with Google
  Future <String> continueWithGoogle()async{
    try {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    //send auth request
    final GoogleSignInAuthentication gAuth = await googleUser!.authentication;

    //obtain new creditionals
    final creds = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken, 
      idToken: gAuth.idToken);

      //signin with credentials
      await FirebaseAuth.instance.signInWithCredential(creds);
      return "Google account login successfull...";


  }


  on FirebaseAuthException catch(e){
    return e.message.toString();
  }
  }
}