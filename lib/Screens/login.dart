import 'dart:developer';
import 'dart:io';

import 'package:chat/Screens/home_screen.dart';
import 'package:chat/helper/dialogs.dart';
import 'package:chat/services/apis.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  _signInGoogle() {
    Dialogs.showProgress(context);
    signInWithGoogle().then((user) {
      Navigator.pop(context);

      if (user != null) {
        if (kDebugMode) {
          print('User:${user.user}');
        }
        if (kDebugMode) {
          log("userAdditionalInfo:${user.additionalUserInfo}");
        }
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const HomePage()));
      }
    });
  }

  Future<UserCredential?> signInWithGoogle() async {
    try {
      var res = await InternetAddress.lookup('google.com');
      if (kDebugMode) {
        print("res11111:$res");
      }
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the requesty
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      return await APIs.auth.signInWithCredential(credential);
    } catch (e) {
      if (kDebugMode) {
        print("signin with google :$e");
      }
      Dialogs.showSnackbar(
          context, "check your internet connection and please try again");
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            _signInGoogle();
          },
          child: const Text("Login with google"),
        ),
      ),
    );
  }
}
