import 'package:flutter/material.dart';
import '../widgets/ProfileUser/ProfileUserSection.dart';
import '../widgets/ProfileUser/log_out/log_out.dart';

class ProfileUserPage extends StatelessWidget {
  final int userId;

  const ProfileUserPage({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: Container(
          padding: const EdgeInsets.only(top: 24, left: 16, right: 16),
          decoration: const BoxDecoration(
            color: Colors.white,
            border: Border(
              bottom: BorderSide(
                color: Color.fromARGB(255, 236, 135, 19),
                width: 0.8,
              ),
            ),
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Perfil de Usuario',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 236, 135, 19),
                ),
              )
            ],
          ),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate(
              [
                ProfileUserSection(
                  title: 'Información personal',
                  userId: userId,
                  nextPage: '/config_user_page',
                ),
                ProfileUserSection(
                  title: 'Habilidades',
                  userId: userId,
                  nextPage: '/skills_user_page',
                ),
                ProfileUserSection(
                  title: 'Intereses',
                  userId: userId,
                  nextPage: '/interest_user_page',
                ),
                ProfileUserSection(
                  title: 'Reportes',
                  userId: userId,
                  nextPage: '/',
                ),
                const CerrarSesionButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
