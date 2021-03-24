class FakeNotes {
  List fakenotes = [];

  FakeNotes.fromJson(List notes) {
    fakenotes.addAll(notes);
  }
}
