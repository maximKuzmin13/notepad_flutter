import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_notepad/Strings.dart';
import 'package:flutter_notepad/Utils.dart';
import 'package:flutter_notepad/core/Database.dart';
import 'package:flutter_notepad/data/Note.dart';

class EditNoteScreen extends StatefulWidget {
  EditNoteScreen({Key key, this.newNote, this.note, this.fakeNote})
      : super(key: key);
  Note note;
  bool newNote;
  bool fakeNote;

  @override
  _EditNoteScreenState createState() => _EditNoteScreenState();
}

class _EditNoteScreenState extends State<EditNoteScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController messageController = TextEditingController();
  Note note;

  @override
  void initState() {
    super.initState();
    if (widget.note != null) {
      titleController.text = widget.note.noteTitle;
      messageController.text = widget.note.noteText;
    } else if (!widget.newNote) {
      titleController.text = Strings.fakeNotesChange;
      messageController.text = Strings.fakeNotesChange;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        elevation: 0,
        title: Text(
          widget.note != null ? Strings.changeNote : Strings.createNote,
          style: TextStyle(
              fontSize: Utils.getFontSize(32, MediaQuery.of(context).size),
              fontWeight: FontWeight.w700,
              color: Colors.white),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: titleController,
              decoration: const InputDecoration(
                  hintText: 'Введите название заметки', labelText: 'Название'),
            ),
            TextFormField(
              controller: messageController,
              decoration: const InputDecoration(
                  hintText: 'Введите текс заметки', labelText: 'Текст'),
              maxLines: null,
              keyboardType: TextInputType.multiline,
            ),
            SizedBox(height: 8),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.all(Radius.circular(8))),
              child: InkWell(
                  child: Center(
                    child: Text(
                      Strings.saveNote,
                      style: TextStyle(
                          fontSize: Utils.getFontSize(
                              16, MediaQuery.of(context).size),
                          fontWeight: FontWeight.w400,
                          color: Colors.white),
                    ),
                  ),
                  onTap: () async {
                    if (!widget.fakeNote) {
                      if (widget.note == null) {
                        Note note = Note(
                            id: Random().nextInt(1000),
                            noteTitle: titleController.text,
                            noteText: messageController.text,
                            noteDate: DateTime.now().toString());
                        await DBProvider.db.newNote(note);
                        Navigator.of(context).pop();
                      } else {
                        widget.note = Note(
                            id: widget.note.id,
                            noteTitle: titleController.text,
                            noteText: messageController.text,
                            noteDate: DateTime.now().toString());
                        await DBProvider.db.updateNote(widget.note);
                        Navigator.of(context).pop();
                      }
                    } else {}
                  }),
            ),
          ],
        ),
      ),
    );
  }
// }
}
