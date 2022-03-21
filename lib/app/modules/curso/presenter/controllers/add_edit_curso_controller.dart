import 'package:flutter/cupertino.dart';
import 'package:school_app/app/modules/curso/domain/usecases/maintain_curso.dart';

import '../../../../utils/alert_dialog.dart';
import '../../domain/entities/curso.dart';

class AddEditCursoController extends ChangeNotifier {
  late final IMaintainCurso usecase;
  AddEditCursoController(this.usecase);

  late final bool isEdit;
  late String typedCursoDescricao;
  late String typedCursoEmenta;

  changeTypedCursoDescricao(String newValue) => typedCursoDescricao = newValue;
  changeTypedCursoEmenta(String newValue) => typedCursoEmenta = newValue;

  void setupPage(Curso curso) {
    if (curso.codigo == -1) {
      isEdit = false;
      typedCursoDescricao = '';
      typedCursoEmenta = '';
    } else {
      isEdit = true;
      typedCursoDescricao = curso.descricao;
      typedCursoEmenta = curso.ementa;
    }
  }

  void addNewCurso(BuildContext context, Function callback) async {
    if (typedCursoDescricao.isEmpty) {
      showAlertDialogFailure(
          message:
              "A descrição do curso não pode ser vazia! Preencha o campo de descrição.",
          title: "Atenção",
          buttonConfirmationLabel: "OK",
          context: context);
      return;
    }

    final result =
        await usecase.addCurso(typedCursoDescricao, typedCursoEmenta);
    result.fold(
        (failureResult) => showAlertDialogFailure(
            message: "Ocorreu um erro ao salvar o curso! Tente novamente.",
            title: "Erro",
            buttonConfirmationLabel: "OK",
            context: context), (successResult) {
      showAlertDialogSuccess(
          message: "Curso cadastrado com sucesso!",
          title: "Sucesso",
          buttonConfirmationLabel: "OK",
          context: context,
          goBack: true);
      callback();
    });
  }

  void editCurso(BuildContext context, Curso curso, Function callback) async {
    if (typedCursoDescricao.isEmpty) {
      showAlertDialogFailure(
          message:
              "A descrição do curso não pode ser vazia! Preencha o campo de descrição.",
          title: "Atenção",
          buttonConfirmationLabel: "OK",
          context: context);
      return;
    }

    final editedCurso = Curso(
      codigo: curso.codigo,
      descricao: typedCursoDescricao,
      ementa: typedCursoEmenta,
    );

    final result = await usecase.editCurso(editedCurso);

    result.fold(
        (failureResult) => showAlertDialogFailure(
            message: "Ocorreu um erro ao editar o curso! Tente novamente.",
            title: "Erro",
            buttonConfirmationLabel: "OK",
            context: context), (successResult) {
      showAlertDialogSuccess(
          message: "Curso editado com sucesso!",
          title: "Sucesso",
          buttonConfirmationLabel: "OK",
          context: context,
          goBack: true);
      callback();
    });
  }
}
