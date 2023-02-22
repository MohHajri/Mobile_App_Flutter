import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'homeScreen.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  int _success = 1;
  String _userEmail = '';

  void _login() async {
    final User? user = (await _auth.signInWithEmailAndPassword(
      email: _emailController.text,
      password: _passwordController.text,
    ))
        .user;
    if (user != null) {
      setState(() {
        _success = 2;
        _userEmail = user.email!;
      });
      _navigateToHomePage();
    } else {
      setState(() {
        _success = 3;
      });
    }
  }

  void _navigateToHomePage() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (BuildContext context) => const MyHomePage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Stack(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.fromLTRB(15.0, 110.0, 0.0, 0.0),
                  child: const Text(
                    'Hello Hajri',
                    style:
                        TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
            child: Column(
              children: <Widget>[
                TextField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'EMAIL',
                    labelStyle: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.green),
                    ),
                  ),
                ),
                const SizedBox(height: 10.0),
                TextField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    labelText: 'PASSWORD',
                    labelStyle: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.green),
                    ),
                  ),
                  obscureText: true,
                ),
                const SizedBox(height: 5.0),
                Container(
                  alignment: const Alignment(1.0, 0.0),
                  padding: const EdgeInsets.only(top: 15.0, left: 20.0),
                  child: const InkWell(
                    child: Text(
                      'Forgot Password',
                      style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat',
                          decoration: TextDecoration.underline),
                    ),
                  ),
                ),
                Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      _success == 1
                          ? ''
                          : (_success == 2
                              ? 'Success signing in with $_userEmail'
                              : 'Failed'),
                      style: TextStyle(
                        color: _success == 1
                            ? Colors.black
                            : _success == 2
                                ? Colors.green
                                : Colors.red,
                      ),
                    )),
                const SizedBox(height: 40.0),
                Container(
                  height: 40.0,
                  child: Material(
                    borderRadius: BorderRadius.circular(20.0),
                    shadowColor: Colors.greenAccent,
                    color: Colors.green,
                    elevation: 7.0,
                    child: GestureDetector(
                      onTap: () async {
                        _login();
                      },
                      child: const Center(
                        child: Text(
                          'LOGIN',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Montserrat'),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      'New to my app?',
                      style: TextStyle(fontFamily: 'Montserrat'),
                    ),
                    const SizedBox(width: 5.0),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pushNamed('/signup');
                      },
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(
                            color: Colors.green,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline),
                      ),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
