import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:school_app/app/modules/aluno/domain/entities/aluno.dart';
import 'package:school_app/app/modules/curso/domain/entities/curso.dart';
import 'package:school_app/app/modules/curso/domain/usecases/maintain_curso.dart';
import 'package:school_app/app/modules/curso/errors/errors_curso.dart';
import 'package:school_app/app/modules/curso/infra/repositories/curso_repository.dart';

class CursoRepositoryMock implements ICursoRepository{
  @override
  Future<Either<FailureSearch, List<Curso>>> getCursos() async {
    return const Right(<Curso>[]);
  }

  @override
  Future<Either<FailureSearch, String>> addCurso(String descricao, String ementa) async {
    return const Right("success");
  }

  @override
  Future<Either<FailureSearch, String>> deleteCurso(int codigo) async {
    return const Right("success");
  }

  @override
  Future<Either<FailureSearch, String>> editCurso(Curso curso) async {
    return const Right("success");
  }

  @override
  Future<Either<FailureSearch, List<Aluno>>> getMatriculatedAlunosFrom(int codigoCurso) async {
    return const Right(<Aluno>[]);
  }


}

main(){
  final repository = CursoRepositoryMock();
  final usecases = MaintainCursoImpl(repository);

  test('Must return a list of Curso', () async {
    final result = await usecases.getCursos();
    expect(result | [], isA<List<Curso>>());
  });

  test('Must return a success when adding a Curso', () async {
    final result = await usecases.addCurso("Matematica", "Disciplina");
    expect(result | '', "success");
  });

  test('Must return a InvalidTextError when adding a Curso without name', () async {
    final result = await usecases.addCurso("", "Disciplina");
    expect(result.isLeft(), true);
  });

  test('Must return a success when editing a Curso', () async {
    final result = await usecases.editCurso(Curso(codigo: 1, descricao: 'Biologia', ementa: ''));
    expect(result | '', "success");
  });

  test('Must return a success when deleting a Curso', () async {
    final result = await usecases.deleteCurso(1);
    expect(result | '', "success");
  });
}