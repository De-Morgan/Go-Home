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
import 'compass_clipper.dart';

class Compass extends StatefulWidget {
  @override
  _CompassState createState() => _CompassState();
}

class _CompassState extends State<Compass> with AfterLayoutMixin<Compass> {
  final imageAngle = pi / 4;
  LocationData get homeLocationData =>
      (BlocProvider.of<HomeDirectionBloc>(context).state
              as HomeDirectionSetState)
          .locationData;
  get homeOffset =>
      Offset(homeLocationData.latitude, homeLocationData.longitude);
  LocationData currentLocation;
  Completer<Tangent> tangent = Completer();

  //Todo check if defition by pi / 2 is necessary

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
                    return Container(
                      alignment: FractionalOffset.center,
                      child: CircularProgressIndicator(),
                    );
                  }
                  double direction = snapshot.data;

                  // if direction is null, then device does not support this sensor
                  // show error message
                  if (direction == null)
                    return Center(
                      child: Text("Device does not have sensors !"),
                    );
                  double angle = ((direction ?? 0) * (pi / 180) * -1);

                  return FutureBuilder(
                      future: tangent.future,
                      builder: (context, AsyncSnapshot<Tangent> snapshot) {
                        if (!snapshot.hasData) {
                          return Container(
                            alignment: FractionalOffset.center,
                            child: CircularProgressIndicator(),
                          );
                        }

                        double tangentAngle = (snapshot.data?.angle ?? pi / 2);

                        return Transform.rotate(
                          angle: angle - imageAngle - tangentAngle,
                          child: ClipPath(
                            clipper: CompassClipper(),
                            child: Container(
                              child: CustomPaint(
                                  //  painter: CompassCustomPainter(),
                                  ),
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
    try {
      LocationData locationData = await LocationService.getCurrentLocation();
      final myOffset = Offset(locationData.latitude, locationData.longitude);
      Tangent tangentResult = Tangent(Offset.zero, homeOffset - myOffset);
      tangent.complete(tangentResult);
    } on PlatformException catch (_) {
      //Todo finalise your plan here
      /// Open settings if user denials permission
      /* PermissionHandler().openAppSettings().then((opened) {
        //
      });*/
    }
  }
}
