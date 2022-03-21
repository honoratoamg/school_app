import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:school_app/app/app_module.dart';

import '../domain/entities/curso.dart';
import 'add_edit_curso.dart';
import 'components/curso_card_widget.dart';
import 'controllers/curso_page_controller.dart';

class CursoPage extends StatefulWidget {
  const CursoPage({Key? key}) : super(key: key);

  @override
  _CursoPageState createState() => _CursoPageState();
}

class _CursoPageState extends ModularState<CursoPage, CursoPageController> {
  // Callback to execute on child page's close
  void _reloadCallback() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Cursos'),
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
                        return CursoCardWidget(
                            key: UniqueKey(),
                            curso: snapshot.data![index],
                            callback: _reloadCallback);
                      }
                    },
                  ) :  const Center(child: Text('Não há cursos cadastrados!'))
                : const Center(
                    child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.yellow),
                        backgroundColor: Colors.grey));
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async => await Modular.to.pushNamed(
              AppModule.addEditCursoRouteName,
              arguments: AddEditCursoArguments(
                  curso: Curso(descricao: '', ementa: '', codigo: -1),
                  callback: _reloadCallback)),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
