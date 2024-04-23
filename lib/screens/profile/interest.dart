import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../widgets/ProfileUser/intereses/interest_user_Cuadro.dart';

class InterestsUserPage extends StatefulWidget {
  final int userId;

  const InterestsUserPage({Key? key, required this.userId}) : super(key: key);

  @override
  _InterestsUserPageState createState() => _InterestsUserPageState();
}

class _InterestsUserPageState extends State<InterestsUserPage> {
  late Map<String, dynamic> _userData;
  List<String> _interests = [];

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
        _interests = List<String>.from(_userData['intereses']);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Actualiza tus intereses",
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
          itemCount: _interests.length + 1, // +1 para el botón flotante
          itemBuilder: (context, index) {
            if (index < _interests.length) {
              final interest = _interests[index];
              return InterestsUserCuadro(
                interest: interest,
                onDelete: () {
                  setState(() {
                    _interests.removeAt(index);
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
          _agregarInteres(context);
        },
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  void _agregarInteres(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String nuevoInteres = '';

        return AlertDialog(
          title: Text('Agregar Interés'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                onChanged: (value) => nuevoInteres = value,
                decoration: InputDecoration(labelText: 'Interés'),
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
                // Agregar el nuevo interés a la lista y reconstruir el widget
                setState(() {
                  _interests.add(nuevoInteres);
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
