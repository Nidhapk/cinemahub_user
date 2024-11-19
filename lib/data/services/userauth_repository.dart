// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:userside/presentation/widget/custom_alertbox.dart';

class Repository {
  final FirebaseAuth firebase = FirebaseAuth.instance;
  sigin(String email, String password, BuildContext context) async {
    await firebase.signInWithEmailAndPassword(email: email, password: password);
  }

  signUp(String email, String password) async {
    try {
      await firebase.createUserWithEmailAndPassword(
          email: email, password: password);
      // await UserDatabaseServices().addUser(user);
    } on FirebaseAuthException catch (_) {
      rethrow;
    }
  }

  Future<void> sendVerificationLink() async {
    User? user = firebase.currentUser;

    if (user != null && !user.emailVerified) {
      try {
        await user.sendEmailVerification();
      } catch (e) {}
    } else {}
  }

  Future<void> checkVerified(BuildContext context, User user) async {
    await user.reload();
    User? refreshedUser = FirebaseAuth.instance.currentUser;

    if (refreshedUser != null && refreshedUser.emailVerified) {
      Navigator.of(context)
          .pushNamedAndRemoveUntil('/splash', (route) => false);
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return const CustomAlertBox(
              title: 'Email not verified',
              content: 'Please verify your email before proceeding.',
              confirmText: 'Ok');
        },
      );
    }
  }

  Future<UserCredential?> signInWithGoogle() async {
    try {
      final googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        return null;
      }
      final googleAuth = await googleUser.authentication;

      final cred = GoogleAuthProvider.credential(
          idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);
      return await firebase.signInWithCredential(cred);
    } on FirebaseAuthException catch (_) {
      rethrow;
    }
  }

  Future<void> sendResetPasswordLink(String email) async {
    try {
      await firebase.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (_) {
      rethrow;
    }
  }

  signOut() async {
    try {
      await firebase.signOut();
    } on FirebaseAuthException catch (_) {
      rethrow;
    }
  }
}
