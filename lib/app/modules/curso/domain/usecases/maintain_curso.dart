import 'package:dartz/dartz.dart';

import '../../errors/errors_curso.dart';
import '../../infra/repositories/curso_repository.dart';
import '../entities/curso.dart';

const int cursoDescricaoMaxLength = 50;

abstract class IMaintainCurso{
  Future<Either<FailureSearch, List<Curso>>> getCursos();
  Future<Either<FailureSearch, String>> addCurso(String descricao, String ementa);
  Future<Either<FailureSearch, String>> deleteCurso(int codigo);
  Future<Either<FailureSearch, String>> editCurso(Curso curso);
}

class MaintainCursoImpl implements IMaintainCurso{
  late final ICursoRepository repository;

  MaintainCursoImpl(this.repository);

  @override
  Future<Either<FailureSearch, List<Curso>>> getCursos() async {
    return repository.getCursos();
  }

  @override
  Future<Either<FailureSearch, String>> addCurso(String descricao, String ementa) async {

    if(descricao.isEmpty){
      return Left(InvalidTextError());
    }

    return repository.addCurso(descricao, ementa);
  }

  @override
  Future<Either<FailureSearch, String>> deleteCurso(int codigo) async {
    return repository.deleteCurso(codigo);
  }

  @override
  Future<Either<FailureSearch, String>> editCurso(Curso curso) async {
    return repository.editCurso(curso);
  }
}