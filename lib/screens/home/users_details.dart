import 'package:flutter/material.dart';

class UserDetails extends StatelessWidget {
  final Map<String, dynamic> user;

  const UserDetails({Key? key, required this.user}) : super(key: key);

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
                  backgroundColor: Color.fromARGB(255, 236, 135, 19),
                  child: Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 60,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                '${user['nombre']} ${user['apellido']}',
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
              Column(
                children:
                    (user['habilidades'] as List).map<Widget>((habilidad) {
                  return ListTile(
                    title: Text(
                      habilidad['nombre'],
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      habilidad['descripcion'],
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                    trailing: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'Calificación: ${habilidad['calificacion']}',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                        Text(
                          'Cantidad de Calificaciones: ${habilidad['cantCalif']}',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
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
              Text('Correo: ${user['email']}'),
            ],
          ),
        ),
      ),
    );
  }
}
