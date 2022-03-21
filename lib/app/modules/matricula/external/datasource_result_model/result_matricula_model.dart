import 'dart:convert';

import '../../domain/entities/matricula.dart';


class ResultMatriculaModel extends Matricula{
  ResultMatriculaModel({required int codigo_aluno, required int codigo_curso}) : super(codigo_aluno: codigo_aluno, codigo_curso: codigo_curso);

  Map<String, dynamic> toMap(){
    return {
      'codigo_aluno': codigo_aluno,
      'codigo_curso': codigo_curso
    };
  }

  static ResultMatriculaModel fromMap(Map<String, dynamic> map) {
    return ResultMatriculaModel(
        codigo_aluno: map['codigo_aluno'] ?? -1,
        codigo_curso: map['codigo_curso'] ?? -1
    );
  }

  String toJson() => json.encode(toMap());
}