import 'package:flutter/material.dart';
import 'package:proyect_example/navigation/home_page.dart';
import 'package:proyect_example/navigation/messages_page.dart';
import 'package:proyect_example/navigation/profile_user_page.dart';

class BottomNavigator extends StatefulWidget {
  final int id_receive;

  const BottomNavigator({Key? key, required this.id_receive}) : super(key: key);

  @override
  State<BottomNavigator> createState() => NavBar();
}

class NavBar extends State<BottomNavigator> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentPageIndex,
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        destinations: const <Widget>[
          NavigationDestination(
            icon: Icon(
              Icons.home,
              size: 30.0,
            ),
            label: 'Inicio',
          ),
          NavigationDestination(
            icon: Icon(
              Icons.messenger_sharp,
              size: 30.0,
            ),
            label: 'Mensajes',
          ),
          NavigationDestination(
            icon: Icon(
              Icons.person,
              size: 30.0,
            ),
            label: 'Perfil',
          )
        ],
      ),
      body: _buildBody(currentPageIndex),
    );
  }

  Widget _buildBody(int index) {
    switch (index) {
      case 0:
        return HomePage(userId: widget.id_receive);
      case 1:
        return const MessagesPage();
      default:
        return ProfileUserPage(userId: widget.id_receive);
    }
  }
}
