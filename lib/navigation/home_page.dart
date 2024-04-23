import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:proyect_example/screens/home/users_details.dart';
import 'package:proyect_example/widgets/Home/category_interest_user.dart';

class HomePage extends StatefulWidget {
  final int userId; // Agregar el parámetro userId

  const HomePage({Key? key, required this.userId}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> _userInterests = [];
  String _activeUserName =
      ''; // Variable para almacenar el nombre del usuario activo

  @override
  void initState() {
    super.initState();
    readJson();
  }

  Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/users.json');
    final List<dynamic> data = json.decode(response)["users"];

    // Obtener el nombre del usuario activo
    final user = data.firstWhere((user) => user['id'] == widget.userId,
        orElse: () => {});
    _activeUserName = user['nombre'] ?? '';

    setState(() {
      // Obtener los intereses del usuario activo
      _userInterests = List<String>.from(user['intereses'] ?? []);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Color.fromARGB(255, 236, 135, 19),
                width: 0.8,
              ),
            ),
          ),
          child: Row(
            children: [
              Text(
                'Hola ',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Text(
                _activeUserName, // Mostrar el nombre del usuario activo
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 236, 135, 19),
                ),
              ),
            ],
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: _userInterests.length,
        itemBuilder: (context, index) {
          final interest = _userInterests[index];
          return CategoryInterestUser(
              interest: interest, userId: widget.userId);
        },
      ),
    );
  }
}
