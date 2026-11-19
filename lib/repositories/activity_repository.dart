import '../data/activity_data.dart';
import '../models/activity_model.dart';

class ActivityRepository {
  ActivityRepository({required ActivityData dataSource})
      : _dataSource = dataSource;

  final ActivityData _dataSource;

  List<ActivityModel> getActivities() {
    return _dataSource.activities;
  }

  ActivityModel? getActivityById(String id) {
    return _dataSource.findById(id);
  }

  void addActivity(ActivityModel activity) {
    _dataSource.add(activity);
  }

  bool updateActivity(ActivityModel activity) {
    return _dataSource.update(activity);
  }

  bool deleteActivity(String id) {
    return _dataSource.remove(id);
  }
}
