import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:school_app/app/modules/aluno/errors/errors.dart';

import '../../../../utils/alert_dialog.dart';
import '../../domain/entities/aluno.dart';
import '../../domain/usecases/maintain_aluno.dart';

class AlunoPageController {
  late final IMaintainAluno usecase;

  AlunoPageController(this.usecase);

  Future<List<Aluno>> getAlunosList() async {
    final resultList = await usecase.getAlunos();
    return resultList.fold(
        (failureResult) => [], (successResult) => successResult);
  }

  void deleteAlunoConfirmation(
      BuildContext context, Aluno aluno, Function callback) async {
    showAConfirmationDialog(
        context: context,
        title: 'Remoção',
        message: 'Deseja remover o(a) aluno(a) ${aluno.nome}?',
        noFunction: () => Modular.to.pop(),
        yesFunction: () => deleteAluno(context, aluno, callback));
  }

  void deleteAluno(BuildContext context, Aluno aluno, Function callback) async {
    final result = await usecase.deleteAluno(aluno.codigo);

    result.fold((failureResult) {
      if (failureResult is AlunoIsMatriculatedError) {
        showAlertDialogFailure(
            message:
                "O aluno(a) ${aluno.nome} não pode ser removido porque está matriculado(a) em cursos",
            title: "Atenção",
            buttonConfirmationLabel: "OK",
            context: context,
            goBack: true);
      } else {
        showAlertDialogFailure(
            message: "Ocorreu um erro ao remover o aluno! Tente novamente.",
            title: "Erro",
            buttonConfirmationLabel: "OK",
            context: context);
      }
      return;
    }, (successResult) {
      showAlertDialogSuccess(
          message: "Aluno removido com sucesso!",
          title: "Sucesso",
          buttonConfirmationLabel: "OK",
          context: context,
          goBack: true);
      callback();
    });
  }
}
