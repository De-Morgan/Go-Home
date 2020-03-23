import 'package:flutter/material.dart';

import 'text_content.dart';

class WelcomePageItem extends StatelessWidget {
  final String imageLocation;
  final String title;
  final String description;
  const WelcomePageItem(
      {Key key,
      @required this.title,
      @required this.description,
      @required this.imageLocation})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Spacer(
            flex: 3,
          ),
          Image.asset(
            imageLocation,
            fit: BoxFit.cover,
          ),
          Spacer(),
          TextContent(
            title: title,
            content: description,
          ),
          Spacer(
            flex: 3,
          ),
        ],
      ),
    );
  }
}
