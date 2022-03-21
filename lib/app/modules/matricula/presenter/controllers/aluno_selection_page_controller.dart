import 'package:flutter/cupertino.dart';
import 'package:school_app/app/modules/matricula/infra/repositories/matricula_repository.dart';

import '../../../../utils/alert_dialog.dart';
import '../../../aluno/domain/entities/aluno.dart';
import '../../../curso/domain/entities/curso.dart';
import '../../domain/usecases/maintain_matricula.dart';

class AlunoSelectionPageController {
  late final IMaintainMatricula usecase;
  late final IMatriculaRepository repository;
  AlunoSelectionPageController(this.usecase, this.repository);


  Future<List<Aluno>> getNotMatriculatedAlunosList(Curso curso) async {
    final resultList = await repository.getNotMatriculatedAlunosFrom(curso.codigo);
    return resultList.fold(
            (failureResult) => [], (successResult) => successResult);
  }

  void addNewMatricula(BuildContext context, Curso curso, Aluno aluno, Function callback) async {
    final result = await usecase.addMatricula(aluno.codigo, curso.codigo);
    result.fold(
            (failureResult) => showAlertDialogFailure(
            message: "Ocorreu um erro ao matricular o curso! Tente novamente.",
            title: "Erro",
            buttonConfirmationLabel: "OK",
            context: context), (successResult) {
      showAlertDialogSuccess(
          message: "Aluno(a) matriculado com sucesso!",
          title: "Sucesso",
          buttonConfirmationLabel: "OK",
          context: context,
          goBack: true);
      callback();
    });
  }

}