import 'package:flutter_test/flutter_test.dart';
import 'package:school_app/app/modules/aluno/domain/entities/aluno.dart';
import 'package:school_app/app/modules/aluno/external/datasource_result_models/result_aluno_model.dart';
import 'package:school_app/app/modules/curso/domain/entities/curso.dart';
import 'package:school_app/app/modules/curso/external/datasource_result_models/result_curso_model.dart';
import 'package:school_app/app/modules/curso/external/datasources/curso_datasource.dart';
import 'package:school_app/app/modules/curso/infra/repositories/curso_repository_impl.dart';

class CursoDatasourceMock implements ICursoDatasource {
  @override
  Future<String> addCurso(String descricao, String ementa) {
    return Future.value("success");
  }

  @override
  Future<String> deleteCurso(int codigo) {
    return Future.value("success");
  }

  @override
  Future<List<ResultCursoModel>> getCursos() {
    return Future.value(<ResultCursoModel>[]);
  }

  @override
  Future<String> editCurso(Curso curso) {
    return Future.value("success");
  }

  @override
  Future<List<ResultAlunoModel>> getMatriculatedAlunosFrom(int codigoCurso) {
    return Future.value(<ResultAlunoModel>[]);
  }

}

class CursoDatasourceMockError implements ICursoDatasource {
  @override
  Future<String> addCurso(String descricao, String ementa) {
    throw Exception();
  }

  @override
  Future<String> deleteCurso(int codigo) {
    throw Exception();
  }

  @override
  Future<List<ResultCursoModel>> getCursos() {
    throw Exception();
  }

  @override
  Future<List<ResultAlunoModel>> getMatriculatedAlunosFrom(int codigoCurso) {
    throw Exception();
  }

  @override
  Future<String> editCurso(Curso curso) {
    throw Exception();
  }

}

main(){
  final datasource = CursoDatasourceMock();
  final repository = CursoRepositoryImpl(datasource);
  final cursoMock = Curso(codigo: 1, descricao: 'Biologia', ementa: '');

  test('Must return a list of Curso', () async{
    final result = await repository.getCursos();
    expect(result | [],  isA<List<ResultCursoModel>>());
  });

  test('Must return a success when adding a Curso', () async{
    final result = await repository.addCurso("Matematica", "disciplina");
    expect(result | '', "success");
  });

  test('Must return a success when editing a Curso', () async{
    final result = await repository.editCurso(cursoMock);
    expect(result | '', "success");
  });

  test('Must return a success when deleting a Curso', () async{
    final result = await repository.deleteCurso(1);
    expect(result | '', "success");
  });

  test('Must return a list of Curso', () async {
    final result = await repository.getMatriculatedAlunosFrom(1);
    expect(result | [], isA<List<Aluno>>());
  });

  //Simulating datasource errors
  test('Must return a error if datasource fail when getting all Cursos', () async{
    final datasourceError = CursoDatasourceMockError();
    final repository = CursoRepositoryImpl(datasourceError);
    final result = await repository.getCursos();
    expect(result.isLeft(), true);
  });

  test('Must return a error if datasource fail when adding a Curso', () async{
    final datasourceError = CursoDatasourceMockError();
    final repository = CursoRepositoryImpl(datasourceError);
    final result = await repository.addCurso("Matematica", "disciplina");
    expect(result.isLeft(), true);
  });

  test('Must return a error if datasource fail when editing a Curso', () async{
    final datasourceError = CursoDatasourceMockError();
    final repository = CursoRepositoryImpl(datasourceError);
    final result = await repository.editCurso(cursoMock);
    expect(result.isLeft(), true);
  });

  test('Must return a error if datasource fail when deleting a Curso', () async{
    final datasourceError = CursoDatasourceMockError();
    final repository = CursoRepositoryImpl(datasourceError);
    final result = await repository.editCurso(cursoMock);
    expect(result.isLeft(), true);
  });
}