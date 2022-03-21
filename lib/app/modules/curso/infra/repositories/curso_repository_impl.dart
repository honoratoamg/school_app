import 'package:dartz/dartz.dart';
import 'package:school_app/app/modules/aluno/domain/entities/aluno.dart';
import 'package:school_app/app/modules/curso/domain/entities/curso.dart';
import 'package:school_app/app/modules/curso/errors/errors_curso.dart';
import 'package:school_app/app/modules/curso/external/datasources/curso_datasource.dart';
import 'package:school_app/app/modules/curso/infra/repositories/curso_repository.dart';

class CursoRepositoryImpl implements ICursoRepository{
  late final ICursoDatasource datasource;

  CursoRepositoryImpl(this.datasource);

  @override
  Future<Either<FailureSearch, List<Curso>>> getCursos() async {
    try {
      final result = await datasource.getCursos();
      return Right(result);
    } on DatasourceError catch (e){
      return Left(e);
    } catch (e){
      return Left(DatasourceError());
    }
  }

  @override
  Future<Either<FailureSearch, String>> addCurso(String descricao, String ementa) async {
    try {
      final result = await datasource.addCurso(descricao,ementa);
      return Right(result);
    } on DatasourceError catch (e){
      return Left(e);
    } catch (e){
      return Left(DatasourceError());
    }
  }

  @override
  Future<Either<FailureSearch, String>> deleteCurso(int codigo) async {
    try {
      final result = await datasource.deleteCurso(codigo);
      return Right(result);
    } on DatasourceError catch (e){
      return Left(e);
    } on CursoContainsAlunoError catch (e){
      return Left(e);
    } catch (e){
      return Left(DatasourceError());
    }
  }

  @override
  Future<Either<FailureSearch, String>> editCurso(Curso curso) async {
    try {
      final result = await datasource.editCurso(curso);
      return Right(result);
    } on DatasourceError catch (e){
      return Left(e);
    } catch (e){
      return Left(DatasourceError());
    }
  }

  @override
  Future<Either<FailureSearch, List<Aluno>>> getMatriculatedAlunosFrom(int codigoCurso) async {
    try {
      final result = await datasource.getMatriculatedAlunosFrom(codigoCurso);
      return Right(result);
    } on DatasourceError catch (e){
      return Left(e);
    } catch (e){
      return Left(DatasourceError());
    }
  }
}