import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:school_app/app/app_module.dart';
import 'package:school_app/app/modules/matricula/presenter/components/matriculated_aluno_widget.dart';
import 'package:school_app/app/utils/scrollable_text.dart';

import '../../aluno/domain/entities/aluno.dart';
import '../../curso/domain/entities/curso.dart';
import 'aluno_selection_page.dart';
import 'controllers/matricula_page_controller.dart';

class MatriculatedAlunosPageArguments {
  MatriculatedAlunosPageArguments({required this.curso});
  final Curso curso;
}

class MatriculatedAlunosPage extends StatefulWidget {
  const MatriculatedAlunosPage({Key? key, required this.curso})
      : super(key: key);
  final Curso curso;

  @override
  _MatriculatedAlunosPageState createState() => _MatriculatedAlunosPageState();
}

class _MatriculatedAlunosPageState
    extends ModularState<MatriculatedAlunosPage, MatriculaPageController> {
  // Callback to execute on child page's close
  void _reloadCallback() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: ScrollableText('Alunos - ${widget.curso.descricao}'),
          centerTitle: true,
        ),
        body: FutureBuilder(
          future: controller.getAlunosFrom(widget.curso),
          builder: (context, AsyncSnapshot<List<Aluno>> snapshot) {
            final listLength = snapshot.data?.length;
            return snapshot.hasData
                ? (snapshot.data!.isNotEmpty) ? ListView.builder(
                    itemCount: listLength! + 1,
                    itemBuilder: (context, index) {
                      if (index >= listLength) {
                        return Container(height: 100);
                      } else {
                        return MatriculatedAlunoCardWidget(
                            key: UniqueKey(),
                            aluno: snapshot.data![index],
                            curso: widget.curso,
                            callback: _reloadCallback);
                      }
                    },
                  ) : const Center(child: Text('Não há alunos matriculados neste curso!'))
                : const Center(
                    child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.yellow),
                        backgroundColor: Colors.grey));
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async => await Modular.to.pushNamed(
              AppModule.alunoSelectionRouteName,
              arguments: AlunoSelectionWidgetArguments(
                  curso: widget.curso, callback: _reloadCallback)),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
