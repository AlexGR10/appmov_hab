import 'package:flutter/material.dart';

class ConfigUser extends StatelessWidget {
  const ConfigUser();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.orange, // Borde inferior naranja
                      width: .8, // Grosor de la línea delgada
                    ),
                  ),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Configuración",
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange, // Letras naranjas
                      ),
                    ),
                  ],
                ),
              ),
              // Aquí puedes agregar más contenido de configuración
            ],
          ),
        ),
      ),
    );
  }
}
