import 'package:flutter/material.dart';
import 'package:proyect_example/navigation/home_page.dart';
import 'package:proyect_example/navigation/index_page.dart';
import 'package:proyect_example/navigation/messages_page.dart';

class BottomNavigator extends StatefulWidget {
  
  const BottomNavigator({super.key});

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
            label: 'Home',
            
          ),
           NavigationDestination(
            icon: Icon(
              Icons.airplay,
              size: 30.0,
            ),
            label: 'Index',
            
          ),
           NavigationDestination(
            icon: Icon(
              Icons.messenger_sharp,
              size: 30.0,
            ),
            label: 'Messages',
            
          )



        ],
      ),
      body: _buildBody(currentPageIndex),
    );
    
  }
    Widget _buildBody(int index) {
    switch (index) {
      case 0:
        return const HomePage(); // Página de inicio, puedes reemplazar esto con el contenido de la página de inicio
      case 1:
        return const Index(); // Página adicional, muestra la página OtraPagina
      default:
        return const  MessagesPage(); // Por defecto, muestra un contenedor vacío
    }
  }
}
