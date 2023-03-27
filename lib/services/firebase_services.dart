import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:movies_app/data/database.dart';
import '../screens/home.dart';

class FirebaseServices {
  final _googleSignIn = GoogleSignIn();
  User? user;
  late String userID;

  signUpWithEmail(BuildContext context, String email, String password) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {
        user = FirebaseAuth.instance.currentUser;
        print("Created new user via Email/Password");
      }).then((value) => {Navigator.of(context).pop()});
    } catch (e) {
      print("Sign Up Error: $e");
    }
  }

  signInWithEmail(BuildContext context, String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) => {
                print("Signed in successfully"),
                // userID = FirebaseAuth.instance.currentUser!.uid,
                // MoviesDataBase().currUser = userID,
              user = FirebaseAuth.instance.currentUser,
          Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => HomeScreen()),
                    (route) => false)
              });
    } catch (e) {
      print("Sign In Error: $e");
    }
  }

  resetButton(BuildContext context, String email) async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: email)
          .then((value) => {
                print("Password reset link sent."),
              })
          .then((value) => Navigator.pop(context));
    } catch (e) {
      print("Password reset error: $e");
    }
  }

  signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;
        final AuthCredential authCredential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );
        await FirebaseAuth.instance
            .signInWithCredential(authCredential)
            .then((value) => print("Google sign in successful"));
        // userID = FirebaseAuth.instance.currentUser!.uid;
        // MoviesDataBase().currUser = userID;
        user = FirebaseAuth.instance.currentUser;
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
          (route) => false,
        );
      }
    } on FirebaseAuthException catch (e) {
      print("Google Sign in error: $e");
    }
  }

  signOut() async {
    await FirebaseAuth.instance.signOut();
    await _googleSignIn.signOut();
  }
}
