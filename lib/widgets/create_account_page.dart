import 'package:flutter/material.dart';

class CreateAccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crear cuenta'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Formulario para crear cuenta
            // Aquí puedes tener campos como correo electrónico, contraseña, etc.
            ElevatedButton(
              onPressed: () {
                // Lógica para crear la cuenta
                // Por ejemplo, enviar datos a la base de datos, etc.
                // Una vez que se crea la cuenta, navega de regreso a la página de inicio de sesión
                Navigator.pop(context);
              },
              child: Text('Crear cuenta'),
            ),
          ],
        ),
      ),
    );
  }
}
