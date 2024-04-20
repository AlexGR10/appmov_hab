import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatelessWidget {
  void _resetPassword(BuildContext context) {
    // Aquí iría la lógica para enviar un correo electrónico de restablecimiento de contraseña
    // Puedes usar FirebaseAuth para enviar el correo de restablecimiento
    // Ejemplo: FirebaseAuth.instance.sendPasswordResetEmail(email: email);

    // Después de enviar el correo de restablecimiento, puedes mostrar un mensaje de confirmación al usuario
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('¡Correo enviado!'),
          content: Text(
              'Se ha enviado un correo electrónico con instrucciones para restablecer tu contraseña.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Cierra el diálogo
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recuperar contraseña'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Ingresa tu correo electrónico para restablecer tu contraseña.',
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            TextFormField(
              decoration: InputDecoration(labelText: 'Correo electrónico'),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _resetPassword(context),
              child: Text('Restablecer contraseña'),
            ),
          ],
        ),
      ),
    );
  }
}
