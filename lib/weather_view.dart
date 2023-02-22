import 'package:flutter/material.dart';

class WeatherView extends StatelessWidget {
  const WeatherView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather View'),
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
        child: Text('This is the Weather view.'),
      ),
    );
  }
}
