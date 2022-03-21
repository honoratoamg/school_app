import 'dart:convert';

import '../../domain/entities/curso.dart';

class ResultCursoModel extends Curso{
  ResultCursoModel({required int codigo, required String descricao, required String ementa}) : super(codigo: codigo, ementa: ementa, descricao: descricao);

  Map<String, dynamic> toMap(){
    return {
      'codigo': codigo,
      'descricao': descricao,
      'ementa': ementa
    };
  }

  static ResultCursoModel fromMap(Map<String, dynamic> map) {
    return ResultCursoModel(
        codigo: map['codigo'] ?? -1,
        descricao: map['descricao'] ?? '',
        ementa: map['ementa'] ?? ''
    );
  }

  String toJson() => json.encode(toMap());

}