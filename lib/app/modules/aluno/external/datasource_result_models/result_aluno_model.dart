import 'dart:convert';
import '../../domain/entities/aluno.dart';

class ResultAlunoModel extends Aluno{
  ResultAlunoModel({required int codigo, required String nome}) : super(codigo: codigo, nome: nome);

  Map<String, dynamic> toMap(){
    return {
      'codigo': codigo,
      'nome': nome
    };
  }

  static ResultAlunoModel fromMap(Map<String, dynamic> map) {
    return ResultAlunoModel(
      codigo: map['codigo'] ?? -1,
      nome: map['nome'] ?? ''
    );
  }

  String toJson() => json.encode(toMap());

}