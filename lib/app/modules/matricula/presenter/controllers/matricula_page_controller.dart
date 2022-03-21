import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:school_app/app/modules/curso/infra/repositories/curso_repository.dart';
import 'package:school_app/app/modules/matricula/domain/usecases/maintain_matricula.dart';

import '../../../../utils/alert_dialog.dart';
import '../../../aluno/domain/entities/aluno.dart';
import '../../../curso/domain/entities/curso.dart';

class MatriculaPageController {
  late final IMaintainMatricula useCase;
  late final ICursoRepository repositoryCurso;
  MatriculaPageController(this.repositoryCurso, this.useCase);

  Future<List<Curso>> getCursosList() async {
    final resultList = await repositoryCurso.getCursos();
    return resultList.fold((failureResult) => [], (successResult) => successResult);
  }

  Future<List<Aluno>> getAlunosFrom(Curso curso) async {
    final resultList = await repositoryCurso.getMatriculatedAlunosFrom(curso.codigo);
    return resultList.fold((failureResult) => [], (successResult) => successResult);
  }

  void deletMatriculaConfirmation(BuildContext context, Curso curso, Aluno aluno, Function call) async {
    showAConfirmationDialog(
        context: context,
        title: 'Remoção',
        message: 'Deseja remover a matricula do(a) aluno(a) ${aluno.nome} em ${curso.descricao}?',
        noFunction: () => Modular.to.pop(),
        yesFunction: () => deleteMatricula(context, curso, aluno, call)
    );
  }

  void deleteMatricula(BuildContext context, Curso curso, Aluno aluno, Function update) async {
    final result = await useCase.deleteMatricula(aluno.codigo, curso.codigo);
    result.fold(
            (failureResult) => showAlertDialogFailure(
            message: "Ocorreu um erro ao remover a Matrícula! Tente novamente.",
            title: "Erro",
            buttonConfirmationLabel: "OK",
            context: context), (successResult) {
      showAlertDialogSuccess(
          message: "Matrícula foi removida com sucesso!",
          title: "Sucesso",
          buttonConfirmationLabel: "OK",
          context: context,
          goBack: true);
      update();
    });
  }
}
