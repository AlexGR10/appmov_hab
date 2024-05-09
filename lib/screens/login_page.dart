import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../widgets/Login/create_account_page.dart';
import '../widgets/Login/forgot_password_page.dart';
import 'package:file_picker/file_picker.dart';

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
  }

  void _pickJsonFileAndFillFields() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['json'],
    );

    if (result != null) {
      final String jsonContent =
          await File(result.files.single.path!).readAsString();
      final List<dynamic> jsonData = jsonDecode(jsonContent)["users"];
      final Map<String, dynamic>? user = jsonData.firstWhere(
        (user) => user['id'] == 1,
        orElse: () => null,
      );

      if (user != null) {
        setState(() {
          _usuarioController.text = user['usuario'];
          _passwordController.text = user['password'];
        });
      } else {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text(
                  'No se encontró un usuario con ID 1 en el archivo JSON.'),
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
  }

  void _signInWithEmailPassword(BuildContext context) {
    String usuario = _usuarioController.text.trim();
    String password = _passwordController.text.trim();

    // Busca el usuario autenticado en los datos del JSON cargados en _pickJsonFileAndFillFields
    if (usuario.isNotEmpty && password.isNotEmpty) {
      if (usuario == 'juanito123' && password == 'juan123') {
        // Simulando autenticación exitosa
        int userId = 1;
        widget.onIdReceive(userId);
        Navigator.pushReplacementNamed(context, '/bottomNavigator');
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
    } else {
      // Muestra un diálogo de error si no se proporcionaron usuario o contraseña
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Error de inicio de sesión'),
            content:
                const Text('Por favor, introduce un usuario y una contraseña.'),
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
              onPressed: () {
                _pickJsonFileAndFillFields();
              },
              child: Text("Seleccionar archivo"),
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
