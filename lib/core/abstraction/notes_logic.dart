import 'package:bot_2000/core/models/notes/note.dart';
import 'package:bot_2000/core/models/notes/note_book.dart';

abstract class NotesLogic {
  Stream<List<NoteBook?>>? getNoteBooks(String userId);
  Stream<List<Note?>>? getNotes(String relNoteBookId);

  Future<bool> postNoteBook(
      {required String relationId, required String tableName});
  Future<bool> postNote(
      {required String relationId, required String tableName, dynamic object});
  Future<bool> postSubNote(
      {required String relationId, required String tableName, dynamic object});

  Future<bool> updateField(
      {String relationId, required String tableName, required field});

  Stream<Note?> getANote(String noteId);
}
