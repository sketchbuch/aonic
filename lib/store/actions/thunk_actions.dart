import 'package:lonewolf_new/store/models/app_state.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:xml/xml.dart';

import '../../models/book/book.dart';
import '../../models/booklist/booklist_item.dart';
import '../../utils/get_aon_book_data.dart';
import '../../utils/xml/helpers.dart';
import 'actions.dart';

ThunkAction<AppState> loadBookAction(BooklistItem selectedBook) {
  return (Store<AppState> store) async {
    store.dispatch(LoadBookRequest());

    try {
      final bookData = await getAonBookData(selectedBook);
      final bookXml = XmlDocument.parse(cleanXmlString(bookData));
      final gamebook = bookXml.getElement('gamebook');

      if (gamebook != null) {
        Book book = Book.fromXml(gamebook);
        store.dispatch(LoadBookSuccess(bookData, book));
      } else {
        store.dispatch(LoadBookFaliure('Book data does not contain a "gamebook" element'));
      }
    } catch (error) {
      store.dispatch(LoadBookFaliure(error.toString()));
    }
  };
}
