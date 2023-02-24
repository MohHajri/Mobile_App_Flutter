import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:grade_five_whmp/splash_screen.dart';
import 'signup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import "homeScreen.dart";
// import 'splash_screen.dart';

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
  final prefs = await SharedPreferences.getInstance();
  final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
  final user = FirebaseAuth.instance.currentUser;
  runApp(MyApp(isLoggedIn: isLoggedIn, user: user));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  final User? user;
  const MyApp({Key? key, required this.isLoggedIn, required this.user})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login Demo',
      // home: isLoggedIn ? MyHomePage(user: user!) : LoginScreen(),
      home: const SplashScreen(),
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{
        '/signup': (BuildContext context) => SignupPage(),
      },
    );
  }
}
