import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:school_app/app/modules/matricula/presenter/alunos_matricula_page.dart';

import '../../../../app_module.dart';
import '../../../../utils/scrollable_text.dart';
import '../../../curso/domain/entities/curso.dart';
import '../controllers/matricula_page_controller.dart';

class MatriculaCardWidget extends StatefulWidget {
  const MatriculaCardWidget(
      {required Key key, required this.curso, required this.callback})
      : super(key: key);

  final Curso curso;
  final Function callback;

  @override
  _MatriculaCardWidgetState createState() => _MatriculaCardWidgetState();
}

class _MatriculaCardWidgetState
    extends ModularState<MatriculaCardWidget, MatriculaPageController> {
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
            onTap: () async => await Modular.to.pushNamed(
                AppModule.matriculatedAlunosRouteName,
                arguments:
                    MatriculatedAlunosPageArguments(curso: widget.curso)),
            leading: const Icon(Icons.library_books_outlined),
            title: ScrollableText('Matrículas'),
            subtitle: ScrollableText('Curso: ${widget.curso.descricao}'),
            trailing: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: IconButton(
                onPressed: () async => await Modular.to.pushNamed(
                    AppModule.matriculatedAlunosRouteName,
                    arguments:
                        MatriculatedAlunosPageArguments(curso: widget.curso)),
                icon: const Icon(Icons.playlist_add),
              ),
            )),
      ),
    );
  }
}
