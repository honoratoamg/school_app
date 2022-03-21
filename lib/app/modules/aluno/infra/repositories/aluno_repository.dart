import 'package:dartz/dartz.dart';

import '../../../curso/domain/entities/curso.dart';
import '../../domain/entities/aluno.dart';
import '../../errors/errors.dart';

abstract class IAlunoRepository {
  Future<Either<FailureSearch, List<Aluno>>> getAlunos();
  Future<Either<FailureSearch, String>> addAluno(String nome);
  Future<Either<FailureSearch, String>> deleteAluno(int codigo);
  Future<Either<FailureSearch, String>> editAluno(Aluno aluno);
  Future<Either<FailureSearch, List<Curso>>> getMatriculatedCursosFrom(int codigoAluno);
}