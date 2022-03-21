import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:school_app/app/app_module.dart';
import 'package:school_app/app/modules/aluno/presenter/add_edit_aluno.dart';

import '../domain/entities/aluno.dart';
import 'components/aluno_card_widget.dart';
import 'controllers/aluno_page_controller.dart';

class AlunoPage extends StatefulWidget {
  const AlunoPage({Key? key}) : super(key: key);

  @override
  _AlunoPageState createState() => _AlunoPageState();
}

class _AlunoPageState extends ModularState<AlunoPage, AlunoPageController> {
  // Callback to execute on child page's close
  void _reloadCallback() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Alunos'),
          centerTitle: true,
        ),
        body: FutureBuilder(
          future: controller.getAlunosList(),
          builder: (context, AsyncSnapshot<List<Aluno>> snapshot) {
            final listLength = snapshot.data?.length;
            return snapshot.hasData
                ? (snapshot.data!.isNotEmpty) ? ListView.builder(
                    itemCount: listLength! + 1,
                    itemBuilder: (context, index) {
                      if (index >= listLength) {
                        return Container(height: 100);
                      } else {
                        return AlunoCardWidget(
                            key: UniqueKey(),
                            aluno: snapshot.data![index],
                            callback: _reloadCallback);
                      }
                    },
                  ) : const Center(child: Text('Não há alunos cadastrados!'))
                : const Center(
                    child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.yellow),
                        backgroundColor: Colors.grey));
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async => await Modular.to.pushNamed(
              AppModule.addEditAlunoRouteName,
              arguments: AddEditAlunoArguments(
                  aluno: Aluno(nome: '', codigo: -1), callback: _reloadCallback)),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
