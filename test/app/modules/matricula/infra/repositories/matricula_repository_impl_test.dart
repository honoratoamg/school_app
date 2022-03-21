import 'package:flutter_test/flutter_test.dart';
import 'package:school_app/app/modules/aluno/domain/entities/aluno.dart';
import 'package:school_app/app/modules/aluno/external/datasource_result_models/result_aluno_model.dart';
import 'package:school_app/app/modules/curso/domain/entities/curso.dart';
import 'package:school_app/app/modules/curso/external/datasource_result_models/result_curso_model.dart';
import 'package:school_app/app/modules/matricula/external/datasources/matricula_datasource.dart';
import 'package:school_app/app/modules/matricula/infra/repositories/matricula_repository_impl.dart';

class MatriculaDatasourceMock implements IMatriculaDatasource {
  @override
  Future<String> addMatricula(int codigoAluno, int codigoCurso) async {
    return Future.value("success");
  }

  @override
  Future<String> deleteMatricula(int codigoAluno, int codigoCurso) async {
    return Future.value("success");
  }

  @override
  Future<List<ResultAlunoModel>> getNotMatriculatedAlunosFrom(int codigoCurso) {
    return Future.value(<ResultAlunoModel>[]);
  }
}

class MatriculaDatasourceMockError implements IMatriculaDatasource {
  @override
  Future<String> addMatricula(int codigoAluno, int codigoCurso) {
    throw Exception();
  }

  @override
  Future<String> deleteMatricula(int codigoAluno, int codigoCurso) {
    throw Exception();
  }

  @override
  Future<List<ResultAlunoModel>> getMatriculatedAlunosFrom(int codigoCurso) {
    throw Exception();
  }

  @override
  Future<List<ResultCursoModel>> getMatriculatedCursosFrom(int codigoAluno) {
    throw Exception();
  }

  @override
  Future<List<ResultAlunoModel>> getNotMatriculatedAlunosFrom(int codigoCurso) {
    throw Exception();
  }

}

main(){
  final datasource = MatriculaDatasourceMock();
  final repository = MatriculaRepositoryImpl(datasource);

  test('Must return a success when adding a Matricula', () async {
    final result = await repository.addMatricula(1, 1);
    expect(result | '', "success");
  });

  test('Must return a success when deleting a Matricula', () async {
    final result = await repository.deleteMatricula(1, 1);
    expect(result | '', "success");
  });

  //Simulating datasource errors
  test('Must return a error if datasource fail when adding a Matricula', () async{
    final datasourceError = MatriculaDatasourceMockError();
    final repository = MatriculaRepositoryImpl(datasourceError);
    final result = await repository.addMatricula(1,1);
    expect(result.isLeft(), true);
  });

  test('Must return a error if datasource fail when deleting a Matricula', () async{
    final datasourceError = MatriculaDatasourceMockError();
    final repository = MatriculaRepositoryImpl(datasourceError);
    final result = await repository.deleteMatricula(1,1);
    expect(result.isLeft(), true);
  });

}