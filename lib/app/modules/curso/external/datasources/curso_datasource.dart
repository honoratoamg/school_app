import 'package:school_app/app/modules/curso/external/datasource_result_models/result_curso_model.dart';

import '../../../aluno/external/datasource_result_models/result_aluno_model.dart';
import '../../domain/entities/curso.dart';

abstract class ICursoDatasource{
  Future<List<ResultCursoModel>> getCursos();
  Future<String> addCurso(String descricao, String ementa);
  Future<String> deleteCurso(int codigo);
  Future<String> editCurso(Curso curso);
  Future<List<ResultAlunoModel>> getMatriculatedAlunosFrom(int codigoCurso);
}