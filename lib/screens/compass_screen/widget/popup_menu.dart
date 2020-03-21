import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../locale/app_localization.dart';
import '../../../bloc/home_direction_bloc.dart';

class PopUpMenuOptions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      onSelected: (value) {
        if (value == "ChangeHome") {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text("${localizedText(context, 'changeHome')}"),
                  content: Text(
                      "${localizedText(context, 'areYouSureYouWantToChangeHomeLocation')}"),
                  actions: <Widget>[
                    FlatButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text("${localizedText(context, 'cancel')}")),
                    FlatButton(
                        onPressed: () {
                          Navigator.maybePop(context);
                          BlocProvider.of<HomeDirectionBloc>(context)
                              .add(HomeDirectionChangeEvent());
                        },
                        child: Text("${localizedText(context, 'change')}")),
                  ],
                );
              });
        }
      },
      itemBuilder: (BuildContext context) => [
        PopupMenuItem(
            value: "ChangeHome",
            child: Text("${localizedText(context, 'changeHomeLocation')}"))
      ],
    );
  }
}
