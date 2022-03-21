import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:school_app/app/modules/aluno/presenter/add_edit_aluno.dart';
import 'package:school_app/app/modules/curso/domain/usecases/maintain_curso.dart';
import 'package:school_app/app/modules/curso/external/datasources/curso_datasource_impl.dart';
import 'package:school_app/app/modules/curso/infra/repositories/curso_repository_impl.dart';
import 'package:school_app/app/modules/matricula/presenter/aluno_selection_page.dart';
import 'package:school_app/app/modules/matricula/presenter/alunos_matricula_page.dart';

import 'modules/aluno/domain/usecases/maintain_aluno.dart';
import 'modules/aluno/external/datasources/aluno_datasource_impl.dart';
import 'modules/aluno/infra/repositories/aluno_repository_impl.dart';
import 'modules/aluno/presenter/controllers/add_edit_aluno_controller.dart';
import 'modules/aluno/presenter/controllers/aluno_page_controller.dart';
import 'modules/curso/presenter/add_edit_curso.dart';
import 'modules/curso/presenter/controllers/add_edit_curso_controller.dart';
import 'modules/curso/presenter/controllers/curso_page_controller.dart';
import 'modules/home/presenter/controllers/home_page_controller.dart';
import 'modules/home/presenter/home_page.dart';
import 'modules/matricula/domain/usecases/maintain_matricula.dart';
import 'modules/matricula/external/datasources/matricula_datasource_impl.dart';
import 'modules/matricula/infra/repositories/matricula_repository_impl.dart';
import 'modules/matricula/presenter/controllers/aluno_selection_page_controller.dart';
import 'modules/matricula/presenter/controllers/matricula_page_controller.dart';
import 'modules/splash/presenter/controllers/splash_screen_controller.dart';
import 'modules/splash/presenter/splash_screen_page.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [
    Bind((i) => Dio()),
    Bind((i) => AlunoDatasourceImpl(i())),
    Bind((i) => AlunoRepositoryImpl(i())),
    Bind((i) => MaintainAlunoImpl(i())),
    Bind((i) => CursoDatasourceImpl(i())),
    Bind((i) => CursoRepositoryImpl(i())),
    Bind((i) => MaintainCursoImpl(i())),
    Bind((i) => MatriculaDatasourceImpl(i())),
    Bind((i) => MatriculaRepositoryImpl(i())),
    Bind((i) => MaintainMatriculaImpl(i())),

    Bind((i) => SplashScreenController()),
    Bind((i) => HomePageController()),
    Bind((i) => AlunoPageController(i())),
    Bind((i) => AddEditAlunoController(i())),
    Bind((i) => CursoPageController(i())),
    Bind((i) => AddEditCursoController(i())),
    Bind((i) => MatriculaPageController(i(), i())),
    Bind((i) => AlunoSelectionPageController(i(), i())),
  ];

  @override
  List<ModularRoute> get routes => [
    ChildRoute(splashScreenRouteName, child: (context, args) => SplashScreenPage()),
    ChildRoute(homePageRouteName, child: (context, args) => const HomePage()),
    ChildRoute(addEditAlunoRouteName, child: (context, args) => AddEditAluno(aluno: args.data.aluno, callback: args.data.callback)),
    ChildRoute(addEditCursoRouteName, child: (context, args) => AddEditCurso(curso: args.data.curso, callback: args.data.callback)),
    ChildRoute(matriculatedAlunosRouteName, child: (context, args) => MatriculatedAlunosPage(curso: args.data.curso)),
    ChildRoute(alunoSelectionRouteName, child: (context, args) => AlunoSelectionPage(curso: args.data.curso, callback: args.data.callback))
  ];

  static const splashScreenRouteName = '/';
  static const homePageRouteName = '/home';
  static const addEditAlunoRouteName = '/addEditAluno';
  static const addEditCursoRouteName = '/addEditCurso';
  static const matriculatedAlunosRouteName = '/matriculatedAlunosRouteName';
  static const alunoSelectionRouteName = '/alunoSelectionPageController';
}