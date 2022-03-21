import 'package:dio/dio.dart';
import 'package:school_app/app/modules/curso/external/datasource_result_models/result_curso_model.dart';

import '../../../../enviroments_details/enviroments_details.dart';
import '../../domain/entities/aluno.dart';
import '../../errors/errors.dart';
import '../datasource_result_models/result_aluno_model.dart';
import 'aluno_datasource.dart';

class AlunoDatasourceImpl implements IAlunoDatasource {
  late final Dio dio;

  AlunoDatasourceImpl(this.dio);

  @override
  Future<List<ResultAlunoModel>> getAlunos() async {
    final response = await dio.get(baseUrl + crudAlunos);
    if (response.statusCode == 200) {
      final list = (response.data as List)
          .map((e) => ResultAlunoModel.fromMap(e))
          .toList();
      return list;
    } else {
      throw DatasourceError();
    }
  }

  @override
  Future<String> addAluno(nome) async {
    final response = await dio.post(baseUrl + crudAlunos, data: {'nome': nome});
    if (response.statusCode == 200) {
      return "success";
    } else {
      throw DatasourceError();
    }
  }

  @override
  Future<String> deleteAluno(int codigo) async {
    final alunoCursoList = await getMatriculatedCursosFrom(codigo);

    if(alunoCursoList.isNotEmpty){
      throw AlunoIsMatriculatedError();
    }

    final response = await dio.delete(baseUrl + crudAlunos + '$codigo');
    if (response.statusCode == 200) {
      return "success";
    } else {
      throw DatasourceError();
    }
  }

  @override
  Future<String> editAluno(Aluno aluno) async {
    final response = await dio.put(baseUrl + crudAlunos + '${aluno.codigo}',
        data: {'nome': aluno.nome});
    if (response.statusCode == 200) {
      return "success";
    } else {
      throw DatasourceError();
    }
  }

  @override
  Future<List<ResultCursoModel>> getMatriculatedCursosFrom(int codigoAluno) async {
    final response = await dio.get(baseUrl+checkMatriculatedAluno+'$codigoAluno');
    if (response.statusCode == 200) {
      final list = (response.data as List)
          .map((e) => ResultCursoModel.fromMap(e))
          .toList();
      return list;
    } else {
      throw DatasourceError();
    }
  }
}
