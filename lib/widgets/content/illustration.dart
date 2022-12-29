import 'package:flutter/material.dart';

import '../../../models/book/content/illustration_tag.dart';
import '../layout/content_container.dart';
import 'image/image_error.dart';
import 'image/image_loading.dart';

class Illustration extends StatelessWidget {
  final IllustrationTag tag;

  const Illustration(this.tag, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ContentContainer(
      child: Image.network(
        'https://www.projectaon.org/en/xhtml/lw/01fftd/${tag.getHtmlInstanceFilename()}',
        errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
          if (exception.runtimeType == NetworkImageLoadException) {
            final imageException = exception as NetworkImageLoadException;

            return ImageError('Network Error: "${imageException.statusCode}"');
          }

          return ImageError('Unknown Error: "${exception.toString()}"');
        },
        loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
          if (loadingProgress == null) {
            return child;
          }

          return const ImageLoading();
        },
      ),
    );
  }
}
