import '../../types/types.dart';
import 'collectables/collectables_model.dart';
import 'countables/countables_model.dart';
import 'levels/levels_model.dart';
import 'stats/stats_model.dart';

class ActionChartModel {
  final collectables = CollectablesModel();
  final countables = CountablesModel();
  final levels = LevelsModel();
  final stats = StatsModel();

  ActionChartModel();

  Json toJson() => {
        'collectables': collectables.toJson(),
        'countables': countables.toJson(),
        'stats': stats.toJson(),
      };

  @override
  String toString() {
    return toJson().toString();
  }

  void setup(Json setupData) {
    final collectableData = setupData['collectables'] as JsonList;
    final countableData = setupData['countables'] as JsonList;
    final levelData = setupData['levels'] as JsonList;
    final statData = setupData['stats'] as JsonList;

    if (collectableData.isNotEmpty) {
      for (var collectable in collectableData) {
        collectables.add(
            collectable['key'].toString(), collectable['max'] as int);
      }
    }

    if (countableData.isNotEmpty) {
      for (var countable in countableData) {
        countables.add(countable['key'].toString(), 0);
      }
    }

    if (levelData.isNotEmpty) {
      for (var level in levelData) {
        levels.add(level['key'].toString(), level['level'] as int);
      }
    }

    if (statData.isNotEmpty) {
      for (var stat in statData) {
        stats.add(stat['key'].toString(), 0);
      }
    }
  }
}
