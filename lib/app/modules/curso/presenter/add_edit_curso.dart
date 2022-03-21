import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../domain/entities/curso.dart';


import '../domain/usecases/maintain_curso.dart';
import 'controllers/add_edit_curso_controller.dart';class AddEditCursoArguments {
  AddEditCursoArguments({required this.curso, required this.callback});
  final Curso curso;
  final Function callback;
}

class AddEditCurso extends StatefulWidget {
  const AddEditCurso({Key? key, required this.curso, required this.callback})
      : super(key: key);

  final Curso curso;
  final Function callback;

  @override
  _AddEditCursoState createState() => _AddEditCursoState();
}

class _AddEditCursoState
    extends ModularState<AddEditCurso, AddEditCursoController> {
  @override
  void initState() {
    controller.setupPage(widget.curso);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(controller.isEdit
              ? 'Editando ${widget.curso.descricao}'
              : 'Cadastro de curso'),
          centerTitle: true,
        ),
        body: FocusTraversalGroup(
          child: Form(
            autovalidateMode: AutovalidateMode.always,
            onChanged: () {
              Form.of(primaryFocus!.context!)!.save();
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      initialValue: controller.typedCursoDescricao,
                      maxLength: cursoDescricaoMaxLength,
                      decoration: const InputDecoration(
                        label: Text('Descrição do curso'),
                        border: OutlineInputBorder(),
                        hintText: 'Digite a descrição do curso',
                      ),
                      onSaved: (String? value) {
                        if (value != null) {
                          controller.changeTypedCursoDescricao(value);
                        }
                      },
                      validator: (String? value) {
                        if (value != null && value.isEmpty) {
                          return 'Campo não pode ser vazio';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      initialValue: controller.typedCursoEmenta,
                      minLines: 1,
                      maxLines: 10,
                      decoration: const InputDecoration(
                        label: Text('Ementa do curso'),
                        border: OutlineInputBorder(),
                        hintText: 'Digite a ementa do curso',
                      ),
                      onSaved: (String? value) {
                        if (value != null) {
                          controller.changeTypedCursoEmenta(value);
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: controller.isEdit
              ? () => controller.editCurso(context, widget.curso, widget.callback)
              : () => controller.addNewCurso(context, widget.callback),
          child: const Icon(Icons.save),
        ),
      ),
    );
  }
}
