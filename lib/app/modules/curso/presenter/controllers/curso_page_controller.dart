import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:school_app/app/modules/curso/domain/usecases/maintain_curso.dart';
import 'package:school_app/app/modules/curso/errors/errors_curso.dart';

import '../../../../utils/alert_dialog.dart';
import '../../domain/entities/curso.dart';

class CursoPageController {
  late final IMaintainCurso usecase;
  CursoPageController(this.usecase);

  Future<List<Curso>> getCursosList() async {
    final resultList = await usecase.getCursos();
    return resultList.fold(
        (failureResult) => [], (successResult) => successResult);
  }

  void deleteCursoConfirmation(
      BuildContext context, Curso curso, Function callback) async {
    showAConfirmationDialog(
        context: context,
        title: 'Remoção',
        message: 'Deseja remover o curso ${curso.descricao}?',
        noFunction: () => Modular.to.pop(),
        yesFunction: () => deleteCurso(context, curso, callback));
  }

  void deleteCurso(BuildContext context, Curso curso, Function callback) async {
    final result = await usecase.deleteCurso(curso.codigo);

    result.fold((failureResult) {
      if (failureResult is CursoContainsAlunoError) {
        showAlertDialogFailure(
            message:
                "O curso ${curso.descricao} não pode ser removido porque existem alunos(a) matriculados(a)",
            title: "Atenção",
            buttonConfirmationLabel: "OK",
            context: context,
            goBack: true);
      } else {
        showAlertDialogFailure(
            message: "Ocorreu um erro ao remover o curso! Tente novamente.",
            title: "Erro",
            buttonConfirmationLabel: "OK",
            context: context);
      }
      return;
    }, (successResult) {
      showAlertDialogSuccess(
          message: "Curso removido com sucesso!",
          title: "Sucesso",
          buttonConfirmationLabel: "OK",
          context: context,
          goBack: true);
      callback();
    });
  }
}
