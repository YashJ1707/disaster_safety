import 'dart:async';
import 'package:disaster_safety/services/db.dart';
import 'package:disaster_safety/services/secure_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
// ;

class AuthMethods {
  final FirebaseAuth _auth;
  late UserCredential user;
  AuthMethods(this._auth);
  Stream<User?> get authStateChanges => _auth.authStateChanges();

//Sign in method no need to add data.
  // Future<UserCredential> signInWithGoogle() async {
  Future<void> signInWithGoogle() async {
    //first trigger authentication
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    //obtain the auth details
    if (googleUser != null) {
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      //create a new credentials
      final OAuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
      //saving the user data to shared preferences

      // // sign in method
      try {
        UserCredential firebaseUser =
            await FirebaseAuth.instance.signInWithCredential(credential);

        if (firebaseUser.user != null) {
          String uid = firebaseUser.user!.uid;

          await SecureStorage().setUserId(uid);

          // Check is already sign up
          final QuerySnapshot result = await FirebaseFirestore.instance
              .collection('users')
              .where('userid', isEqualTo: firebaseUser.user!.uid)
              .get();
          List<DocumentSnapshot> documents = result.docs;

          if (documents.isEmpty) {
            // Update data to server if new user
            Map<String, dynamic> userdata = {
              'uid': firebaseUser.user!.uid,
              'useremail': firebaseUser.user!.email,
              'displayname': firebaseUser.user!.displayName,
              'userid': firebaseUser.user!.uid,
            };

            DbMethods().signIn(userdata);
          }
        }

        // return firebaseUser;
      } catch (e) {
        print(e);
      }
    }
  }

//sign in with email and password

  Future<UserCredential?> signIn(
      {required BuildContext context,
      required String email,
      required String password}) async {
    //creating a provider
    //  UserCredential user;
    try {
      UserCredential user = await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      if (user.user != null) {
        await SecureStorage().setUserId(user.user!.uid);
        await SecureStorage().setUsername(email);
      }
      return user;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "wrong-password":
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Email Already in Use")));
          break;
        case "user-not-found":
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Account Does not Exists")));
          break;

        case "INVALID_LOGIN_CREDENTIALS":
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("Invalid Password")));
      }
      return null;
    }
  }

  Future<UserCredential?> signUp(
      {required BuildContext context,
      required String email,
      required String password}) async {
    try {
      UserCredential? user = await _auth.createUserWithEmailAndPassword(
          email: email.trim(), password: password.trim());

      return user;
    } on FirebaseAuthException catch (e) {
      print(e);
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Email Already in Use")));
      return null;
    } catch (e) {
      return null;
    }
  }

// Sign out method
  Future<void> signOut() async {
    await SecureStorage().setUserId(null);
    await SecureStorage().setUsername(null);
    await _auth.signOut();
  }

  Future<void> resetPassword(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
    await SecureStorage().setUserId(null);
    await SecureStorage().setUsername(null);
  }
}
