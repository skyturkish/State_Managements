import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_app/bloc/app_state.dart';
import 'package:image_app/bloc/bloc_events.dart';
import 'package:image_app/extensions/Iterable.dart';

// test edilebilir olması bir için bir fonksiyon yardımı ile seçiyoruz random url'i
// TODO english
typedef AppBlocRandomUrlPicker = String Function(Iterable<String> allUrls);

class AppBloc extends Bloc<AppEvent, AppState> {
  String _pickRandomUrl(Iterable<String> allUrls) => allUrls.getRandomElement();

  AppBloc({
    required Iterable<String> urls,
    Duration? waitBeforeLoading,
    AppBlocRandomUrlPicker? urlPicker,
  }) : super(const AppState.empty()) {
    on(
      (event, emit) async {
        // start loading
        emit(
          const AppState(
            isLoading: true,
            data: null,
            error: null,
          ),
        );
        final url = (urlPicker ?? _pickRandomUrl)(urls);

        try {
          if (waitBeforeLoading != null) {
            await Future.delayed(waitBeforeLoading);
          }
          final bundle = NetworkAssetBundle(Uri.parse(url));
          final data = (await bundle.load(url)).buffer.asUint8List();

          emit(
            AppState(
              isLoading: false,
              data: data,
              error: null,
            ),
          );
        } catch (e) {
          emit(
            AppState(
              isLoading: false,
              data: null,
              error: e,
            ),
          );
        }
      },
    );
  }
}
