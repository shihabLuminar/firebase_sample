import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_sample/utils/app_utils.dart';
import 'package:firebase_sample/views/home_screen/home_scree.dart';
import 'package:flutter/material.dart';

class RegistrationScreenContrller with ChangeNotifier {
  Future<void> onRegister({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      if (credential.user != null) {
        AppUtils.showSnackbar(
          context,
          message: "User registration successful",
          bgColor: Colors.green,
        );

        // navigate to home screen  on successful registration
        Navigator.popUntil(context, (route) => route.isFirst);
      }
    } on FirebaseAuthException catch (e) {
      //show error messages based on firebse exception
      if (e.code == 'weak-password') {
        AppUtils.showSnackbar(
          context,
          message: 'The password provided is too weak.',
        );
      } else if (e.code == 'email-already-in-use') {
        AppUtils.showSnackbar(
          context,
          message: 'The account already exists for that email.',
        );
      }
    } catch (e) {
      // print any other exceptions
      AppUtils.showSnackbar(context, message: e.toString());
    }
  }
}
