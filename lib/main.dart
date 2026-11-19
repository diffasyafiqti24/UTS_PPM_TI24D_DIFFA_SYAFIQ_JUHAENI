import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'data/activity_data.dart';
import 'repositories/activity_repository.dart';
import 'viewmodels/activity_viewmodel.dart';
import 'views/home_view.dart';

void main() {
  final dataSource = ActivityData();
  final repository = ActivityRepository(dataSource: dataSource);

  runApp(
    ChangeNotifierProvider(
      create: (_) => ActivityViewModel(repository: repository),
      child: const ActivityCounterApp(),
    ),
  );
}

class ActivityCounterApp extends StatelessWidget {
  const ActivityCounterApp({super.key});

  @override
  Widget build(BuildContext context) {
    const seedColor = Color(0xFF3157D5);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Aktivitasku',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: seedColor,
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: const Color(0xFFF6F7FB),
        appBarTheme: const AppBarTheme(
          centerTitle: false,
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          elevation: 0,
        ),
        cardTheme: CardThemeData(
          elevation: 0,
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Color(0xFFE4E7F0)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: seedColor, width: 1.5),
          ),
        ),
      ),
      home: const HomeView(),
    );
  }
}
