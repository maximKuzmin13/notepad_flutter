import 'package:flutter_notepad/core/ViewModel.dart';
import 'package:flutter_notepad/core/ViewState.dart';
import 'package:flutter_notepad/domain/NoteRepository.dart';
import 'package:rxdart/rxdart.dart';

class NoteViewModel extends ViewModel {
  final NoteRepository _repository;

  final viewState = BehaviorSubject<ViewState>();

  final List fakeNotes = [];

  bool isFake;

  NoteViewModel(this._repository);

  Future<void> downloadFakeNotes() async {
    try {
      final response = await _repository.getFakeNoteList();
      if (response != null) {
        fakeNotes.addAll(response);
        viewState.add(Success(fakeNotes: fakeNotes));
      }
    } catch (e) {
      viewState.add(Error(text: e));
    }
  }

  @override
  void onCleared() {
    viewState.close();
  }
}
