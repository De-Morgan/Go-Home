import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/home_direction_bloc.dart';
import '../../../locale/app_localization.dart';

class SetHomeBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 80.0,
        width: double.infinity,
        child: FlatButton(
          onPressed: () => BlocProvider.of<HomeDirectionBloc>(context)
              .add(HomeDirectionSetEvent()),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 4),
            child: Text(
              localizedText(context, 'setHomeLocation'),
              textAlign: TextAlign.center,
            ),
          ),
        ));
  }
}
