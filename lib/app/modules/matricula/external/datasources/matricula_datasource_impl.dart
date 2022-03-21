import 'package:dio/dio.dart';
import 'package:school_app/app/modules/aluno/external/datasource_result_models/result_aluno_model.dart';
import 'package:school_app/app/modules/matricula/external/datasources/matricula_datasource.dart';

import '../../../../enviroments_details/enviroments_details.dart';
import '../../errors/errors.dart';

class MatriculaDatasourceImpl implements IMatriculaDatasource{
  late final Dio dio;

  MatriculaDatasourceImpl(this.dio);

  @override
  Future<String> addMatricula(int codigoAluno, int codigoCurso) async {
    final response = await dio.post(baseUrl + crudMatriculas+'$codigoAluno/$codigoCurso');
    if (response.statusCode == 200) {
      return "success";
    } else {
      throw DatasourceError();
    }
  }

  @override
  Future<String> deleteMatricula(int codigoAluno, int codigoCurso) async {
    final response = await dio.delete(baseUrl+crudMatriculas+'$codigoAluno/$codigoCurso');
    if (response.statusCode == 200) {
      return "success";
    } else {
      throw DatasourceError();
    }
  }

  @override
  Future<List<ResultAlunoModel>> getNotMatriculatedAlunosFrom(int codigoCurso) async {
    final response = await dio.get(baseUrl+checkNotMatriculatedAluno+'$codigoCurso');
    if (response.statusCode == 200) {
      final list = (response.data as List)
          .map((e) => ResultAlunoModel.fromMap(e))
          .toList();
      return list;
    } else {
      throw DatasourceError();
    }
  }
}