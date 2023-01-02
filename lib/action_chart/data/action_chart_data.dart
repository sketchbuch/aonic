import '../../types/types.dart';

final Json lwActionChartData = {
  "collectables": [
    {"key": "backpack", "max": 8},
    {"key": "specialitems", "max": 12},
    {"key": "weapons", "max": 2},
  ],
  "countables": [
    {"key": "food"},
    {"key": "money"},
  ],
  "levels": [
    {"key": "novice", "level": 1},
    {"key": "intuite", "level": 2},
    {"key": "doan", "level": 3},
    {"key": "acolyte", "level": 4},
    {"key": "initiate", "level": 5},
    {"key": "aspirant", "level": 6},
    {"key": "guardian", "level": 7},
    {"key": "warmarn", "level": 8},
    {"key": "savant", "level": 9},
    {"key": "master", "level": 10},
  ],
  "stats": [
    {"key": "skill"},
    {"key": "endurance"}
  ],
};

final Json actionChartData = {
  "lw": lwActionChartData,
};
