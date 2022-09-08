import 'package:flutter/material.dart';

class BookLoadingPage extends StatelessWidget {
  const BookLoadingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
