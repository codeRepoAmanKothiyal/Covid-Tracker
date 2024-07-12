import 'package:covid_tracker/View/splash_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Covid Tracker",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(brightness: Brightness.dark,
        primarySwatch: Colors.blue
      ),
      home: SplashScreen(),
    );
  }
}