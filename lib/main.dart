import 'dart:async';
import 'package:flutter/material.dart';
import 'package:proyect_example/screens/login_page.dart';
import 'package:proyect_example/widgets/create_account_page.dart';
import 'package:proyect_example/navigation/bottom_navigator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

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
        '/': (context) => const WelcomePage(),
        '/login': (context) => LoginPage(),
        '/createAccount': (context) => CreateAccountPage(),
        '/bottomNavigator': (context) => const BottomNavigator(),
      },
      initialRoute: '/',
    );
  }
}

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  bool _isAnimationEnabled = true;

  @override
  void initState() {
    super.initState();
    if (_isAnimationEnabled) {
      Timer(const Duration(seconds: 2), () {
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 900),
            transitionsBuilder: (BuildContext context,
                Animation<double> animation,
                Animation<double> secondaryAnimation,
                Widget child) {
              return SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0.0, 1.0), // Empieza desde abajo
                  end: Offset.zero,
                ).animate(animation),
                child: child,
              );
            },
            pageBuilder: (BuildContext context, Animation<double> animation,
                Animation<double> secondaryAnimation) {
              return LoginPage();
            },
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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
