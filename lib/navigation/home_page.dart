import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:proyect_example/screens/users_details.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> _users = [];

  @override
  void initState() {
    super.initState();
    readJson();
  }

  Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/home.json');
    final List<dynamic> data = json.decode(response)["users"];

    setState(() {
      _users = data
          .map((item) => {
                "nombre": item["nombre"],
                "habilidad": item["habilidad"],
                "pais": item["pais"],
                "estado": item["estado"],
                "idiomas": item["idiomas"],
                "correo": item["correo"],
                "numero": item["numero"],
                "video":item["video"],
              })
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: ListView.builder(
        itemCount: _users.length,
        itemBuilder: (context, index) {
          return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UserDetails(user: _users[index]),
                  ),
                );
              },
              child: Card(
                elevation: 4, // Elevación para un efecto de sombra
                margin: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 16), // Margen alrededor de la tarjeta
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      16), // Bordes redondeados para la tarjeta
                ),
                child: ListTile(
                  contentPadding:
                      const EdgeInsets.all(16), // Espaciado interno del ListTile
                  leading: const CircleAvatar(
                    backgroundColor: Colors.blue, // Color de fondo del avatar
                    child: Icon(
                      Icons.person, // Icono de perfil
                      color: Colors.white, // Color del icono
                    ),
                  ),
                  title: Text(
                    _users[index]['nombre'],
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    (_users[index]['habilidad'] as List).join(', '),
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                  trailing: const Icon(
                    Icons
                        .arrow_forward_ios, // Icono de flecha para indicar que se puede navegar
                    size: 20,
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            UserDetails(user: _users[index]),
                      ),
                    );
                  },
                ),
              ));
        },
      ),
    );
  }
}

