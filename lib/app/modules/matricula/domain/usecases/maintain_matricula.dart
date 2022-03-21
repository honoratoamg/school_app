import 'package:dartz/dartz.dart';
import 'package:school_app/app/modules/matricula/infra/repositories/matricula_repository.dart';
import '../../errors/errors.dart';

abstract class IMaintainMatricula {
  Future<Either<FailureSearch, String>> addMatricula(int codigoAluno, int codigoCurso);
  Future<Either<FailureSearch, String>> deleteMatricula(int codigoAluno, int codigoCurso);
}

class MaintainMatriculaImpl implements IMaintainMatricula{
  late final IMatriculaRepository repository;

  MaintainMatriculaImpl(this.repository);

  @override
  Future<Either<FailureSearch, String>> addMatricula(int codigoAluno, int codigoCurso) async {
    return repository.addMatricula(codigoAluno, codigoCurso);
  }

  @override
  Future<Either<FailureSearch, String>> deleteMatricula(int codigoAluno, int codigoCurso) async {
    return repository.deleteMatricula(codigoAluno, codigoCurso);
  }
}