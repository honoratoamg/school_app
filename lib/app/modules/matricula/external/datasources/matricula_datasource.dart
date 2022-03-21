import 'package:school_app/app/modules/aluno/external/datasource_result_models/result_aluno_model.dart';

abstract class IMatriculaDatasource{
  Future<List<ResultAlunoModel>> getNotMatriculatedAlunosFrom(int codigoCurso);
  Future<String> addMatricula(int codigoAluno, int codigoCurso);
  Future<String> deleteMatricula(int codigoAluno, int codigoCurso);
}