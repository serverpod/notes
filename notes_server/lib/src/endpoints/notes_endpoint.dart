import 'package:serverpod/server.dart';

import '../generated/protocol.dart';

class NotesEndpoint extends Endpoint {
  Future<List<Note>> getAllNotes(Session session) async {
    // By ordering by the id column, we always get the notes in the same order
    // and not in the order they were updated.
    return await Note.find(
      session,
      orderBy: Note.t.id,
    );
  }

  Future<void> updateNote(Session session, Note note) async {
    await Note.update(session, note);
  }

  Future<void> createNote(Session session, Note note) async {
    await Note.insert(session, note);
  }

  Future<void> deleteNote(Session session, Note note) async {
    await Note.deleteRow(session, note);
  }
}
