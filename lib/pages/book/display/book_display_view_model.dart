import 'package:redux/redux.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../exceptions/gameplay.dart';
import '../../../models/book/book.dart';
import '../../../routes/routes.dart';
import '../../../store/actions/actions.dart';
import '../../../store/models/app_state.dart';
import '../../../store/models/book_state.dart';
import '../../../types/types.dart';

class BookDisplayViewModel {
  final Book? book;
  final bool isLoading;
  final OnNavigate onNavigate;
  final String pageId;

  BookDisplayViewModel({
    required this.book,
    required this.isLoading,
    required this.onNavigate,
    required this.pageId,
  });

  factory BookDisplayViewModel.create(Store<AppState> store) {
    final state = store.state;
    final bookState = state.bookState;
    final pageState = state.pageState;

    Future<void> _launchUrl(String link) async {
      if (!await launchUrl(Uri.parse(link))) {
        throw GameplayException('Could not launch $link');
      }
    }

    void onNavigate(String link) {
      if (link.startsWith('http')) {
        _launchUrl(link);
      } else {
        store.dispatch(PageNavigateAction(bookNav, link));
      }
    }

    return BookDisplayViewModel(
      book: bookState.book,
      isLoading: bookState.status != BookStateStatus.succeeded || bookState.book == null,
      onNavigate: onNavigate,
      pageId: pageState.pageId,
    );
  }
}
