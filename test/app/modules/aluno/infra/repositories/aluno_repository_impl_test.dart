import 'package:flutter_test/flutter_test.dart';
import 'package:school_app/app/modules/aluno/domain/entities/aluno.dart';
import 'package:school_app/app/modules/aluno/external/datasource_result_models/result_aluno_model.dart';
import 'package:school_app/app/modules/aluno/external/datasources/aluno_datasource.dart';
import 'package:school_app/app/modules/aluno/infra/repositories/aluno_repository_impl.dart';
import 'package:school_app/app/modules/curso/domain/entities/curso.dart';
import 'package:school_app/app/modules/curso/external/datasource_result_models/result_curso_model.dart';

class AlunoDatasourceMock implements IAlunoDatasource {
  @override
  Future<List<ResultAlunoModel>> getAlunos() {
    return Future.value(<ResultAlunoModel>[]);
  }

  @override
  Future<String> addAluno(String nome) {
    return Future.value("success");
  }

  @override
  Future<String> deleteAluno(int codigo) {
    return Future.value("success");
  }

  @override
  Future<String> editAluno(Aluno aluno) {
    return Future.value("success");
  }

  @override
  Future<List<ResultCursoModel>> getMatriculatedCursosFrom(int codigoAluno) {
    return Future.value(<ResultCursoModel>[]);
  }


}

class AlunoDatasourceMockError implements IAlunoDatasource {
  @override
  Future<List<ResultAlunoModel>> getAlunos() {
    throw Exception();
  }

  @override
  Future<String> addAluno(String nome) {
    throw Exception();
  }

  @override
  Future<String> deleteAluno(int codigo) {
    throw Exception();
  }

  @override
  Future<String> editAluno(Aluno aluno) {
    throw Exception();
  }

  @override
  Future<List<ResultCursoModel>> getMatriculatedCursosFrom(int codigoAluno) {
    throw Exception();
  }

}

main(){
  final datasource = AlunoDatasourceMock();
  final repository = AlunoRepositoryImpl(datasource);
  final alunoMock = Aluno(nome: "Antonio", codigo: 1);

  test('Must return a list of Aluno', () async{
    final result = await repository.getAlunos();
    expect(result | [],  isA<List<ResultAlunoModel>>());
  });

  test('Must return a success when adding a Aluno', () async{
    final result = await repository.addAluno("Antônio");
    expect(result | '', "success");
  });

  test('Must return a success when editing a Aluno', () async{
    final result = await repository.editAluno(alunoMock);
    expect(result | '', "success");
  });

  test('Must return a success when deleting a Aluno', () async{
    final result = await repository.deleteAluno(1);
    expect(result | '', "success");
  });

  test('Must return a list of Aluno', () async {
    final result = await repository.getMatriculatedCursosFrom(1);
    expect(result | [], isA<List<Curso>>());
  });

  //Simulating datasource errors
  test('Must return a error if datasource fail when getting all Alunos', () async{
    final datasourceError = AlunoDatasourceMockError();
    final repository = AlunoRepositoryImpl(datasourceError);
    final result = await repository.getAlunos();
    expect(result.isLeft(), true);
  });

  test('Must return a error if datasource fail when adding a Aluno', () async{
    final datasourceError = AlunoDatasourceMockError();
    final repository = AlunoRepositoryImpl(datasourceError);
    final result = await repository.addAluno("Antônio");
    expect(result.isLeft(), true);
  });

  test('Must return a error if datasource fail when editing a Aluno', () async{
    final datasourceError = AlunoDatasourceMockError();
    final repository = AlunoRepositoryImpl(datasourceError);
    final result = await repository.editAluno(alunoMock);
    expect(result.isLeft(), true);
  });

  test('Must return a error if datasource fail when deleting a Aluno', () async{
    final datasourceError = AlunoDatasourceMockError();
    final repository = AlunoRepositoryImpl(datasourceError);
    final result = await repository.editAluno(alunoMock);
    expect(result.isLeft(), true);
  });

}