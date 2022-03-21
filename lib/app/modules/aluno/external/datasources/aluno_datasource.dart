import '../../../curso/external/datasource_result_models/result_curso_model.dart';
import '../../domain/entities/aluno.dart';
import '../datasource_result_models/result_aluno_model.dart';

abstract class IAlunoDatasource{
  Future<List<ResultAlunoModel>> getAlunos();
  Future<String> addAluno(String nome);
  Future<String> deleteAluno(int codigo);
  Future<String> editAluno(Aluno aluno);
  Future<List<ResultCursoModel>> getMatriculatedCursosFrom(int codigoAluno);
}