import '../models/activity_model.dart';

class ActivityData {
  ActivityData({List<ActivityModel>? initialActivities})
      : _activities = List<ActivityModel>.from(
          initialActivities ?? _defaultActivities,
        );

  static const List<ActivityModel> _defaultActivities = [
    ActivityModel(id: 'activity-1', name: 'Olahraga Pagi', counter: 3),
    ActivityModel(id: 'activity-2', name: 'Buku Dibaca', counter: 2),
    ActivityModel(id: 'activity-3', name: 'Tugas Selesai', counter: 5),
  ];

  final List<ActivityModel> _activities;

  List<ActivityModel> get activities =>
      List<ActivityModel>.unmodifiable(_activities);

  ActivityModel? findById(String id) {
    for (final activity in _activities) {
      if (activity.id == id) {
        return activity;
      }
    }
    return null;
  }

  void add(ActivityModel activity) {
    _activities.add(activity);
  }

  bool update(ActivityModel activity) {
    final index = _activities.indexWhere((item) => item.id == activity.id);
    if (index == -1) {
      return false;
    }
    _activities[index] = activity;
    return true;
  }

  bool remove(String id) {
    final previousLength = _activities.length;
    _activities.removeWhere((activity) => activity.id == id);
    return _activities.length != previousLength;
  }
}
