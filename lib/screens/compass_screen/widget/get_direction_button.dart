import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_driving_directions/flutter_driving_directions.dart';
import 'package:location/location.dart';

import '../../../bloc/home_direction_bloc.dart';
import '../../../locale/app_localization.dart';

class GetDirectionButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    LocationData homeLocationData() =>
        (BlocProvider.of<HomeDirectionBloc>(context).state
                as HomeDirectionSetState)
            .locationData;
    return Container(
      child: FlatButton.icon(
        onPressed: () async {
          try {
            await FlutterDrivingDirections.launchDirections(
                latitude: homeLocationData().latitude,
                longitude: homeLocationData().longitude,
                address: '${localizedText(context, 'home')}');
          } on PlatformException catch (_) {
            showModalBottomSheet(
                context: context,
                builder: (context) {
                  return BottomSheet(
                    onClosing: () {},
                    builder: (context) => Container(
                        width: double.infinity,
                        alignment: Alignment.center,
                        height: 40,
                        child: Text(
                            "${localizedText(context, 'unableToLaunchGoogleMap')}")),
                  );
                });
          }
        },
        icon: Icon(Icons.directions),
        label: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text('${localizedText(context, 'getDirection')}'),
        ),
      ),
    );
  }
}
