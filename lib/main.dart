import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/home_direction_bloc.dart';
import 'locale/app_localization.dart';
import 'screens/compass_screen/compass_screen.dart';
import 'screens/welcome_screen/welcome_screen.dart';
import 'style/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  BlocSupervisor.delegate = await HydratedBlocDelegate.build();
  runApp(GoHomeApp());
}

class GoHomeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return BlocProvider<HomeDirectionBloc>(
      create: (_) => HomeDirectionBloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: darkTheme,
        title: 'Go Home',
        home: BlocBuilder<HomeDirectionBloc, HomeDirectionState>(
          builder: (context, state) {
            if (state is HomeDirectionNotSetState) {
              return WelcomeScreen();
            } else {
              assert(state is HomeDirectionSetState);
              return CompassScreen();
            }
          },
        ),
        supportedLocales: [
          Locale('en', 'US'),
          Locale('fr', 'FR'),
          Locale('zh'),
          Locale('ar'),
        ],
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
      ),
    );
  }
}
