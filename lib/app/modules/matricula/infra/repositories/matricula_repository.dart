import 'package:dartz/dartz.dart';

import '../../../aluno/domain/entities/aluno.dart';
import '../../../curso/domain/entities/curso.dart';
import '../../errors/errors.dart';

abstract class IMatriculaRepository {
  Future<Either<FailureSearch, List<Aluno>>> getNotMatriculatedAlunosFrom(int codigoCurso);
  Future<Either<FailureSearch, String>> addMatricula(int codigoAluno, int codigoCurso);
  Future<Either<FailureSearch, String>> deleteMatricula(int codigoAluno, int codigoCurso);
}