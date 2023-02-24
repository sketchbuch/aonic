import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../../constants/books.dart';
import '../../i18n/_generated_/translations.g.dart';
import '../../routes/generate_book_route.dart';
import '../../routes/routes.dart';
import '../../store/redux/models/app_state.dart';
import 'book_view_model.dart';

class BookPage extends StatefulWidget {
  final transBook = t.book;
  final transCommon = t.common;
  final random = Random();

  BookPage({Key? key}) : super(key: key);

  @override
  State<BookPage> createState() => _BookPageState();
}

class _BookPageState extends State<BookPage> {
  int? randomNumber;

  _handleShowActionChart(void Function(bool) toggleActionChart, bool isVisible) {
    toggleActionChart(isVisible);
  }

  /* Future<void> _onExitPressed() async {
    final isConfirmed = await _canExitBook();

    if (isConfirmed && mounted) {
      _exitSetup();
    }
  } */

  Future<bool> _canExitBook(BookViewModel viewModel) async {
    return await showDialog<bool>(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Are you sure?'),
                content: const Text('If you leave the book, your progress will be lost.'),
                actions: [
                  TextButton(
                    onPressed: () {
                      viewModel.onUnloadBook();
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

  /* void _exitSetup() {
    Navigator.of(context).pop();
  } */

  void handleRandomNumberPicker() {
    setState(() {
      randomNumber = widget.random.nextInt(9);
    });
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, BookViewModel>(
      converter: (store) => BookViewModel.create(store),
      builder: (BuildContext context, BookViewModel viewModel) {
        String titleText = widget.transBook.titleSelection;
        String tooltipText = widget.transBook.buttons.loadButton.labelLoad;

        if (viewModel.isLoading) {
          titleText = widget.transBook.titleLoading;
        } else if (viewModel.isBookLoaded) {
          if (viewModel.isSection) {
            titleText =
                widget.transBook.titleSection(bookTitle: viewModel.bookTitle, sectionTitle: viewModel.sectionTitle);
          } else {
            titleText = widget.transBook.title(bookTitle: viewModel.bookTitle, pageTitle: viewModel.sectionTitle);
          }

          tooltipText = widget.transBook.buttons.loadButton.labelUnload;
        }

        return WillPopScope(
          onWillPop: () => _canExitBook(viewModel),
          child: Scaffold(
            appBar: AppBar(
              actions: viewModel.isBookLoaded
                  ? [
                      IconButton(
                        icon: const Icon(Icons.navigate_before),
                        onPressed: viewModel.sectionNumber >= pageMin ? viewModel.onPrevPage : null,
                        tooltip: widget.transCommon.prev,
                      ),
                      IconButton(
                        icon: const Icon(Icons.navigate_next),
                        onPressed: viewModel.sectionNumber < pageMax ? viewModel.onNextPage : null,
                        tooltip: widget.transCommon.next,
                      ),
                      SizedBox(
                        width: 80,
                        child: ElevatedButton(
                          onPressed: handleRandomNumberPicker,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(randomNumber == null ? '-' : randomNumber.toString()),
                              const SizedBox(width: 5),
                              const Icon(Icons.casino, size: 24.0),
                            ],
                          ),
                        ),
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
            bottomNavigationBar: viewModel.isBookLoaded
                ? BottomNavigationBar(
                    onTap: (value) {
                      if (value == 0) {
                        viewModel.onActionChartClick(viewModel.isActionChartVisible);
                        if (!viewModel.isActionChartVisible) {
                          _handleShowActionChart(viewModel.onActionChartClick, viewModel.isActionChartVisible);
                        }
                      }
                    },
                    items: <BottomNavigationBarItem>[
                      BottomNavigationBarItem(
                        icon: const Icon(Icons.account_box_rounded),
                        label: widget.transBook.buttons.actionChart.label,
                      ),
                      BottomNavigationBarItem(
                        icon: const Icon(Icons.sports_kabaddi_rounded),
                        label: widget.transBook.buttons.combat.label,
                      ),
                    ],
                  )
                : null,
            floatingActionButton: viewModel.canShowActionButton
                ? FloatingActionButton(
                    onPressed: () {
                      final selectedBook = viewModel.selectedBook;

                      if (viewModel.isBookLoaded) {
                        viewModel.onUnloadBook();
                        bookNav.currentState!.pushNamed(bookRoute);
                      } else if (selectedBook != null) {
                        viewModel.onLoadBook(selectedBook);
                      }
                    },
                    tooltip: tooltipText,
                    child: Icon(viewModel.isBookLoaded ? Icons.home : Icons.download),
                  )
                : null,
          ),
        );
      },
    );
  }
}
