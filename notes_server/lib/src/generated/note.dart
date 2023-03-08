/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: public_member_api_docs
// ignore_for_file: implementation_imports

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;

/// Holds a note with a text written by the user.
class Note extends _i1.TableRow {
  Note({
    int? id,
    required this.text,
  }) : super(id);

  factory Note.fromJson(
    Map<String, dynamic> jsonSerialization,
    _i1.SerializationManager serializationManager,
  ) {
    return Note(
      id: serializationManager.deserialize<int?>(jsonSerialization['id']),
      text: serializationManager.deserialize<String>(jsonSerialization['text']),
    );
  }

  static final t = NoteTable();

  /// The contents of the note.
  String text;

  @override
  String get tableName => 'note';
  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'text': text,
    };
  }

  @override
  Map<String, dynamic> toJsonForDatabase() {
    return {
      'id': id,
      'text': text,
    };
  }

  @override
  Map<String, dynamic> allToJson() {
    return {
      'id': id,
      'text': text,
    };
  }

  @override
  void setColumn(
    String columnName,
    value,
  ) {
    switch (columnName) {
      case 'id':
        id = value;
        return;
      case 'text':
        text = value;
        return;
      default:
        throw UnimplementedError();
    }
  }

  static Future<List<Note>> find(
    _i1.Session session, {
    NoteExpressionBuilder? where,
    int? limit,
    int? offset,
    _i1.Column? orderBy,
    List<_i1.Order>? orderByList,
    bool orderDescending = false,
    bool useCache = true,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<Note>(
      where: where != null ? where(Note.t) : null,
      limit: limit,
      offset: offset,
      orderBy: orderBy,
      orderByList: orderByList,
      orderDescending: orderDescending,
      useCache: useCache,
      transaction: transaction,
    );
  }

  static Future<Note?> findSingleRow(
    _i1.Session session, {
    NoteExpressionBuilder? where,
    int? offset,
    _i1.Column? orderBy,
    bool orderDescending = false,
    bool useCache = true,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findSingleRow<Note>(
      where: where != null ? where(Note.t) : null,
      offset: offset,
      orderBy: orderBy,
      orderDescending: orderDescending,
      useCache: useCache,
      transaction: transaction,
    );
  }

  static Future<Note?> findById(
    _i1.Session session,
    int id,
  ) async {
    return session.db.findById<Note>(id);
  }

  static Future<int> delete(
    _i1.Session session, {
    required NoteExpressionBuilder where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Note>(
      where: where(Note.t),
      transaction: transaction,
    );
  }

  static Future<bool> deleteRow(
    _i1.Session session,
    Note row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow(
      row,
      transaction: transaction,
    );
  }

  static Future<bool> update(
    _i1.Session session,
    Note row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.update(
      row,
      transaction: transaction,
    );
  }

  static Future<void> insert(
    _i1.Session session,
    Note row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert(
      row,
      transaction: transaction,
    );
  }

  static Future<int> count(
    _i1.Session session, {
    NoteExpressionBuilder? where,
    int? limit,
    bool useCache = true,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Note>(
      where: where != null ? where(Note.t) : null,
      limit: limit,
      useCache: useCache,
      transaction: transaction,
    );
  }
}

typedef NoteExpressionBuilder = _i1.Expression Function(NoteTable);

class NoteTable extends _i1.Table {
  NoteTable() : super(tableName: 'note');

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  final id = _i1.ColumnInt('id');

  /// The contents of the note.
  final text = _i1.ColumnString('text');

  @override
  List<_i1.Column> get columns => [
        id,
        text,
      ];
}

@Deprecated('Use NoteTable.t instead.')
NoteTable tNote = NoteTable();
