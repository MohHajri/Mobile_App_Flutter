import 'package:flutter/material.dart';

class BmiCalculator extends StatelessWidget {
  const BmiCalculator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BMI Calculator'),
        // leading: IconButton(
        //   icon: const Icon(Icons.arrow_back),
        //   onPressed: () => Navigator.of(context).pop(),
        // ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {},
          ),
        ],
      ),
      body: const Center(
        child: Text('This is the BMI Calculator view.'),
      ),
    );
  }
}
