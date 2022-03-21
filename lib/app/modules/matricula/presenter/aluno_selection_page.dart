import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../aluno/domain/entities/aluno.dart';
import '../../curso/domain/entities/curso.dart';
import 'components/aluno_selection_widget.dart';
import 'controllers/aluno_selection_page_controller.dart';

class AlunoSelectionWidgetArguments {
  AlunoSelectionWidgetArguments({required this.curso, required this.callback});
  final Curso curso;
  Function callback;
}

class AlunoSelectionPage extends StatefulWidget {
  AlunoSelectionPage({Key? key, required this.curso, required this.callback})
      : super(key: key);

  final Curso curso;
  Function callback;

  @override
  _AlunoSelectionPageState createState() => _AlunoSelectionPageState();
}

class _AlunoSelectionPageState
    extends ModularState<AlunoSelectionPage, AlunoSelectionPageController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: const Text('Selecionar Aluno(a)'),
            centerTitle: true,
          ),
          body: FutureBuilder(
            future: controller.getNotMatriculatedAlunosList(widget.curso),
            builder: (context, AsyncSnapshot<List<Aluno>> snapshot) {
              final listLength = snapshot.data?.length;
              return snapshot.hasData
                  ? (snapshot.data!.isNotEmpty) ? ListView.builder(
                      itemCount: listLength! + 1,
                      itemBuilder: (context, index) {
                        if (index >= listLength) {
                          return Container(height: 100);
                        } else {
                          return AlunoSelectionWidget(
                              key: UniqueKey(),
                              aluno: snapshot.data![index],
                              curso: widget.curso,
                              callback: widget.callback);
                        }
                      },
                    ) : const Center(child: Text('Não há alunos para matricular neste curso!'))
                  : const Center(
                      child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.yellow),
                          backgroundColor: Colors.grey));
            },
          )),
    );
  }
}
