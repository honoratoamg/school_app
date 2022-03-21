import 'package:flutter/cupertino.dart';

import '../../../../utils/alert_dialog.dart';
import '../../domain/entities/aluno.dart';
import '../../domain/usecases/maintain_aluno.dart';

class AddEditAlunoController extends ChangeNotifier {
  late final IMaintainAluno usecase;
  AddEditAlunoController(this.usecase);

  late final bool isEdit;
  late String typedAlunoName;

  changeTypedAlunoName(String newValue) => typedAlunoName = newValue;

  void setupPage(Aluno aluno) {
    if (aluno.codigo == -1) {
      isEdit = false;
      typedAlunoName = '';
    } else {
      isEdit = true;
      typedAlunoName = aluno.nome;
    }
  }

  void addNewAluno(BuildContext context, Function callback) async {
    if (typedAlunoName.isEmpty) {
      showAlertDialogFailure(
          message:
              "O nome do(a) aluno(a) não pode ser vazio! Preencha o campo de nome.",
          title: "Atenção",
          buttonConfirmationLabel: "OK",
          context: context);
      return;
    }

    final result = await usecase.addAluno(typedAlunoName);
    result.fold(
        (failureResult) => showAlertDialogFailure(
            message: "Ocorreu um erro ao salvar o aluno! Tente novamente.",
            title: "Erro",
            buttonConfirmationLabel: "OK",
            context: context), (successResult) {
      showAlertDialogSuccess(
          message: "Aluno cadastrado com sucesso!",
          title: "Sucesso",
          buttonConfirmationLabel: "OK",
          context: context,
          goBack: true);
      callback();
    });
  }

  void editAluno(BuildContext context, Aluno aluno, Function callback) async {
    if (typedAlunoName.isEmpty) {
      showAlertDialogFailure(
          message:
              "O nome do(a) aluno(a) não pode ser vazio! Preencha o campo de nome.",
          title: "Atenção",
          buttonConfirmationLabel: "OK",
          context: context);
      return;
    }

    final editedAluno = Aluno(codigo: aluno.codigo, nome: typedAlunoName);

    final result = await usecase.editAluno(editedAluno);

    result.fold(
        (failureResult) => showAlertDialogFailure(
            message: "Ocorreu um erro ao editar o aluno! Tente novamente.",
            title: "Erro",
            buttonConfirmationLabel: "OK",
            context: context), (successResult) {
      showAlertDialogSuccess(
          message: "Aluno editado com sucesso!",
          title: "Sucesso",
          buttonConfirmationLabel: "OK",
          context: context,
          goBack: true);
      callback();
    });
  }
}
