import 'package:bot_2000/core/abstraction/notes_logic.dart';
import 'package:bot_2000/core/models/notes/note.dart';
import 'package:bot_2000/core/models/notes/note_book.dart';

class NoteServices implements NotesLogic {
  @override
  Stream<List<NoteBook?>> getNoteBooks(String userId) {
    // TODO: implement getNoteBooks
    throw UnimplementedError();
  }

  @override
  Stream<List<Note?>>? getNotes(String relNoteBookId) {
    // TODO: implement getNotes
    throw UnimplementedError();
  }

  @override
  Future<bool> postObject(
      {String? relationId, required String tableName, object}) {
    // TODO: implement postText
    throw UnimplementedError();
  }

  @override
  Future<bool> updateField(
      {String? relationId, required String tableName, required field}) {
    // TODO: implement updateText
    throw UnimplementedError();
  }
}
