import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_sample/utils/app_utils.dart';
import 'package:firebase_sample/views/home_screen/home_scree.dart';
import 'package:flutter/material.dart';

class LoginScreenController with ChangeNotifier {
  Future<void> onLogin({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (credential.user != null) {
        AppUtils.showSnackbar(
          context,
          message: "Login successful",
          bgColor: Colors.green,
        );

        // navigate to home screen  on successful registration
        // Navigator.pushReplacement(
        //   context,
        //   MaterialPageRoute(builder: (context) => HomeScreen()),
        // );
      }
    } on FirebaseAuthException catch (e) {
      AppUtils.showSnackbar(context, message: e.code, bgColor: Colors.green);
    }
  }
}
