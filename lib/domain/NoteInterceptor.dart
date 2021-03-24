import 'package:dio/dio.dart';

class NoteInterceptor extends InterceptorsWrapper {
  @override
  Future onResponse(Response response) {
    if (response.data != null) {
      response.data = response.data;
    }
    return super.onResponse(response);
  }
}
