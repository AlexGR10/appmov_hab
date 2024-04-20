import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../widgets/create_account_page.dart';
import '../widgets/forgot_password_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usuarioController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  List<Map<String, dynamic>> _users = [];

  @override
  void initState() {
    super.initState();
    loadUsers(); // Llama a loadUsers() al iniciar la página
  }

  Future<void> loadUsers() async {
    final String usersJson = await rootBundle.loadString('assets/users.json');
    final List<dynamic> data = jsonDecode(usersJson)["users"];

    setState(() {
      _users = data
          .map((item) => {
                "usuario": item["usuario"],
                "password": item["password"],
                "id": item["id"],
              })
          .toList();
    });
  }

  void _signInWithEmailPassword(BuildContext context) {
    String usuario = _usuarioController.text.trim();
    String password = _passwordController.text.trim();

    bool isAuthenticated = _users.any(
        (user) => user['usuario'] == usuario && user['password'] == password);

    if (isAuthenticated) {
      Navigator.pushReplacementNamed(context, '/bottomNavigator');
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Error de inicio de sesión'),
            content: Text('Usuario o contraseña incorrectos.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(MediaQuery.of(context).size.height * 0.3),
        child: Container(
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 236, 135, 19),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(100),
            ),
          ),
          child: Center(
            child: Text(
              "Logo",
              style: TextStyle(
                fontSize: 40,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: TextField(
                controller: _usuarioController,
                decoration: InputDecoration(
                  labelText: 'Usuario',
                ),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Contraseña',
                ),
                obscureText: true,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _signInWithEmailPassword(context),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                  Color.fromARGB(255, 236, 135, 19),
                ), // Color de fondo del botón
              ),
              child: Text(
                'Iniciar sesión',
                style: TextStyle(
                  color: Colors.white, // Color del texto del botón
                ),
              ),
            ),
            SizedBox(height: 50),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CreateAccountPage(),
                  ),
                );
              },
              child: Text('Crear cuenta'),
            ),
            SizedBox(height: 10),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ForgotPasswordPage(),
                  ),
                );
              },
              child: Text('¿Olvidaste tu contraseña?'),
            ),
          ],
        ),
      ),
    );
  }
}
