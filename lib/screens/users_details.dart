import 'package:flutter/material.dart';

class UserDetails extends StatelessWidget {
  final Map<String, dynamic> user;

  const UserDetails({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 120,
                width: 120,
                child: CircleAvatar(
                  backgroundColor: Colors.blue,
                  child: Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 60,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                user['nombre'],
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Habilidades:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                (user['habilidad'] as List).join(', '),
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      // Lógica para enviar solicitud
                    },
                    icon: const Icon(Icons.send),
                    label: const Text('Enviar solicitud'),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      // Lógica para enviar mensaje
                    },
                    icon: const Icon(Icons.message),
                    label: const Text('Enviar mensaje'),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Divider(
                color: Colors.grey[400],
                thickness: 1,
              ),
              const SizedBox(height: 24),
              Text('País: ${user['pais']}'),
              const SizedBox(height: 8),
              Text('Estado: ${user['estado']}'),
              const SizedBox(height: 16),
              Text('Idiomas: ${(user['idiomas'] as List).join(', ')}'),
              const SizedBox(height: 8),
              Text('Correo: ${user['correo']}'),
              const SizedBox(height: 8),
              Text('Número: ${user['numero']}'),
            ],
          ),
        ),
      ),
    );
  }
}


