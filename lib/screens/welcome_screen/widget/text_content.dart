import 'package:flutter/material.dart';

class TextContent extends StatelessWidget {
  final String title;
  final String content;

  const TextContent({Key key, @required this.title, @required this.content})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            textAlign: TextAlign.start,
            style: Theme.of(context)
                .textTheme
                .headline5
                .copyWith(color: Theme.of(context).primaryColor),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            content,
            textAlign: TextAlign.start,
            style: Theme.of(context)
                .textTheme
                .body1
                .copyWith(color: Theme.of(context).primaryColor),
          )
        ],
      ),
    );
  }
}
