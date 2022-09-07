import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/apis/login_api.dart';
import 'package:notes_app/apis/notes_api.dart';
import 'package:notes_app/bloc/actions.dart';
import 'package:notes_app/bloc/app_bloc.dart';
import 'package:notes_app/bloc/app_state.dart';
import 'package:notes_app/core/constants/strings.dart';
import 'package:notes_app/dialogs/generic_dialog.dart';
import 'package:notes_app/dialogs/loading_screen.dart';
import 'package:notes_app/models.dart';
import 'package:notes_app/views/iterable_list_view.dart';
import 'package:notes_app/views/login_view.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Material App',
      home: HomeView(),
    );
  }
}

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppBloc(
        loginApi: LoginApi(),
        notesApi: NotesApi(),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(StringConstants.homeView),
        ),
        body: BlocConsumer<AppBloc, AppState>(
          listener: (context, appState) {
            // listener help us to show loading screen
            if (appState.isLoading) {
              LoadingScreen.instance().show(
                context: context,
                text: StringConstants.pleaseWait,
              );
            } else {
              LoadingScreen.instance().hide();
            }

            final loginError = appState.loginError;

            if (loginError != null) {
              showGenericDialog<bool>(
                context: context,
                title: StringConstants.loginErrorDialogTitle,
                content: StringConstants.loginErrorDialogContent,
                optionsBuilder: () => {
                  StringConstants.ok: true,
                },
              );
            }

            if (appState.isLoading == false &&
                appState.loginError == null &&
                appState.loginHandle == const LoginHandle.fooBar() &&
                appState.fetchedNotes == null) {
              context.read<AppBloc>().add(
                    LoadNotesAction(),
                  );
            }
          },
          builder: (context, appState) {
            final notes = appState.fetchedNotes;
            if (notes == null) {
              return LoginView(
                onLoginTapped: (email, password) {
                  context.read<AppBloc>().add(
                        LoginAction(
                          email: email,
                          password: password,
                        ),
                      );
                },
              );
            } else {
              return notes.toListView();
            }
          },
        ),
      ),
    );
  }
}
