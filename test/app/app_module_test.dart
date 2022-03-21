import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mocktail/mocktail.dart';
import 'package:modular_test/modular_test.dart';
import 'package:school_app/app/app_module.dart';
import 'package:school_app/app/modules/aluno/domain/entities/aluno.dart';
import 'package:school_app/app/modules/aluno/domain/usecases/maintain_aluno.dart';
import 'package:school_app/app/modules/curso/domain/entities/curso.dart';
import 'package:school_app/app/modules/curso/domain/usecases/maintain_curso.dart';

import 'utils/api_response_mock.dart';

class DioMock extends Mock implements Dio {}

main() {
  final dio = DioMock();
  RequestOptions options = RequestOptions(path: '');

  initModule(AppModule(), replaceBinds: [
    Bind<Dio>((i) => dio)
  ]);

  //Integration test to see if our use case is is currently using the dependency injection system
  test('Must return the use cases without error', () {
    final usecase = Modular.get<IMaintainAluno>();
    expect(usecase, isA<MaintainAlunoImpl>());
  });

  //Integration test
  test('Must return a list of Alunos. It will do all the work you would do in the view ', () async {
    when(() => dio.get(any()))
        .thenAnswer((_) async => Response(data: jsonDecode(alunoResult), statusCode: 200, requestOptions: options));

    final usecase = Modular.get<IMaintainAluno>();
    final result = await usecase.getAlunos();
    expect(result | [], isA<List<Aluno>>());
  });

  //Integration test
  test('Must return a list of Cursos. It will do all the work you would do in the view ', () async {
    when(() => dio.get(any()))
        .thenAnswer((_) async => Response(data: jsonDecode(cursoResult), statusCode: 200, requestOptions: options));

    final usecase = Modular.get<IMaintainCurso>();
    final result = await usecase.getCursos();
    expect(result | [], isA<List<Curso>>());
  });
}