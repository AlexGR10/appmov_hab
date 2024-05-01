import 'package:flutter/material.dart';

class ProfileUserSection extends StatelessWidget {
  final String title;
  final int userId;
  final String nextPage; // Nueva propiedad para indicar la página siguiente

  const ProfileUserSection({
    Key? key,
    required this.title,
    required this.userId,
    required this.nextPage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navegar a la página siguiente al hacer clic en el widget
        Navigator.pushNamed(context, nextPage);
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.only(bottom: 8, left: 16, right: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(color: Color.fromARGB(255, 0, 0, 0), width: 0.8),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 236, 135, 19), // Fondo naranja
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.arrow_forward,
                color: Colors.white, // Ícono blanco
              ),
            ),
          ],
        ),
      ),
    );
  }
}