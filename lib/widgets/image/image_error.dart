import 'package:flutter/material.dart';

class ImageError extends StatelessWidget {
  final String errMsg;

  const ImageError(this.errMsg, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(errMsg);
  }
}
