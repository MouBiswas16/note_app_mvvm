// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app_mvvm/models/note_model.dart';
import 'package:note_app_mvvm/viewmodels/note_view_model.dart';

class NoteListView extends StatelessWidget {
  final NoteViewModel viewModel = NoteViewModel();

  NoteListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Note app"),
      ),
      body: BlocBuilder<NoteViewModel, List<Note>>(
        // cubit: viewModel,
        builder: (context, notes) {
          return ListView.builder(
            itemCount: notes.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(notes[index].title!),
                subtitle: Text(notes[index].content!),
                onTap: () {
                  _editNote(context, notes[index], index);
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addtNote(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _addtNote(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        String? title = "";
        String? content = "";

        return AlertDialog(
          title: Text("Add Note"),
          content: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: "Tittle",
                ),
                onChanged: (value) {
                  content = value;
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Note note = Note(
                  title: title,
                  content: content,
                );
                viewModel.addNote(note);
                Navigator.of(context).pop();
              },
              child: Text("Add"),
            ),
          ],
        );
      },
    );
  }

  void _editNote(BuildContext context, Note note, int index) {
    showDialog(
      context: context,
      builder: (context) {
        String? title = note.title;
        String? content = note.content;

        return AlertDialog(
          title: Text("Edit Note"),
          content: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: "Title",
                ),
                onChanged: (value) {
                  title = value;
                },
                controller: TextEditingController(text: title),
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: "content",
                ),
                onChanged: (value) {
                  content = value;
                },
                controller: TextEditingController(text: content),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Note updateNote = Note(
                  title: title,
                  content: content,
                );
                viewModel.updateNote(index, updateNote);
                Navigator.of(context).pop();
              },
              child: Text("Update"),
            ),
            TextButton(
              onPressed: () {
                viewModel.deleteNote(index);
                Navigator.of(context).pop();
              },
              child: Text("Delete"),
            ),
          ],
        );
      },
    );
  }
}
