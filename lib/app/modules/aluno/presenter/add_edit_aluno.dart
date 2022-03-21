import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../domain/entities/aluno.dart';
import '../domain/usecases/maintain_aluno.dart';
import 'controllers/add_edit_aluno_controller.dart';

class AddEditAlunoArguments {
  AddEditAlunoArguments({required this.aluno, required this.callback});
  final Aluno aluno;
  final Function callback;
}

class AddEditAluno extends StatefulWidget {
  const AddEditAluno({Key? key, required this.aluno, required this.callback})
      : super(key: key);

  final Aluno aluno;
  final Function callback;

  @override
  _AddEditAlunoState createState() => _AddEditAlunoState();
}

class _AddEditAlunoState
    extends ModularState<AddEditAluno, AddEditAlunoController> {
  @override
  void initState() {
    controller.setupPage(widget.aluno);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(controller.isEdit
              ? 'Editando ${widget.aluno.nome}'
              : 'Cadastro de aluno'),
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
              child: TextFormField(
                initialValue: controller.typedAlunoName,
                maxLength: alunoNameMaxLength,
                decoration: const InputDecoration(
                  label: Text('Nome do aluno'),
                  border: OutlineInputBorder(),
                  hintText: 'Digite o nome do aluno',
                ),
                onSaved: (String? value) {
                  if (value != null) {
                    controller.changeTypedAlunoName(value);
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
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: controller.isEdit
              ? () => controller.editAluno(context, widget.aluno, widget.callback)
              : () => controller.addNewAluno(context, widget.callback),
          child: const Icon(Icons.save),
        ),
      ),
    );
  }
}
