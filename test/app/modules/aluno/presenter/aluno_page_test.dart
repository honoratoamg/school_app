import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:modular_test/modular_test.dart';
import 'package:school_app/app/app_module.dart';
import 'package:school_app/app/modules/aluno/presenter/aluno_page.dart';

void main() {
  late Widget homeAlunos;

  setUp(() {
    homeAlunos = const MaterialApp(home: AlunoPage());

    initModule(AppModule());
  });

  testWidgets('Must find a FloatingActionButton on Aluno Page',
      (WidgetTester tester) async {
    await tester.pumpWidget(homeAlunos);
    await tester.pump(const Duration(seconds: 1));
    expect(
        find.widgetWithIcon(FloatingActionButton, Icons.add), findsOneWidget);
  });
}
