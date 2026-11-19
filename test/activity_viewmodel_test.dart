import 'package:activity_counter_mvvm/data/activity_data.dart';
import 'package:activity_counter_mvvm/models/activity_model.dart';
import 'package:activity_counter_mvvm/repositories/activity_repository.dart';
import 'package:activity_counter_mvvm/viewmodels/activity_viewmodel.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late ActivityViewModel viewModel;

  setUp(() {
    final dataSource = ActivityData(initialActivities: const []);
    final repository = ActivityRepository(dataSource: dataSource);
    viewModel = ActivityViewModel(repository: repository);
  });

  test('menambah aktivitas baru dengan counter awal 0', () {
    final added = viewModel.addActivity('Belajar Flutter');

    expect(added, isTrue);
    expect(viewModel.activities, hasLength(1));
    expect(viewModel.activities.first.name, 'Belajar Flutter');
    expect(viewModel.activities.first.counter, 0);
  });

  test('nama aktivitas kosong tidak dapat ditambahkan', () {
    final added = viewModel.addActivity('   ');

    expect(added, isFalse);
    expect(viewModel.activities, isEmpty);
  });

  test('counter bertambah, berkurang, dan tidak kurang dari 0', () {
    viewModel.addActivity('Olahraga');
    final id = viewModel.activities.first.id;

    expect(viewModel.incrementCounter(id), isTrue);
    expect(viewModel.findActivityById(id)?.counter, 1);
    expect(viewModel.decrementCounter(id), isTrue);
    expect(viewModel.findActivityById(id)?.counter, 0);
    expect(viewModel.decrementCounter(id), isFalse);
    expect(viewModel.findActivityById(id)?.counter, 0);
  });

  test('mengubah nama, reset counter, dan menghapus aktivitas', () {
    const item = ActivityModel(id: '1', name: 'Lama', counter: 4);
    final dataSource = ActivityData(initialActivities: const [item]);
    final repository = ActivityRepository(dataSource: dataSource);
    final model = ActivityViewModel(repository: repository);

    expect(model.updateActivityName('1', 'Nama Baru'), isTrue);
    expect(model.findActivityById('1')?.name, 'Nama Baru');
    expect(model.resetCounter('1'), isTrue);
    expect(model.findActivityById('1')?.counter, 0);
    expect(model.deleteActivity('1'), isTrue);
    expect(model.activities, isEmpty);
  });
}
