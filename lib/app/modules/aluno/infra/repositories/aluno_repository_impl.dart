import 'package:dartz/dartz.dart';
import 'package:school_app/app/modules/curso/domain/entities/curso.dart';

import '../../domain/entities/aluno.dart';
import '../../errors/errors.dart';
import '../../external/datasources/aluno_datasource.dart';
import 'aluno_repository.dart';

class AlunoRepositoryImpl implements IAlunoRepository{
  late final IAlunoDatasource datasource;

  AlunoRepositoryImpl(this.datasource);

  @override
  Future<Either<FailureSearch, List<Aluno>>> getAlunos() async {
    try {
      final result = await datasource.getAlunos();
      return Right(result);
    } on DatasourceError catch (e){
      return Left(e);
    } catch (e){
      return Left(DatasourceError());
    }
  }

  @override
  Future<Either<FailureSearch, String>> addAluno(String nome) async {
    try {
      final result = await datasource.addAluno(nome);
      return Right(result);
  } on DatasourceError catch (e){
      return Left(e);
    } catch (e){
      return Left(DatasourceError());
    }
  }

  @override
  Future<Either<FailureSearch, String>> deleteAluno(int codigo) async {
    try {
      final result = await datasource.deleteAluno(codigo);
      return Right(result);
    } on DatasourceError catch (e){
      return Left(e);
    } on AlunoIsMatriculatedError catch (e){
      return Left(e);
    } catch (e){
      return Left(DatasourceError());
    }
  }

  @override
  Future<Either<FailureSearch, String>> editAluno(Aluno aluno) async {
    try {
      final result = await datasource.editAluno(aluno);
      return Right(result);
    } on DatasourceError catch (e){
      return Left(e);
    } catch (e){
      return Left(DatasourceError());
    }
  }

  @override
  Future<Either<FailureSearch, List<Curso>>> getMatriculatedCursosFrom(int codigoAluno) async {
    try {
      final result = await datasource.getMatriculatedCursosFrom(codigoAluno);
      return Right(result);
    } on DatasourceError catch (e){
      return Left(e);
    } catch (e){
      return Left(DatasourceError());
    }
  }
}