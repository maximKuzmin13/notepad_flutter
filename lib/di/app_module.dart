import 'package:dio/dio.dart';
import 'package:flutter_notepad/domain/NoteInterceptor.dart';
import 'package:injectable/injectable.dart';

@module
abstract class AppModule {
  @singleton
  Dio provideDio() {
    final dio = Dio(
      BaseOptions(
        baseUrl: "https://jsonplaceholder.typicode.com/",
        contentType: "application/json",
        connectTimeout: 30000,
        receiveTimeout: 30000,
      ),
    );
    dio.interceptors.add(NoteInterceptor());

    return dio;
  }
}
