import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/apis/login_api.dart';
import 'package:notes_app/apis/notes_api.dart';
import 'package:notes_app/bloc/actions.dart';
import 'package:notes_app/bloc/app_state.dart';
import 'package:notes_app/models.dart';

class AppBloc extends Bloc<AppAction, AppState> {
  final LoginApiProtocol loginApi;
  final NotesApiProtocol notesApi;
  final LoginHandle acceptedLoginHandle;

  AppBloc({
    required this.loginApi,
    required this.notesApi,
    required this.acceptedLoginHandle,
  }) : super(const AppState.empty()) {
    on<LoginAction>(
      (event, emit) async {
        // start loading
        emit(
          const AppState(
            isLoading: true,
            loginError: null,
            loginHandle: null,
            fetchedNotes: null,
          ),
        );
        // log the user in
        // TODO right this comments for english
        // bunu kullanan kişi buna event verecek, bu event'in içinde email ve password olacak
        // onları buradan alıyoruz
        final loginHandle = await loginApi.login(
          email: event.email,
          password: event.password,
        );

        emit(
          AppState(
            isLoading: false,
            loginError: loginHandle == null ? LoginErrors.invalidHandle : null,
            loginHandle: loginHandle,
            fetchedNotes: null,
          ),
        );
      },
    );

    on<LoadNotesAction>(
      (event, emit) async {
        emit(
          AppState(
            isLoading: true,
            loginError: null,
            // diğer bir emite geçsek bile, az önceki state'i okuyup değerleri alabiliyoruz
            loginHandle: state.loginHandle,
            fetchedNotes: null,
          ),
        );
        final loginHandle = state.loginHandle;
        if (loginHandle != acceptedLoginHandle) {
          emit(
            AppState(
              isLoading: false,
              loginError: LoginErrors.invalidHandle,
              loginHandle: loginHandle,
              fetchedNotes: null,
            ),
          );
          return;
        }

        final notes = await notesApi.getNotes(
          loginHandle: loginHandle!,
        );

        emit(
          AppState(
            isLoading: false,
            loginError: null,
            loginHandle: loginHandle,
            fetchedNotes: notes,
          ),
        );
      },
    );
  }
}
