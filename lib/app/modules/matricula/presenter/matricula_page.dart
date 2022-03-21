import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../curso/domain/entities/curso.dart';
import 'components/matricula_card_widget.dart';
import 'controllers/matricula_page_controller.dart';

class MatriculaPage extends StatefulWidget {
  const MatriculaPage({Key? key}) : super(key: key);

  @override
  _MatriculaPageState createState() => _MatriculaPageState();
}

class _MatriculaPageState
    extends ModularState<MatriculaPage, MatriculaPageController> {
  // Callback to execute on child page's close
  void _reloadCallback() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Matrículas'),
          centerTitle: true,
        ),
        body: FutureBuilder(
          future: controller.getCursosList(),
          builder: (context, AsyncSnapshot<List<Curso>> snapshot) {
            final listLength = snapshot.data?.length;
            return snapshot.hasData
                ? (snapshot.data!.isNotEmpty) ? ListView.builder(
                    itemCount: listLength! + 1,
                    itemBuilder: (context, index) {
                      if (index >= listLength) {
                        return Container(height: 100);
                      } else {
                        return MatriculaCardWidget(
                            key: UniqueKey(),
                            curso: snapshot.data![index],
                            callback: _reloadCallback);
                      }
                    },
                  ) : const Center(child: Text('Não há cursos para cadastrar matrículas!'))
                : const Center(
                    child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.yellow),
                        backgroundColor: Colors.grey));
          },
        ),
      ),
    );
  }
}
