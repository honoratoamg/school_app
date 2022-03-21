import 'package:dartz/dartz.dart';

import '../../../aluno/domain/entities/aluno.dart';
import '../../domain/entities/curso.dart';
import '../../errors/errors_curso.dart';

abstract class ICursoRepository {
  Future<Either<FailureSearch, List<Curso>>> getCursos();
  Future<Either<FailureSearch, String>> addCurso(String descricao, String ementa);
  Future<Either<FailureSearch, String>> deleteCurso(int codigo);
  Future<Either<FailureSearch, String>> editCurso(Curso curso);
  Future<Either<FailureSearch, List<Aluno>>> getMatriculatedAlunosFrom(int codigoCurso);
}