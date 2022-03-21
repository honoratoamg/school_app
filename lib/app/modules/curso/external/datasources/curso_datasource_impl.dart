import 'package:dio/dio.dart';
import 'package:school_app/app/modules/aluno/external/datasource_result_models/result_aluno_model.dart';
import 'package:school_app/app/modules/curso/external/datasource_result_models/result_curso_model.dart';
import 'package:school_app/app/modules/curso/external/datasources/curso_datasource.dart';

import '../../../../enviroments_details/enviroments_details.dart';
import '../../domain/entities/curso.dart';
import '../../errors/errors_curso.dart';

class CursoDatasourceImpl implements ICursoDatasource{
  late final Dio dio;

  CursoDatasourceImpl(this.dio);

  @override
  Future<List<ResultCursoModel>> getCursos() async {
    final response = await dio.get(baseUrl+crudCursos);
    if (response.statusCode == 200) {
      final list = (response.data as List)
          .map((e) => ResultCursoModel.fromMap(e))
          .toList();
      return list;
    } else {
      throw DatasourceError();
    }
  }

  @override
  Future<String> addCurso(String descricao, String ementa) async {
    final response = await dio.post(baseUrl+crudCursos,
        data: {'descricao': descricao, 'ementa': ementa});
    if (response.statusCode == 200) {
      return "success";
    } else {
      throw DatasourceError();
    }
  }

  @override
  Future<String> deleteCurso(int codigo) async {
    final cursoAlunoList = await getMatriculatedAlunosFrom(codigo);

    if(cursoAlunoList.isNotEmpty){
      throw CursoContainsAlunoError();
    }

    final response = await dio.delete(baseUrl+crudCursos+'$codigo');
    if (response.statusCode == 200) {
      return "success";
    } else {
      throw DatasourceError();
    }
  }

  @override
  Future<String> editCurso(Curso curso) async {
    final response = await dio.put(baseUrl+crudCursos+'${curso.codigo}',
    data: {'descricao': curso.descricao, 'ementa': curso.ementa});
    if (response.statusCode == 200) {
      return "success";
    } else {
      throw DatasourceError();
    }
  }

  @override
  Future<List<ResultAlunoModel>> getMatriculatedAlunosFrom(int codigoCurso) async {
    final response = await dio.get(baseUrl+checkMatriculatedCurso+'$codigoCurso');
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