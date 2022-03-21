import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:school_app/app/modules/aluno/errors/errors.dart';
import 'package:school_app/app/modules/aluno/external/datasources/aluno_datasource_impl.dart';

import '../../../../utils/api_response_mock.dart';

class DioMock extends Mock implements Dio{}

main(){
  final dio = DioMock();
  final datasource = AlunoDatasourceImpl(dio);
  RequestOptions options = RequestOptions(path: '');

  test('Must return a list of Aluno', (){
    when(() => dio.get(any()))
        .thenAnswer((_) async => Response(data: jsonDecode(alunoResult), statusCode: 200, requestOptions: options));
    final future = datasource.getAlunos();
    expect(future, completes);
  });


  test("Must return a error if the code is not 200", () {
    when(() => dio.get(any()))
        .thenAnswer((_) async => Response(data: jsonDecode(alunoResult), statusCode: 401, requestOptions: options));
    final future = datasource.getAlunos();
    expect(future, throwsA(isA<DatasourceError>()));
  });

  test("Must return a error if exists a error on dio", () {
    when(() => dio.get(any()))
        .thenThrow(Exception());
    final future = datasource.getAlunos();
    expect(future, throwsA(isA<Exception>()));
  });
}
