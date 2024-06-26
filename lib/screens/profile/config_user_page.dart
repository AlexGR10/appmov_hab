import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../widgets/ProfileUser/config_user/config_user_CuadrosText.dart';

class ConfigUserPage extends StatefulWidget {
  final int userId;

  const ConfigUserPage({Key? key, required this.userId}) : super(key: key);

  @override
  _ConfigUserPageState createState() => _ConfigUserPageState();
}

class _ConfigUserPageState extends State<ConfigUserPage> {
  late Map<String, dynamic> _userData ={};

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
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Edita tu información",
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _userData != null
                        ? Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                UserAttributeEditField(
                                  id: widget.userId,
                                  label: 'Nombre',
                                  defaultText: _userData['nombre'] ?? '',
                                ),
                                SizedBox(height: 8), // Espacio entre widgets
                                UserAttributeEditField(
                                  id: widget.userId,
                                  label: 'Apellido',
                                  defaultText: _userData['apellido'] ?? '',
                                ),
                                SizedBox(height: 8), // Espacio entre widgets
                                UserAttributeEditField(
                                  id: widget.userId,
                                  label: 'Usuario',
                                  defaultText: _userData['usuario'] ?? '',
                                ),
                                SizedBox(height: 8), // Espacio entre widgets
                                UserAttributeEditField(
                                  id: widget.userId,
                                  label: 'Email',
                                  defaultText: _userData['email'] ?? '',
                                ),
                                SizedBox(height: 8), // Espacio entre widgets
                                UserAttributeEditField(
                                  id: widget.userId,
                                  label: 'Contraseña',
                                  defaultText: _userData['password'] ?? '',
                                ),
                                SizedBox(height: 8), // Espacio entre widgets
                                UserAttributeEditField(
                                  id: widget.userId,
                                  label: 'Idioma',
                                  defaultText: _userData['idioma'] ?? '',
                                ),
                                SizedBox(height: 8), // Espacio entre widgets
                                UserAttributeEditField(
                                  id: widget.userId,
                                  label: 'País',
                                  defaultText: _userData['pais'] ?? '',
                                ),
                                SizedBox(height: 8), // Espacio entre widgets
                                UserAttributeEditField(
                                  id: widget.userId,
                                  label: 'Estado',
                                  defaultText: _userData['estado'] ?? '',
                                ),
                                SizedBox(height: 8), // Espacio entre widgets
                                UserAttributeEditField(
                                  id: widget.userId,
                                  label: 'Grado',
                                  defaultText: _userData['grado'] ?? '',
                                ),
                              ],
                            ),
                          )
                        : const Center(
                            child: CircularProgressIndicator(),
                          ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
