import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:school_app/app/modules/aluno/domain/entities/aluno.dart';
import 'package:school_app/app/modules/aluno/domain/usecases/maintain_aluno.dart';
import 'package:school_app/app/modules/aluno/errors/errors.dart';
import 'package:school_app/app/modules/aluno/infra/repositories/aluno_repository.dart';
import 'package:school_app/app/modules/curso/domain/entities/curso.dart';

class AlunoRepositoryMock implements IAlunoRepository{
  @override
  Future<Either<FailureSearch, List<Aluno>>> getAlunos() async {
    return const Right(<Aluno>[]);
  }

  @override
  Future<Either<FailureSearch, String>> addAluno(String nome) async {
    return const Right("success");
  }

  @override
  Future<Either<FailureSearch, String>> deleteAluno(int codigo) async {
    return const Right("success");
  }

  @override
  Future<Either<FailureSearch, String>> editAluno(Aluno aluno) async {
    return const Right("success");
  }

  @override
  Future<Either<FailureSearch, List<Curso>>> getMatriculatedCursosFrom(int codigoAluno) async {
    return const Right(<Curso>[]);
  }

}

main(){
  final repository = AlunoRepositoryMock();
  final usecases = MaintainAlunoImpl(repository);

  test('Must return a list of Aluno', () async {
    final result = await usecases.getAlunos();
    expect(result | [], isA<List<Aluno>>());
  });

  test('Must return a success when adding a Aluno', () async {
    final result = await usecases.addAluno("Antônio");
    expect(result | '', "success");
  });

  test('Must return a InvalidTextError when adding a Aluno without name', () async {
    final result = await usecases.addAluno('');
    expect(result.isLeft(), true);
  });

  test('Must return a success when editing a Aluno', () async {
    final result = await usecases.editAluno(Aluno(nome: "Antonio", codigo: 1));
    expect(result | '', "success");
  });

  test('Must return a success when deleting a Aluno', () async {
    final result = await usecases.deleteAluno(1);
    expect(result | '', "success");
  });

}