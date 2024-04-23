import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../widgets/ProfileUser/skills/skills_user_Cuadro.dart';

class SkillsUserPage extends StatefulWidget {
  final int userId;

  const SkillsUserPage({Key? key, required this.userId}) : super(key: key);

  @override
  _SkillsUserPageState createState() => _SkillsUserPageState();
}

class _SkillsUserPageState extends State<SkillsUserPage> {
  late Map<String, dynamic> _userData;
  List<Map<String, dynamic>> _habilidades = [];

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    // Cargamos los datos del usuario desde el archivo users.json
    final String usersJson = await rootBundle.loadString('assets/users.json');
    final List<dynamic> data = jsonDecode(usersJson)["users"];

    // Buscamos el usuario por su ID
    final user = data.firstWhere((user) => user['id'] == widget.userId,
        orElse: () => null);

    if (user != null) {
      setState(() {
        _userData = Map<String, dynamic>.from(user);
        _habilidades =
            List<Map<String, dynamic>>.from(_userData['habilidades']);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Actualiza tus habilidades",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 236, 135, 19),
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Color.fromARGB(255, 236, 135, 19),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: ListView.builder(
          itemCount: _habilidades.length + 1, // +1 para el botón flotante
          itemBuilder: (context, index) {
            if (index < _habilidades.length) {
              final habilidad = _habilidades[index];
              final nombre = habilidad['nombre'];
              final descripcion = habilidad['descripcion'];
              return SkillsUserCuadro(
                nombre: nombre,
                descripcion: descripcion,
                onDelete: () {
                  setState(() {
                    _habilidades.removeAt(index);
                  });
                },
              );
            } else {
              return const SizedBox(
                  height: 80); // Espacio para el botón flotante
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromARGB(255, 236, 135, 19),
        onPressed: () {
          _agregarHabilidad(context);
        },
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  void _agregarHabilidad(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String nombre = '';
        String descripcion = '';

        return AlertDialog(
          title: Text('Agregar Habilidad'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                onChanged: (value) => nombre = value,
                decoration: InputDecoration(labelText: 'Nombre'),
              ),
              TextField(
                onChanged: (value) => descripcion = value,
                decoration: InputDecoration(labelText: 'Descripción'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                // Agregar la nueva habilidad a la lista y reconstruir el widget
                setState(() {
                  _habilidades.add({
                    'nombre': nombre,
                    'descripcion': descripcion,
                  });
                });
                Navigator.of(context).pop();
              },
              child: Text('Agregar'),
            ),
          ],
        );
      },
    );
  }
}
