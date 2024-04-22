import 'package:flutter/material.dart';

class ProfileUserPage extends StatelessWidget {
  final int userId;

  const ProfileUserPage({Key? key, required this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil de Usuario'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProfileSection(
              title: 'Información personal',
              userId: userId,
            ),
            ProfileSection(
              title: 'Habilidades',
              userId: userId,
            ),
            ProfileSection(
              title: 'Intereses',
              userId: userId,
            ),
            ProfileSection(
              title: 'Reportes',
              userId: userId,
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileSection extends StatelessWidget {
  final String title;
  final int userId;

  const ProfileSection({Key? key, required this.title, required this.userId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          // Aquí puedes agregar el contenido específico de cada sección
          // Por ejemplo, cuadros de texto, listas, etc.
        ],
      ),
    );
  }
}
