import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../widgets/create_account_page.dart';
import '../widgets/forgot_password_page.dart';

class LoginPage extends StatefulWidget {
  final void Function(int)
      onIdReceive; // Define la función de devolución de llamada

  const LoginPage({Key? key, required this.onIdReceive}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usuarioController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  List<Map<String, dynamic>> _users = [];
  int id_inicial = 1;

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

    // Busca el usuario autenticado en la lista _users
    Map<String, dynamic>? authenticatedUser = _users.firstWhere(
      (user) => user['usuario'] == usuario && user['password'] == password,
    );

    if (authenticatedUser != null) {
      // Extrae el ID del usuario autenticado
      int userId = authenticatedUser['id'];

      // Llama a la función de devolución de llamada para pasar el ID
      widget.onIdReceive(userId);

      // Navega a BottomNavigator
      Navigator.pushReplacementNamed(
        context,
        '/bottomNavigator',
      );
    } else {
      // Muestra un diálogo de error si la autenticación falla
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Error de inicio de sesión'),
            content: const Text('Usuario o contraseña incorrectos.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('OK'),
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
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 236, 135, 19),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(100),
            ),
          ),
          child: const Center(
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
                decoration: const InputDecoration(
                  labelText: 'Usuario',
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: TextField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  labelText: 'Contraseña',
                ),
                obscureText: true,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _signInWithEmailPassword(context),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                  const Color.fromARGB(255, 236, 135, 19),
                ), // Color de fondo del botón
              ),
              child: const Text(
                'Iniciar sesión',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white, // Color del texto del botón
                ),
              ),
            ),
            const SizedBox(height: 50),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CreateAccountPage(),
                  ),
                );
              },
              child: const Text(
                'Crear cuenta',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ForgotPasswordPage(),
                  ),
                );
              },
              child: const Text(
                '¿Olvidaste tu contraseña?',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
