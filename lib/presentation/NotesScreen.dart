import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_notepad/Strings.dart';
import 'package:flutter_notepad/Utils.dart';
import 'package:flutter_notepad/core/Database.dart';
import 'package:flutter_notepad/core/ViewState.dart';
import 'package:flutter_notepad/data/Note.dart';
import 'package:flutter_notepad/di/app_di.dart';
import 'package:flutter_notepad/presentation/EditNoteScreen.dart';
import 'package:flutter_notepad/presentation/NoteItem.dart';
import 'package:flutter_notepad/presentation/NoteViewModel.dart';

class NotesScreen extends StatefulWidget {
  NotesScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _NotesScreenState createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  NoteViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = getIt.get<NoteViewModel>();
    _viewModel.isFake = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          elevation: 0,
          title: Text(
            "Заметки",
            style: TextStyle(
                fontSize: Utils.getFontSize(32, MediaQuery.of(context).size),
                fontWeight: FontWeight.w700,
                color: Colors.white),
          ),
          actions: [
            IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  setState(() {
                    _viewModel.fakeNotes.clear();
                    DBProvider.db.deleteAll();
                  });
                }),
            IconButton(
                icon: Icon(Icons.download_rounded),
                onPressed: () {
                  _viewModel.downloadFakeNotes();
                  setState(() {
                    _viewModel.isFake = true;
                  });
                })
          ],
        ),
        backgroundColor: Colors.white,
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.create),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditNoteScreen(
                    newNote: true,
                    fakeNote: false,
                  ),
                ),
              );
            }),
        body: ListView(
          children: [
            FutureBuilder<List<Note>>(
              future: DBProvider.db.getAllNotes(),
              builder:
                  (BuildContext context, AsyncSnapshot<List<Note>> snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      itemCount: snapshot.data.length,
                      physics: ClampingScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        Note item = snapshot.data[index];
                        return notesConstructor(item);
                      });
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
            StreamBuilder<ViewState>(
              stream: _viewModel.viewState,
              initialData: Loading(),
              builder: (ctx, snapshot) {
                var state = snapshot.data;
                switch (state?.runtimeType) {
                  case Error:
                    return null;
                  case Success:
                    var notes = (state as Success).fakeNotes;
                    return notes.isEmpty
                        ? Center(
                            child: Text(Strings.emptyNotes),
                          )
                        : ListView.builder(
                            itemCount: notes.length,
                            physics: ClampingScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context, int index) {
                              return fakeNotesConstructor(notes[index]);
                            });
                  default:
                    return Center(child: CircularProgressIndicator());
                }
              },
            )
          ],
        ));
  }

  Widget notesConstructor(note) {
    return Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        child: Dismissible(
          key: UniqueKey(),
          child: NoteItem(
            note: note,
            isFake: false,
            onPressed: () async {},
          ),
          onDismissed: (direction) {
            DBProvider.db.deleteNote(note.id);
          },
        ));
  }

  Widget fakeNotesConstructor(note) {
    return Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        child: Dismissible(
          key: UniqueKey(),
          child: NoteItem(
            fakeNotes: note,
            isFake: true,
            onPressed: () async {},
          ),
          onDismissed: (direction) {
            DBProvider.db.deleteNote(note.id);
          },
        ));
  }
}
