import 'package:flutter/material.dart';
import 'package:proyect_example/navigation/bottom_navigator.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Habilidades',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // ignore: prefer_const_constructors
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 255, 140, 0)),
        useMaterial3: true,
      ),
      home: const BottomNavigator(),
    );
  }
}
