import 'package:bot_2000/core/models/notes/note_book.dart';
import 'package:bot_2000/core/models/user.dart';
import 'package:bot_2000/core/view_model/note_methods.dart';
import 'package:bot_2000/core/view_model/view_model.dart';
import 'package:bot_2000/view/components/home_components/left_side/left_bottom.dart';
import 'package:bot_2000/view/components/home_components/left_side/notebook_button.dart';
import 'package:bot_2000/view/components/home_components/left_side/profile_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LeftArea extends StatelessWidget {
  const LeftArea({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            const ProfileBar(),
            noteBooks(context),
          ],
        ),
        const LeftBottom()
      ],
    );
  }

  Widget noteBooks(BuildContext context) {
    final _viewModel = Provider.of<ViewModel>(context, listen: false);
    return FutureBuilder<User?>(
      future: _viewModel.getCurrentUser(),
      builder: (context, AsyncSnapshot<User?> snapshot) {
        if (snapshot.hasData) {
          return streamBuilder(snapshot.data!.userId!);
        } else if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        } else {
          return const Center(
            child: SizedBox(
              child: CircularProgressIndicator(),
              width: 60,
              height: 60,
            ),
          );
        }
      },
    );
  }

  StreamBuilder<List<NoteBook?>> streamBuilder(String userId) {
    final noteMethods = NoteMethods();
    return StreamBuilder<List<NoteBook?>>(
        stream: noteMethods.getNoteBooks(userId),
        builder:
            (BuildContext context, AsyncSnapshot<List<NoteBook?>> snapshot) {
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          } else {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return const Text("None");
              case ConnectionState.waiting:
                return const Center(
                  child: SizedBox(
                    child: CircularProgressIndicator(),
                    width: 60,
                    height: 60,
                  ),
                );
              case ConnectionState.active:
                List<NoteBook?> _result = snapshot.data!;

                return ListView.builder(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    NoteBook _noteBook = _result[index]!;
                    return NoteBookButton(
                      subTitle: _noteBook.noteList?.length.toString(),
                      title: _noteBook.text!,
                      noteBookId: _noteBook.noteBookId!,
                    );
                  },
                  itemCount: _result.length,
                );
              case ConnectionState.done:
                return const Text("Done");
              default:
                return const Text("Default");
            }
          }
        });
  }
}