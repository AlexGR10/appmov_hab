import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:proyect_example/widgets/Home/little_avatar.dart';

class CategoryInterestUser extends StatefulWidget {
  final String interest;
  final int userId;

  const CategoryInterestUser({
    Key? key,
    required this.interest,
    required this.userId,
  }) : super(key: key);

  @override
  _CategoryInterestUserState createState() => _CategoryInterestUserState();
}

class _CategoryInterestUserState extends State<CategoryInterestUser> {
  List<Map<String, dynamic>> _users = [];

  @override
  void initState() {
    super.initState();
    loadUsers();
  }

  Future<void> loadUsers() async {
    try {
      final String response = await rootBundle.loadString('assets/users.json');
      final List<dynamic> data = json.decode(response)["users"];
      setState(() {
        _users = List<Map<String, dynamic>>.from(data.where((user) =>
            user['habilidades']
                .any((habilidad) => habilidad['nombre'] == widget.interest)));
      });
    } catch (e) {
      print('Error loading users: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.lightbulb_outline,
                color: Colors.orange,
              ),
              const SizedBox(width: 12),
              Text(
                'Te puede interesar ${widget.interest}:',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Column(
            children: _users.map((user) {
              final habilidades = user['habilidades'] as List<dynamic>;
              final habilidad = habilidades.firstWhere(
                  (habilidad) => habilidad['nombre'] == widget.interest,
                  orElse: () => null);
              if (habilidad != null) {
                final calificacion = habilidad['calificacion'] as double?;
                final cantCalif = habilidad['cantCalif'] as int?;
                return Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: LittleAvatar(
                    backgroundColor: Colors.grey,
                    icon: Icons.person,
                    iconColor: Colors.white,
                    size: 40.0,
                    id: user['id'].toString(),
                    nombre: user['nombre'],
                    habilidad: widget.interest,
                    calificacion: calificacion,
                    cantCalif: cantCalif,
                  ),
                );
              } else {
                return SizedBox(); // No se encontró la habilidad, retornar widget vacío
              }
            }).toList(),
          ),
        ],
      ),
    );
  }
}
