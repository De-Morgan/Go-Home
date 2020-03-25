import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:gohome/services/location_service.dart';
import 'package:location/location.dart';

import '../../../bloc/home_direction_bloc.dart';
import 'circular_progress.dart';
import 'compass_clipper.dart';

class Compass extends StatefulWidget {
  @override
  _CompassState createState() => _CompassState();
}

class _CompassState extends State<Compass> with AfterLayoutMixin<Compass> {
  /// recalibrate the compass image used
  final imageAngle = pi / 4;

  LocationData get homeLocationData =>
      (BlocProvider.of<HomeDirectionBloc>(context).state
              as HomeDirectionSetState)
          .locationData;

  get homeOffset =>
      Offset(homeLocationData.latitude, homeLocationData.longitude);

  Completer<Tangent> tangent = Completer();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: 300,
      child: Stack(
        children: <Widget>[
          AspectRatio(
            aspectRatio: 1.0,
            child: StreamBuilder<double>(
                stream: FlutterCompass.events,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text('Error reading heading: ${snapshot.error}');
                  }
                  if (!snapshot.hasData) {
                    return CircularProgress();
                  }

                  double direction = snapshot.data;

                  if (direction == null)
                    return Center(
                      child: Text("Device does not have sensors !"),
                    );
                  double angle = ((direction ?? 0) * (pi / 180) * -1);

                  return FutureBuilder(
                      future: tangent.future,
                      builder: (context, AsyncSnapshot<Tangent> snapshot) {
                        if (!snapshot.hasData) {
                          return CircularProgress();
                        }

                        double tangentAngle = (snapshot.data?.angle ?? pi / 2);

                        return Transform.rotate(
                          angle: angle - imageAngle - tangentAngle,
                          child: ClipPath(
                            clipper: CompassClipper(),
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: AssetImage(
                                        "assets/images/compass.png")),
                              ),
                            ),
                          ),
                        );
                      });
                }),
          ),
        ],
      ),
    );
  }

  @override
  void afterFirstLayout(BuildContext context) async {
    calculateTangentAngle();
  }

  void calculateTangentAngle() async {
    try {
      LocationData locationData = await LocationService().getCurrentLocation();
      final myOffset = Offset(locationData.latitude, locationData.longitude);
      Tangent tangentResult = Tangent(Offset.zero, homeOffset - myOffset);
      tangent.complete(tangentResult);
    } on PlatformException catch (_) {
      /// Open settings if user denials permission
      /* PermissionHandler().openAppSettings().then((opened) {
        //
      });*/
    }
  }
}
