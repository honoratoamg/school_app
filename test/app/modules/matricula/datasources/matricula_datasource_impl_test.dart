import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:school_app/app/modules/matricula/external/datasources/matricula_datasource_impl.dart';

class DioMock extends Mock implements Dio{}

main(){
  final dio = DioMock();
  final datasource = MatriculaDatasourceImpl(dio);

  test("Must return a error if exists a error on dio", () {
    when(() => dio.post(any())).thenThrow(Exception());
    final future = datasource.addMatricula(1, 1);
    expect(future, throwsA(isA<Exception>()));
  });

  test("Must return a error if exists a error on dio", () {
    when(() => dio.delete(any())).thenThrow(Exception());
    final future = datasource.deleteMatricula(1, 1);
    expect(future, throwsA(isA<Exception>()));
  });
}
