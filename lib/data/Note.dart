class Note {
  int id;
  String noteTitle;
  String noteText;
  String noteDate;

  Note({
    this.id,
    this.noteTitle,
    this.noteText,
    this.noteDate,
  });

  factory Note.fromMap(Map<String, dynamic> json) => new Note(
        id: json["id"],
        noteTitle: json["noteTitle"],
        noteText: json["noteText"],
        noteDate: json["noteDate"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "noteTitle": noteTitle,
        "noteText": noteText,
        "noteDate": noteDate,
      };
}
