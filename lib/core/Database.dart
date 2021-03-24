import 'dart:io';

import 'package:flutter_notepad/data/Note.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  DBProvider._();

  static final DBProvider db = DBProvider._();

  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "NotesDB.db");
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE Note ("
          "id INTEGER PRIMARY KEY,"
          "noteTitle TEXT,"
          "noteText TEXT,"
          "noteDate TEXT"
          ")");
    });
  }

  newNote(Note newNote) async {
    final db = await database;
    //get the biggest id in the table
    var table = await db.rawQuery("SELECT MAX(id)+1 as id FROM Note");
    int id = table.first["id"];
    //insert to the table using the new id
    var raw = await db.rawInsert(
        "INSERT Into Note (id,noteTitle,noteText,noteDate)"
        " VALUES (?,?,?,?)",
        [id, newNote.noteTitle, newNote.noteText, newNote.noteDate]);
    return raw;
  }

  updateNote(Note newNote) async {
    final db = await database;
    var res = await db.update("Note", newNote.toMap(),
        where: "id = ?", whereArgs: [newNote.id]);
    return res;
  }

  getNote(int id) async {
    final db = await database;
    var res = await db.query("Note", where: "id = ?", whereArgs: [id]);
    return res.isNotEmpty ? Note.fromMap(res.first) : null;
  }

  Future<List<Note>> getAllNotes() async {
    final db = await database;
    var res = await db.query("Note");
    List<Note> list =
        res.isNotEmpty ? res.map((c) => Note.fromMap(c)).toList() : [];
    return list;
  }

  deleteNote(int id) async {
    final db = await database;
    return db.delete("Note", where: "id = ?", whereArgs: [id]);
  }

  deleteAll() async {
    final db = await database;
    db.rawDelete("Delete * from Note");
  }
}
