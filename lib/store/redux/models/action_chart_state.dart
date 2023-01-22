import 'package:flutter/material.dart';

@immutable
class ActionChartState {
  final bool isVisible;

  const ActionChartState({
    required this.isVisible,
  });

  const ActionChartState.initialState() : isVisible = false;

  ActionChartState copyWith({bool? isVisible}) => ActionChartState(isVisible: isVisible ?? this.isVisible);
}
