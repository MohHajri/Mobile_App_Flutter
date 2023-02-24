import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login.dart';
import 'package:shared_preferences/shared_preferences.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class BmiCalculator extends StatefulWidget {
  const BmiCalculator({Key? key}) : super(key: key);

  @override
  _BmiCalculatorState createState() => _BmiCalculatorState();
}

class _BmiCalculatorState extends State<BmiCalculator> {
  late double _height;
  late double _weight;
  late int _age;
  String _note = "";

  void _saveUserLoggedInState(bool isLoggedIn) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLoggedIn', isLoggedIn);
  }

  void _logout(BuildContext context) async {
    await _auth.signOut();
    _saveUserLoggedInState(false); // add this line
    try {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (BuildContext context) => LoginScreen()),
        (route) => false,
      );
    } catch (e) {
      debugPrint("Error navigating to login screen: $e");
    }
  }

  double _calculateBMI() {
    double bmi = _weight / ((_height / 100) * (_height / 100));
    return double.parse(bmi.toStringAsFixed(2));
  }

  void _onPressed() {
    double bmi = _calculateBMI();

    if (_age < 20 || _age > 80) {
      _note = "Age must be between 20 and 80";
    } else if (bmi < 10 || bmi > 50) {
      _note = "BMI must be between 10 and 50";
    } else {
      _note = "";
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Your BMI"),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Your BMI is ${bmi.toStringAsFixed(2)}"),
              const SizedBox(height: 16),
              Text("Note: $_note"),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("BMI Calculator"),
        actions: [
          IconButton(
            onPressed: () => _logout(context),
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextFormField(
            decoration: const InputDecoration(
              labelText: "Enter your height in cm",
            ),
            keyboardType: TextInputType.number,
            onChanged: (value) {
              setState(() {
                _height = double.tryParse(value) ?? 0;
              });
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
              labelText: "Enter your weight in kg",
            ),
            keyboardType: TextInputType.number,
            onChanged: (value) {
              setState(() {
                _weight = double.tryParse(value) ?? 0;
              });
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
              labelText: "Enter your age",
            ),
            keyboardType: TextInputType.number,
            onChanged: (value) {
              setState(() {
                _age = int.tryParse(value) ?? 0;
              });
            },
          ),
          ElevatedButton(
            onPressed: _onPressed,
            child: const Text("Calculate"),
          ),
        ],
      ),
    );
  }
}
