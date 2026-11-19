class ActivityModel {
  const ActivityModel({
    required this.id,
    required this.name,
    required this.counter,
  });

  final String id;
  final String name;
  final int counter;

  ActivityModel copyWith({
    String? id,
    String? name,
    int? counter,
  }) {
    return ActivityModel(
      id: id ?? this.id,
      name: name ?? this.name,
      counter: counter ?? this.counter,
    );
  }
}
