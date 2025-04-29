import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_sample/views/home_screen/home_scree.dart';
import 'package:firebase_sample/views/login_screen/login_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isSplash = true;
  @override
  void initState() {
    Future.delayed(Duration(seconds: 3)).then((value) {
      isSplash = false;
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (isSplash) {
      return const Scaffold(
        body: Center(
          child: Icon(Icons.flutter_dash, size: 100, color: Colors.blue),
        ),
      );
    } else {
      return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            return HomeScreen();
          } else {
            return LoginScreen();
          }
        },
      );
    }
  }
}
