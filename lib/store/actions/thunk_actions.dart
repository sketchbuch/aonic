import 'package:lonewolf_new/store/models/app_state.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:xml/xml.dart';

import '../../models/book/book.dart';
import '../../models/booklist/booklist_item.dart';
import '../../routes/routes.dart';
import '../../utils/get_aon_book_data.dart';
import '../../utils/get_aon_book_file_data.dart';
import '../../utils/xml/helpers.dart';
import 'actions.dart';

const useLocalFile = true;

ThunkAction<AppState> loadBookAction(BooklistItem selectedBook) {
  return (Store<AppState> store) async {
    store.dispatch(LoadBookRequest());

    try {
      String bookData = '';

      if (useLocalFile) {
        bookData = await getAonBookFileData();
      } else {
        bookData = await getAonBookData(selectedBook);
      }

      final bookXml = XmlDocument.parse(cleanXmlString(bookData));
      final gamebook = bookXml.getElement('gamebook');

      if (gamebook != null) {
        Book book = Book.fromXml(gamebook);
        store.dispatch(LoadBookSuccess(bookData, book));
        store.dispatch(NavigateAction(bookNav, bookNumberedRoute));
      } else {
        store.dispatch(LoadBookFaliure('Book data does not contain a "gamebook" element'));
      }
    } catch (error) {
      print('### loadBookAction() Error: "${error.toString()}"');
      store.dispatch(LoadBookFaliure(error.toString()));
    }
  };
}
