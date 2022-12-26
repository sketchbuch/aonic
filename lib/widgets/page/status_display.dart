import 'package:flutter/material.dart';

import '../../constants/layout.dart';
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
      padding: const EdgeInsets.all(paddingExtraLarge),
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
