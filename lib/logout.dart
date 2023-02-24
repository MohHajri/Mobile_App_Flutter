import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class Signout extends StatefulWidget {
  const Signout({super.key});

  @override
  State<Signout> createState() => _SignoutState();
}

class _SignoutState extends State<Signout> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Placeholder(),
    );
  }
}
