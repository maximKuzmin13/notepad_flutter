import 'package:dio/dio.dart';
import 'package:flutter_notepad/data/FakeNotes.dart';

class NoteRepository {
  final Dio dio;

  NoteRepository(this.dio);

  Future<List> getFakeNoteList() async {
    var response = await dio.get("comments");
    return FakeNotes.fromJson(response.data).fakenotes ?? List();
  }
}
