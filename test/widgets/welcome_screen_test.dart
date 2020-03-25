import 'dart:math';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../lib/locale/app_localization.dart';
import '../../lib/screens/welcome_screen/welcome_screen.dart';

import '../../lib/bloc/home_direction_bloc.dart';

class MockHomeDirectionBloc
    extends MockBloc<HomeDirectionEvent, HomeDirectionState>
    implements HomeDirectionBloc {}

main() {
  final setHomeLocationWidget = find.byKey(Key("setHomeLocationWelcomePage"));
  final getDirectionWidget = find.byKey(Key("getHomeDirection"));

  Widget _loadApp(Widget child) {
    return MaterialApp(
      home: Scaffold(
        body: child,
      ),
      localizationsDelegates: [
        AppLocalizations.delegate,
      ],
    );
  }

  testWidgets("Show setHomeLocationWidget widget on load",
      (WidgetTester widgetTester) async {
    await widgetTester.pumpWidget(_loadApp(WelcomeScreen()));
    await widgetTester.pumpAndSettle();
    expect(setHomeLocationWidget, findsOneWidget);
    expect(getDirectionWidget, findsNothing);
  });

}
