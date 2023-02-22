import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'signup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyDrw6N0jkohTb6G1__lDBeOreNlmCODNag',
      appId: "1:876524938962:android:cb13c4e7bdedbdb9c96f0b",
      messagingSenderId: "876524938962",
      projectId: "flutter-whmp-project",
    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login Demo',
      home: const LoginScreen(),
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{
        '/signup': (BuildContext context) => SignupPage(),
      },
    );
  }
}
