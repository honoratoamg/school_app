import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:school_app/app/utils/scrollable_text.dart';

import '../../../../app_module.dart';
import '../../domain/entities/curso.dart';
import '../add_edit_curso.dart';
import '../controllers/curso_page_controller.dart';

class CursoCardWidget extends StatefulWidget {
  const CursoCardWidget(
      {required Key key, required this.curso, required this.callback})
      : super(key: key);

  final Curso curso;
  final Function callback;

  @override
  _CursoCardWidgetState createState() => _CursoCardWidgetState();
}

class _CursoCardWidgetState
    extends ModularState<CursoCardWidget, CursoPageController> {
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
            leading: const Icon(Icons.book),
            title: ScrollableText(widget.curso.descricao),
            trailing: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  IconButton(
                    onPressed: () async => await Modular.to.pushNamed(
                        AppModule.addEditCursoRouteName,
                        arguments: AddEditCursoArguments(
                            curso: widget.curso, callback: widget.callback)),
                    icon: const Icon(Icons.edit),
                  ),
                  IconButton(
                    onPressed: () => controller.deleteCursoConfirmation(context, widget.curso, widget.callback),
                    icon: const Icon(Icons.delete, color: Colors.red),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
