import 'package:flutter/material.dart';

import 'widget/get_direction_button.dart';
import 'widget/go_home_text.dart';
import 'widget/popup_menu.dart';

class CompassScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GoHomeText(),
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        actions: <Widget>[
          PopUpMenuOptions(),
        ],
      ),
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Spacer(
                flex: 3,
              ),
              //  Compass(),
              Spacer(
                flex: 6,
              ),
              GetDirectionButton(),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
