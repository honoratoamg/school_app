import 'package:flutter/cupertino.dart';
import 'package:school_app/app/modules/aluno/presenter/aluno_page.dart';
import 'package:school_app/app/modules/curso/presenter/curso_page.dart';
import 'package:school_app/app/modules/matricula/presenter/matricula_page.dart';

class HomePageController extends ChangeNotifier {
  int selectedIndex = 0;

  List<Widget> widgetOptions = <Widget>[
    const AlunoPage(),
    const CursoPage(),
    const MatriculaPage(),
  ];

  void onItemTapped(int index) {
    selectedIndex = index;
    notifyListeners();
  }
}
