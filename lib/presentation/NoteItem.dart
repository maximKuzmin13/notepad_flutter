import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_notepad/data/Note.dart';
import 'package:flutter_notepad/presentation/EditNoteScreen.dart';

class NoteItem extends StatelessWidget {
  final Note note;
  final Map<String, dynamic> fakeNotes;
  final bool isFake;
  final Function onPressed;

  const NoteItem({
    Key key,
    this.note,
    this.fakeNotes,
    this.isFake,
    @required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFF1F2F4),
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  isFake ? fakeNotes["name"] : note.noteTitle,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  height: 4,
                ),
                Text(
                  isFake ? fakeNotes["body"] : note.noteText,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          onTap: () {
            onPressed.call();
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EditNoteScreen(
                  note: isFake ? null : note,
                  newNote: false,
                  fakeNote: isFake,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
