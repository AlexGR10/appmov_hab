import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UserDetails extends StatelessWidget {
  final String id;
  final String habilidad;

  const UserDetails({
    Key? key,
    required this.id,
    required this.habilidad,
  }) : super(key: key);

  Future<Map<String, dynamic>> _loadUserData(String id) async {
    try {
      final String response = await rootBundle.loadString('assets/users.json');
      final List<dynamic> data = json.decode(response)["users"];
      final userData = data.firstWhere((user) => user['id'].toString() == id);
      return userData;
    } catch (e) {
      print('Error loading user data: $e');
      return {};
    }
  }

  void _sendFriendRequest(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        TextEditingController messageController = TextEditingController();
        return AlertDialog(
          title: Text("Enviar solicitud"),
          content: TextField(
            controller: messageController,
            decoration: InputDecoration(hintText: "Mensaje personalizado"),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancelar"),
            ),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Solicitud Enviada')),
                );
                Navigator.of(context).pop();
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: _loadUserData(id),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }
        if (snapshot.hasError || !snapshot.hasData) {
          return Text('Error cargando datos del usuario');
        }
        final userData = snapshot.data!;
        final nombre = '${userData['nombre']} ${userData['apellido']}';
        final usuario = '@${userData['usuario']}';
        final idiomas = (userData['idiomas'] as List).join(', ');
        final habilidades = userData['habilidades'] as List<dynamic>;
        habilidades.sort((a, b) => a['nombre'] == habilidad ? -1 : 1);
        final intereses = (userData['intereses'] as List).join(', ');
        final email = userData['email'];
        final edad = userData['edad'];
        final pais = userData['pais'];
        final estado = userData['estado'];
        final grado = userData['grado'];

        return Scaffold(
          appBar: AppBar(),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
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
                SizedBox(height: 16),
                Text(
                  nombre,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  usuario,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16),
                Container(
                  color: Colors.grey[200],
                  padding: EdgeInsets.all(12),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Habilidades:',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: habilidades.map<Widget>((habilidad) {
                          return ListTile(
                            title: Text(
                              habilidad['nombre'],
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Calificación: ${habilidad['calificacion']}',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                ),
                                Text(
                                  'Cantidad de Calificaciones: ${habilidad['cantCalif']}',
                                  style: TextStyle(
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
                SizedBox(height: 16),
                Container(
                  color: Colors.grey[200],
                  padding: EdgeInsets.all(12),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Intereses:',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        intereses,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                Container(
                  color: Colors.grey[200],
                  padding: EdgeInsets.all(12),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Información:',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
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
          floatingActionButton: FloatingActionButton(
            onPressed: () => _sendFriendRequest(context),
            tooltip: 'Enviar solicitud',
            child: Icon(Icons.person_add),
          ),
        );
      },
    );
  }
}
