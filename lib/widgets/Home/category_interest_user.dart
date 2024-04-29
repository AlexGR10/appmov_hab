import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:proyect_example/widgets/Home/little_avatar.dart';

class CategoryInterestUser extends StatefulWidget {
  final String interest;
  final int userId;
  final int maxUsersToShow;

  const CategoryInterestUser({
    Key? key,
    required this.interest,
    required this.userId,
    this.maxUsersToShow = 6,
  }) : super(key: key);

  @override
  _CategoryInterestUserState createState() => _CategoryInterestUserState();
}

class _CategoryInterestUserState extends State<CategoryInterestUser> {
  List<Map<String, dynamic>> _users = [];
  int _displayedUsersCount = 0;

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

        // Agregar calificación y cantidad de veces al usuario
        _users.forEach((user) {
          final habilidad = user['habilidades'].firstWhere(
              (habilidad) => habilidad['nombre'] == widget.interest);
          user['calificacion'] = habilidad['calificacion'] as double?;
          user['cantCalif'] = habilidad['cantCalif'] as int?;
        });

        // Ordenar usuarios por calificación y cantidad de veces
        _users.sort((a, b) {
          final double aCalif = a['calificacion'] ?? 0;
          final double bCalif = b['calificacion'] ?? 0;
          final int aCant = a['cantCalif'] ?? 0;
          final int bCant = b['cantCalif'] ?? 0;

          if (aCalif == bCalif) {
            return bCant.compareTo(aCant);
          } else {
            return bCalif.compareTo(aCalif);
          }
        });

        _displayedUsersCount = _users.length > widget.maxUsersToShow
            ? widget.maxUsersToShow
            : _users.length;
      });
    } catch (e) {
      print('Error loading users: $e');
    }
  }

  void showMoreUsers() {
    setState(() {
      _displayedUsersCount += widget.maxUsersToShow;
      if (_displayedUsersCount > _users.length) {
        _displayedUsersCount = _users.length;
      }
    });
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
              Flexible(
                child: Text(
                  'Te puede interesar ${widget.interest}:',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _users.isEmpty
              ? Text(
                  'Aún no hay nadie con esta habilidad',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                )
              : Wrap(
                  spacing: 8.0, // Espacio horizontal entre los avatares
                  runSpacing:
                      8.0, // Espacio vertical entre las filas de avatares
                  children: _users.take(_displayedUsersCount).map((user) {
                    final calificacion = user['calificacion'] as double?;
                    final cantCalif = user['cantCalif'] as int?;
                    return LittleAvatar(
                      backgroundColor: Colors.white,
                      icon: Icons.person,
                      iconColor: Colors.orange,
                      size: 40.0,
                      id: user['id'].toString(),
                      nombre: user['nombre'],
                      habilidad: widget.interest,
                      calificacion: calificacion,
                      cantCalif: cantCalif,
                    );
                  }).toList(),
                ),
          if (_users.length > _displayedUsersCount)
            ElevatedButton(
              onPressed: showMoreUsers,
              child: const Text('Ver más'),
            ),
        ],
      ),
    );
  }
}
