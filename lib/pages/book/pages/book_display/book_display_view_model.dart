import 'package:redux/redux.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../exceptions/gameplay.dart';
import '../../../../models/book/book_model.dart';
import '../../../../routes/routes.dart';
import '../../../../store/redux/actions/action_chart.dart';
import '../../../../store/redux/actions/actions.dart';
import '../../../../store/redux/models/app_state.dart';
import '../../../../store/redux/models/book_state.dart';
import '../../../../types/types.dart';

class BookDisplayViewModel {
  final Book? book;
  final bool isActionChartVisible;
  final bool isLoading;
  final OnNavigate onNavigate;
  final String pageId;
  final void Function(bool isVisible) onActionChartClick;

  BookDisplayViewModel({
    required this.book,
    required this.isActionChartVisible,
    required this.isLoading,
    required this.onActionChartClick,
    required this.onNavigate,
    required this.pageId,
  });

  factory BookDisplayViewModel.create(Store<AppState> store) {
    final state = store.state;
    final actionChartState = state.actionChartState;
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

    void onActionChartClick(bool isVisible) {
      if (isVisible) {
        store.dispatch(ActionChartClose());
      } else {
        store.dispatch(ActionChartOpen());
      }
    }

    return BookDisplayViewModel(
      book: bookState.book,
      isActionChartVisible: actionChartState.isVisible,
      isLoading: bookState.status != BookStateStatus.succeeded ||
          bookState.book == null,
      onActionChartClick: onActionChartClick,
      onNavigate: onNavigate,
      pageId: pageState.pageId,
    );
  }
}
