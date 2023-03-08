import 'package:notes_client/notes_client.dart';
import 'package:flutter/material.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';

import 'loading_screen.dart';
import 'note_dialog.dart';

// Sets up a singleton client object that can be used to talk to the server from
// anywhere in our app. The client is generated from your server code.
// The client is set up to connect to a Serverpod running on a local server on
// the default port. You will need to modify this to connect to staging or
// production servers.
var client = Client('http://localhost:8080/')
  ..connectivityMonitor = FlutterConnectivityMonitor();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notes',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Notes'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  // This field holds the list of notes that we've received from the server or
  // null if no notes have been received yet.
  List<Note>? _notes;

  // If the connection to the server fails, this field will hold the exception
  // that was thrown.
  Exception? _connectionException;

  @override
  void initState() {
    super.initState();
    _loadNotes();
  }

  Future<void> _loadNotes() async {
    try {
      final notes = await client.notes.getAllNotes();
      setState(() {
        _notes = notes;
      });
    } catch (e) {
      _connectionFailed(e);
    }
  }

  Future<void> _deleteNote(Note note) async {
    try {
      await client.notes.deleteNote(note);
      await _loadNotes();
    } catch (e) {
      _connectionFailed(e);
    }
  }

  Future<void> _createNote(Note note) async {
    try {
      await client.notes.createNote(note);
      await _loadNotes();
    } catch (e) {
      _connectionFailed(e);
    }
  }

  Future<void> _updateNote(Note note) async {
    try {
      await client.notes.updateNote(note);
      await _loadNotes();
    } catch (e) {
      _connectionFailed(e);
    }
  }

  void _connectionFailed(dynamic exception) {
    // If the connection to the server fails, we clear the list of notes and
    // store the exception that was thrown. This will make the loading screen
    // appear and show a button to try again.

    // In a real app you would probably want to do more complete error handling.
    setState(() {
      _notes = null;
      _connectionException = exception;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: _notes == null
          ? LoadingScreen(
              exception: _connectionException,
              onTryAgain: _loadNotes,
            )
          : ListView.builder(
              itemCount: _notes!.length,
              itemBuilder: ((context, index) {
                return ListTile(
                  title: Text(_notes![index].text),
                  onTap: () {
                    // When we tap a list tile we want to show a dialog where
                    // we can edit the note.
                    showNoteDialog(
                      context: context,
                      text: _notes![index].text,
                      onSaved: (text) {
                        // We lazily update the note in the list of notes before
                        // we've received a response from the server which makes
                        // the UI feel more responsive.
                        setState(() {
                          _notes![index].text = text;
                        });

                        // Actually update the note on the server.
                        _updateNote(
                          _notes![index],
                        );
                      },
                    );
                  },
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      // Get the note that we want to delete.
                      var note = _notes![index];

                      // We lazily remove the note from the list of notes before
                      // we've received a response from the server which makes
                      // the UI feel more responsive.
                      setState(() {
                        _notes!.remove(note);
                      });

                      // Actually delete the note from the server.
                      _deleteNote(note);
                    },
                  ),
                );
              }),
            ),
      floatingActionButton: _notes == null
          ? null
          : FloatingActionButton(
              onPressed: () {
                // When we tap the floating action button we want to show a
                // dialog where we can create a new note.
                showNoteDialog(
                  context: context,
                  onSaved: (text) {
                    var note = Note(
                      text: text,
                    );

                    // Add the note to the list of notes before we've received
                    // a response from the server which makes the UI feel more
                    // responsive.
                    _notes!.add(note);

                    // Actually create the note on the server.
                    _createNote(note);
                  },
                );
              },
              child: const Icon(Icons.add),
            ),
    );
  }
}
