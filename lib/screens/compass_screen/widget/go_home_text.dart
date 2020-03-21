import 'package:flutter/material.dart';

import '../../../locale/app_localization.dart';

class GoHomeText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      child: Text(
        '${localizedText(context, 'appName')}',
        style: theme.textTheme.headline4,
      ),
    );
  }
}
