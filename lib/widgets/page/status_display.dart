import 'package:flutter/material.dart';

import '../../types/types.dart';

class StatusDisplay extends StatelessWidget {
  final IconData icon;
  final TranslatedText title;
  final TranslatedText? message;

  const StatusDisplay(this.title, this.icon, {this.message, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final optionalMessage = message;

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(icon),
          Text(title),
          if (optionalMessage != null) Text(optionalMessage),
        ],
      ),
    );
  }
}
