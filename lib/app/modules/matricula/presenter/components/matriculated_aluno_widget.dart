import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../aluno/domain/entities/aluno.dart';
import '../../../curso/domain/entities/curso.dart';
import '../controllers/matricula_page_controller.dart';

class MatriculatedAlunoCardWidget extends StatefulWidget {
  const MatriculatedAlunoCardWidget(
      {required Key key, required this.aluno, required this.curso, required this.callback})
      : super(key: key);

  final Aluno aluno;
  final Curso curso;
  final Function callback;

  @override
  _MatriculatedAlunoCardWidgetState createState() => _MatriculatedAlunoCardWidgetState();
}

class _MatriculatedAlunoCardWidgetState
    extends ModularState<MatriculatedAlunoCardWidget, MatriculaPageController> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: Colors.white70, width: 1),
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.all(10.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
            onTap: () => {},
            leading: const Icon(Icons.person_rounded),
            title: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Text('${widget.aluno.nome}')),
            trailing: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: IconButton(
                onPressed: () => controller.deletMatriculaConfirmation(context, widget.curso, widget.aluno, widget.callback),
                icon: const Icon(Icons.delete, color: Colors.red),
              ),
            )),
      ),
    );
  }
}
