import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/material.dart';
import 'package:xml/xml.dart' as xml;
import '/widgets/ProfileUser/log_out/log_out.dart';

class NewConfig extends StatelessWidget {
  final int userId;

  const NewConfig({
    super.key,
    required this.userId,
  });


// Modificar _loadUserData para cargar el contenido del archivo XML seleccionado
 Future<Map<String, dynamic>> _loadUserData(String id) async {
    final String response = await rootBundle.loadString('assets/users.xml');
    final document = xml.XmlDocument.parse(response);
    final users = document.findAllElements('user');

    for (final user in users) {
      final userId = user.findElements('id').single.text;
      if (userId == id) {
        final userData = <String, dynamic>{};
        userData['id'] = userId;
        userData['nombre'] = user.findElements('nombre').single.text;
        userData['apellido'] = user.findElements('apellido').single.text;
        userData['usuario'] = user.findElements('usuario').single.text;
        userData['email'] = user.findElements('email').single.text;
        userData['edad'] = int.parse(user.findElements('edad').single.text);
        userData['idiomas'] = user
            .findElements('idiomas')
            .single
            .findElements('idioma')
            .map((e) => e.text)
            .toList();
        userData['pais'] = user.findElements('pais').single.text;
        userData['estado'] = user.findElements('estado').single.text;
        userData['grado'] = user.findElements('grado').single.text;

        final habilidades = user.findElements('habilidades').single;
        userData['habilidades'] =
            habilidades.findElements('habilidad').map((habilidad) {
          return {
            'nombre': habilidad.findElements('nombre').single.text,
            'descripcion': habilidad.findElements('descripcion').single.text,
            'calificacion': double.parse(
                habilidad.findElements('calificacion').single.text),
            'cantCalif':
                int.parse(habilidad.findElements('cantCalif').single.text),
          };
        }).toList();

        userData['intereses'] = user
            .findElements('intereses')
            .single
            .findElements('interes')
            .map((e) => e.text)
            .toList();

        // Obtener la imagen codificada en base64
        final base64String = user.findElements('imagen').single.text;
        userData['imagen'] = base64String;


        return userData;
      }
    }

    return {};
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: _loadUserData(userId.toString()),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError || !snapshot.hasData) {
          return const Center(child: Text('Error cargando datos del usuario'));
        }
        final userData = snapshot.data!;
        final nombre = '${userData['nombre']} ${userData['apellido']}';
        final usuario = '@${userData['usuario']}';
        final habilidades = userData['habilidades'] as List<dynamic>;
        habilidades.sort((a, b) => a['nombre'].compareTo(b['nombre']));
        final intereses = (userData['intereses'] as List).join(', ');
        final email = userData['email'];
        final edad = userData['edad'];
        final pais = userData['pais'];
        final estado = userData['estado'];
        final grado = userData['grado'];

        Uint8List bytesImage;
        final base64String = userData['imagen'] as String;
        bytesImage = base64.decode(base64String.replaceAll(RegExp(r'\s'), ''));

        return Scaffold(
          appBar: AppBar(),
          body: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: Image.memory(bytesImage).image,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        nombre,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        usuario,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    GestureDetector(
                      onTap: () {
                        // Navegar a la otra página aquí
                        Navigator.pushNamed(context, '/config_user_page');
                      },
                      child: Container(
                        color: Colors.grey[200],
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Información:',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text('Email: $email'),
                                  Text('Edad: $edad'),
                                  Text('País: $pais'),
                                  Text('Estado: $estado'),
                                  Text('Grado: $grado'),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    GestureDetector(
                      onTap: () {
                        // Navegar a la otra página aquí
                        Navigator.pushNamed(context, '/skills_user_page');
                      },
                      child: Container(
                        color: Colors.grey[200],
                        padding: const EdgeInsets.all(12),
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Habilidades:',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: habilidades.map<Widget>((habilidad) {
                                return ListTile(
                                  title: Text(
                                    habilidad['nombre'],
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    GestureDetector(
                      onTap: () {
                        // Navegar a la otra página aquí
                        Navigator.pushNamed(context, '/interest_user_page');
                      },
                      child: Container(
                        color: Colors.grey[200],
                        padding: const EdgeInsets.all(12),
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Intereses:',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              intereses,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const CerrarSesionButton(),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
