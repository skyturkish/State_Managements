import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show SystemUiOverlayStyle;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_app/bloc/bottom_bloc.dart';
import 'package:image_app/bloc/top_bloc.dart';
import 'package:image_app/models/constants.dart';
import 'package:image_app/view/app_bloc_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: MultiBlocProvider(
          providers: [
            BlocProvider<TopBloc>(
              create: (_) => TopBloc(waitBeforeLoading: const Duration(seconds: 3), urls: ConstantsImages.images),
            ),
            BlocProvider<BottomBloc>(
              create: (_) => BottomBloc(waitBeforeLoading: const Duration(seconds: 3), urls: ConstantsImages.images),
            ),
          ],
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: const [
              AppBlocView<TopBloc>(),
              AppBlocView<BottomBloc>(),
            ],
          ),
        ),
      ),
    );
  }
}
