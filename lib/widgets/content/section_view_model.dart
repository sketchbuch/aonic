import 'package:redux/redux.dart';

import '../../store/redux/models/app_state.dart';

class SectionViewModel {
  final int bookNumber;
  final String bookCode;

  SectionViewModel({
    required this.bookCode,
    required this.bookNumber,
  });

  factory SectionViewModel.create(Store<AppState> store) {
    final state = store.state;
    final bookState = state.bookState;

    return SectionViewModel(
      bookCode: bookState.bookCode,
      bookNumber: bookState.bookNumber,
    );
  }
}
