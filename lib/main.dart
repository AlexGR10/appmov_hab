import 'dart:async';
import 'package:flutter/material.dart';
import 'package:proyect_example/screens/login_page.dart';
import 'package:proyect_example/widgets/Login/create_account_page.dart';
import 'package:proyect_example/navigation/bottom_navigator.dart';
import 'screens/profile/config_user_page.dart';
import 'screens/profile/skills.dart';
import 'screens/profile/interest.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int id_receive = 18;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Habilidades',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 236, 135, 19),
        ),
        useMaterial3: true,
      ),
      routes: {
        '/login': (context) => LoginPage(onIdReceive: (id) {
              setState(() {
                id_receive = id;
              });
            }),
        '/createAccount': (context) => CreateAccountPage(),
        '/bottomNavigator': (context) =>
            BottomNavigator(id_receive: id_receive),
        '/welcome': (context) => const WelcomePage(),
        '/config_user_page': (context) => ConfigUserPage(userId: id_receive),
        '/skills_user_page': (context) => SkillsUserPage(userId: id_receive),
        '/interest_user_page': (context) =>
            InterestsUserPage(userId: id_receive),
      },
      initialRoute: '/bottomNavigator',
    );
  }
}

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, '/login');
    });

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 236, 135, 19), // Fondo naranja
          borderRadius: BorderRadius.only(
            bottomLeft:
                Radius.circular(200.0), // Borde inferior derecho redondeado
          ),
        ),
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'SkillScape',
                style: TextStyle(
                  fontSize: 40,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
