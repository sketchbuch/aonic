import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../../constants/books.dart';
import '../../i18n/_generated_/translations.g.dart';
import '../../routes/generate_book_route.dart';
import '../../routes/routes.dart';
import '../../store/models/app_state.dart';
import 'view_models/book_view_model.dart';

class BookPage extends StatefulWidget {
  final transBook = t.book;
  final transCommon = t.common;

  BookPage({Key? key}) : super(key: key);

  @override
  State<BookPage> createState() => _BookPageState();
}

class _BookPageState extends State<BookPage> {
  Future<void> _onExitPressed() async {
    final isConfirmed = await _canExitBook();

    if (isConfirmed && mounted) {
      _exitSetup();
    }
  }

  Future<bool> _canExitBook() async {
    return await showDialog<bool>(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Are you sure?'),
                content: const Text('If you exit device setup, your progress will be lost.'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                    child: const Text('Leave'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                    child: const Text('Stay'),
                  ),
                ],
              );
            }) ??
        false;
  }

  void _exitSetup() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, BookViewModel>(
      converter: (store) => BookViewModel.create(store),
      builder: (BuildContext context, BookViewModel viewModel) {
        var titleText = widget.transBook.titleSelection;

        if (viewModel.isLoading) {
          titleText = widget.transBook.titleLoading;
        } else if (viewModel.isBookLoaded) {
          titleText = widget.transBook.title;
        }

        return WillPopScope(
          onWillPop: _canExitBook,
          child: Scaffold(
            appBar: AppBar(
              actions: viewModel.isBookLoaded
                  ? [
                      IconButton(
                        icon: const Icon(Icons.navigate_before),
                        onPressed: viewModel.page > pageMin ? viewModel.onPrevPage : null,
                        tooltip: widget.transCommon.prev,
                      ),
                      IconButton(
                        icon: const Icon(Icons.navigate_next),
                        onPressed: viewModel.page < pageMax ? viewModel.onNextPage : null,
                        tooltip: widget.transCommon.next,
                      ),
                    ]
                  : [],
              title: Text(titleText),
            ),
            body: Navigator(
              key: bookNav,
              initialRoute: bookRoute,
              onGenerateRoute: generateBookRoute,
            ),
          ),
        );
      },
    );
  }
}
