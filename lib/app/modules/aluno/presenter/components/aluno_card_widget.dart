import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../app_module.dart';
import '../../../../utils/scrollable_text.dart';
import '../../domain/entities/aluno.dart';
import '../add_edit_aluno.dart';
import '../controllers/aluno_page_controller.dart';

class AlunoCardWidget extends StatefulWidget {
  const AlunoCardWidget(
      {required Key key, required this.aluno, required this.callback})
      : super(key: key);

  final Aluno aluno;
  final Function callback;

  @override
  _AlunoCardWidgetState createState() => _AlunoCardWidgetState();
}

class _AlunoCardWidgetState
    extends ModularState<AlunoCardWidget, AlunoPageController> {
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
                AppModule.addEditAlunoRouteName,
                arguments: AddEditAlunoArguments(
                    aluno: widget.aluno, callback: widget.callback)),
            leading: const Icon(Icons.person_rounded),
            title: ScrollableText(widget.aluno.nome),
            trailing: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => controller.deleteAlunoConfirmation(
                        context, widget.aluno, widget.callback),
                    icon: const Icon(Icons.delete, color: Colors.red),
                  ),
                  IconButton(
                    onPressed: () async => await Modular.to.pushNamed(
                        AppModule.addEditAlunoRouteName,
                        arguments: AddEditAlunoArguments(
                            aluno: widget.aluno, callback: widget.callback)),
                    icon: const Icon(Icons.edit),
                  )
                ],
              ),
            )),
      ),
    );
  }
}
