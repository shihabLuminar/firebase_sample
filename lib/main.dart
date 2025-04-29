import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_sample/controler/login_screen_controller.dart';
import 'package:firebase_sample/controler/registration_screen_contrller.dart';
import 'package:firebase_sample/firebase_options.dart';
import 'package:firebase_sample/views/registration_screen/registration_screen.dart';
import 'package:firebase_sample/views/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => RegistrationScreenContrller(),
        ),
        ChangeNotifierProvider(create: (context) => LoginScreenController()),
      ],
      child: MaterialApp(home: SplashScreen()),
    );
  }
}
