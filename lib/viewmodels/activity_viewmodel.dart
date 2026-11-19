import 'package:flutter/foundation.dart';

import '../models/activity_model.dart';
import '../repositories/activity_repository.dart';

class ActivityViewModel extends ChangeNotifier {
  ActivityViewModel({required ActivityRepository repository})
      : _repository = repository;

  final ActivityRepository _repository;
  int _idSequence = 0;

  List<ActivityModel> get activities => _repository.getActivities();

  int get totalCounter {
    return activities.fold<int>(
      0,
      (total, activity) => total + activity.counter,
    );
  }

  ActivityModel? findActivityById(String id) {
    return _repository.getActivityById(id);
  }

  bool addActivity(String name) {
    final normalizedName = name.trim();
    if (normalizedName.isEmpty) {
      return false;
    }

    _idSequence += 1;
    final activity = ActivityModel(
      id: '${DateTime.now().microsecondsSinceEpoch}-$_idSequence',
      name: normalizedName,
      counter: 0,
    );
    _repository.addActivity(activity);
    notifyListeners();
    return true;
  }

  bool updateActivityName(String id, String name) {
    final normalizedName = name.trim();
    final current = findActivityById(id);
    if (current == null || normalizedName.isEmpty) {
      return false;
    }

    final updated = _repository.updateActivity(
      current.copyWith(name: normalizedName),
    );
    if (updated) {
      notifyListeners();
    }
    return updated;
  }

  bool incrementCounter(String id) {
    final current = findActivityById(id);
    if (current == null) {
      return false;
    }

    final updated = _repository.updateActivity(
      current.copyWith(counter: current.counter + 1),
    );
    if (updated) {
      notifyListeners();
    }
    return updated;
  }

  bool decrementCounter(String id) {
    final current = findActivityById(id);
    if (current == null || current.counter == 0) {
      return false;
    }

    final updated = _repository.updateActivity(
      current.copyWith(counter: current.counter - 1),
    );
    if (updated) {
      notifyListeners();
    }
    return updated;
  }

  bool resetCounter(String id) {
    final current = findActivityById(id);
    if (current == null || current.counter == 0) {
      return false;
    }

    final updated = _repository.updateActivity(
      current.copyWith(counter: 0),
    );
    if (updated) {
      notifyListeners();
    }
    return updated;
  }

  bool deleteActivity(String id) {
    final deleted = _repository.deleteActivity(id);
    if (deleted) {
      notifyListeners();
    }
    return deleted;
  }
}
