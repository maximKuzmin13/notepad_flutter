import 'package:dio/dio.dart';
import 'package:flutter_notepad/domain/NoteRepository.dart';
import 'package:flutter_notepad/presentation/NoteViewModel.dart';
import 'package:injectable/injectable.dart';

@module
abstract class NoteModule {
  NoteRepository provideNoteRepository(Dio dio) {
    return NoteRepository(dio);
  }

  @factoryMethod
  NoteViewModel provideNoteViewModel(
    NoteRepository noteRepository,
  ) {
    return NoteViewModel(noteRepository);
  }
}
