import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:school_app/app/modules/aluno/domain/entities/aluno.dart';
import 'package:school_app/app/modules/curso/domain/entities/curso.dart';
import 'package:school_app/app/modules/matricula/domain/usecases/maintain_matricula.dart';
import 'package:school_app/app/modules/matricula/errors/errors.dart';
import 'package:school_app/app/modules/matricula/infra/repositories/matricula_repository.dart';

class MatriculaRepositoryMock implements IMatriculaRepository{
  @override
  Future<Either<FailureSearch, String>> addMatricula(int codigoAluno, int codigoCurso) async {
    return const Right("success");
  }

  @override
  Future<Either<FailureSearch, String>> deleteMatricula(int codigoAluno, int codigoCurso) async {
    return const Right("success");
  }

  @override
  Future<Either<FailureSearch, List<Aluno>>> getNotMatriculatedAlunosFrom(int codigoCurso) async {
    return const Right(<Aluno>[]);
  }
}

main(){
  final repository = MatriculaRepositoryMock();
  final usecases = MaintainMatriculaImpl(repository);

  test('Must return a success when adding a Matricula', () async {
    final result = await usecases.addMatricula(1, 1);
    expect(result | '', "success");
  });

  test('Must return a success when deleting a Matricula', () async {
    final result = await usecases.deleteMatricula(1, 1);
    expect(result | '', "success");
  });


}