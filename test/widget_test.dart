import 'package:activity_counter_mvvm/data/activity_data.dart';
import 'package:activity_counter_mvvm/main.dart';
import 'package:activity_counter_mvvm/repositories/activity_repository.dart';
import 'package:activity_counter_mvvm/viewmodels/activity_viewmodel.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets('Home menampilkan judul dan daftar aktivitas', (tester) async {
    final repository = ActivityRepository(dataSource: ActivityData());

    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => ActivityViewModel(repository: repository),
        child: const ActivityCounterApp(),
      ),
    );

    expect(find.text('Aktivitasku'), findsOneWidget);
    expect(find.text('Daftar Aktivitas'), findsOneWidget);
    expect(find.text('Olahraga Pagi'), findsOneWidget);
  });
}
