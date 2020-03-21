import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/home_direction_bloc.dart';
import '../../locale/app_localization.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            children: <Widget>[
              Expanded(
                  child: ListView(
                children: <Widget>[
                  Center(child: Text("Content")),
                ],
              )),
              SizedBox(
                height: 20,
              ),
              FlatButton(
                onPressed: () => BlocProvider.of<HomeDirectionBloc>(context)
                    .add(HomeDirectionSetEvent()),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 4),
                  child: Text(
                    localizedText(context, 'setHomeLocation'),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),
    );
  }
}
