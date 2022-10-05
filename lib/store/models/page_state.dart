import 'package:flutter/material.dart';

import '../../constants/books.dart';

@immutable
class PageState {
  final int sectionNumber;
  final String pageId;

  const PageState({
    required this.pageId,
    required this.sectionNumber,
  });

  const PageState.initialState()
      : pageId = '',
        sectionNumber = pageMin;

  PageState copyWith({String? pageId, int? sectionNumber}) => PageState(
        pageId: pageId ?? this.pageId,
        sectionNumber: sectionNumber ?? this.sectionNumber,
      );

  int getSectionNumber(String link) {
    return int.parse(link.replaceFirst(sectionPrefix, ''));
  }
}
