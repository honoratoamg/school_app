import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'controllers/home_page_controller.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomePageController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AnimatedBuilder(
          animation: controller,
          builder: (context, _) {
            return Scaffold(
              body:
                  controller.widgetOptions.elementAt(controller.selectedIndex),
              bottomNavigationBar: BottomNavigationBar(
                items: const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: Icon(Icons.person),
                    label: 'Alunos',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.book),
                    label: 'Cursos',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.checklist_rtl),
                    label: 'Matrículas',
                  ),
                ],
                currentIndex: controller.selectedIndex,
                selectedItemColor: Colors.amber[800],
                onTap: controller.onItemTapped,
              ),
            );
          }),
    );
  }
}
