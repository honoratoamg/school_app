import 'package:dartz/dartz.dart';

import '../../errors/errors.dart';
import '../../infra/repositories/aluno_repository.dart';
import '../entities/aluno.dart';

const int alunoNameMaxLength = 50;

abstract class IMaintainAluno {
  Future<Either<FailureSearch, List<Aluno>>> getAlunos();
  Future<Either<FailureSearch, String>> addAluno(String nome);
  Future<Either<FailureSearch, String>> deleteAluno(int codigo);
  Future<Either<FailureSearch, String>> editAluno(Aluno aluno);
}

class MaintainAlunoImpl implements IMaintainAluno{
  late final IAlunoRepository repository;

  MaintainAlunoImpl(this.repository);

  @override
  Future<Either<FailureSearch, List<Aluno>>> getAlunos() async {
    return repository.getAlunos();
  }

  @override
  Future<Either<FailureSearch, String>> addAluno(String nome) async {

    if(nome.isEmpty){
      return Left(InvalidTextError());
    }

    return repository.addAluno(nome);
  }

  @override
  Future<Either<FailureSearch, String>> deleteAluno(int codigo) async {
    return repository.deleteAluno(codigo);
  }

  @override
  Future<Either<FailureSearch, String>> editAluno(Aluno aluno) async {
    return repository.editAluno(aluno);
  }
}
