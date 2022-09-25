import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../../../store/models/app_state.dart';
import '../../../widgets/frontmatter/book_index.dart';
import 'book_display_view_model.dart';

class BookDisplayPage extends StatelessWidget {
  const BookDisplayPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, BookDisplayViewModel>(
      converter: (store) => BookDisplayViewModel.create(store),
      builder: (BuildContext context, BookDisplayViewModel viewModel) {
        return Scaffold(
          body: Center(child: BookIndex(viewModel.book!)),
        );
      },
    );
  }
}
