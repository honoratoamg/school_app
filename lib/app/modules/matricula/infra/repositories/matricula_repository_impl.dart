import 'package:dartz/dartz.dart';
import 'package:school_app/app/modules/aluno/domain/entities/aluno.dart';
import 'package:school_app/app/modules/curso/domain/entities/curso.dart';
import 'package:school_app/app/modules/matricula/errors/errors.dart';
import 'package:school_app/app/modules/matricula/external/datasources/matricula_datasource.dart';
import 'package:school_app/app/modules/matricula/infra/repositories/matricula_repository.dart';

class MatriculaRepositoryImpl implements IMatriculaRepository{
  late final IMatriculaDatasource datasource;

  MatriculaRepositoryImpl(this.datasource);

  @override
  Future<Either<FailureSearch, String>> addMatricula(int codigoAluno, int codigoCurso) async {
    try {
      final result = await datasource.addMatricula(codigoAluno, codigoCurso);
      return Right(result);
    } on DatasourceError catch (e){
      return Left(e);
    } catch (e){
      return Left(DatasourceError());
    }
  }

  @override
  Future<Either<FailureSearch, String>> deleteMatricula(int codigoAluno, int codigoCurso) async {
    try {
      final result = await datasource.deleteMatricula(codigoAluno, codigoCurso);
      return Right(result);
    } on DatasourceError catch (e){
      return Left(e);
    } catch (e){
      return Left(DatasourceError());
    }
  }

  @override
  Future<Either<FailureSearch, List<Aluno>>> getNotMatriculatedAlunosFrom(int codigoCurso) async {
    try {
      final result = await datasource.getNotMatriculatedAlunosFrom(codigoCurso);
      return Right(result);
    } on DatasourceError catch (e){
      return Left(e);
    } catch (e){
      return Left(DatasourceError());
    }
  }
}