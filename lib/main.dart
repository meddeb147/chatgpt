import 'package:flutter/material.dart';
import 'package:voice_to_text/speech.dart';
import 'package:voice_to_text/splachscreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: splach(),
    );
  }
}

