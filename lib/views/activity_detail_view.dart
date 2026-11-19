import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/activity_model.dart';
import '../viewmodels/activity_viewmodel.dart';
import 'activity_form_view.dart';

class ActivityDetailView extends StatelessWidget {
  const ActivityDetailView({
    super.key,
    required this.activityId,
  });

  final String activityId;

  void _showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> _editActivity(
    BuildContext context,
    ActivityModel activity,
  ) async {
    final saved = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (_) => ActivityFormView(
          activityId: activity.id,
          initialName: activity.name,
        ),
      ),
    );

    if (saved == true && context.mounted) {
      _showMessage(context, 'Nama aktivitas berhasil diperbarui.');
    }
  }

  void _increment(BuildContext context) {
    final viewModel = context.read<ActivityViewModel>();
    if (viewModel.incrementCounter(activityId)) {
      final updated = viewModel.findActivityById(activityId);
      _showMessage(
        context,
        'Counter bertambah menjadi ${updated?.counter ?? 0}.',
      );
    }
  }

  void _decrement(BuildContext context) {
    final viewModel = context.read<ActivityViewModel>();
    if (viewModel.decrementCounter(activityId)) {
      final updated = viewModel.findActivityById(activityId);
      _showMessage(
        context,
        'Counter berkurang menjadi ${updated?.counter ?? 0}.',
      );
    } else {
      _showMessage(context, 'Counter tidak boleh kurang dari 0.');
    }
  }

  Future<void> _confirmReset(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Reset counter?'),
          content: const Text(
            'Nilai aktivitas akan dikembalikan menjadi 0.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext, false),
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(dialogContext, true),
              child: const Text('Reset'),
            ),
          ],
        );
      },
    );

    if (confirmed != true || !context.mounted) {
      return;
    }

    final reset = context.read<ActivityViewModel>().resetCounter(activityId);
    _showMessage(
      context,
      reset ? 'Counter berhasil di-reset menjadi 0.' : 'Counter sudah bernilai 0.',
    );
  }

  Future<void> _confirmDelete(
    BuildContext context,
    ActivityModel activity,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Hapus aktivitas?'),
          content: Text(
            'Aktivitas "${activity.name}" akan dihapus dari daftar.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext, false),
              child: const Text('Batal'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.error,
                foregroundColor: Theme.of(context).colorScheme.onError,
              ),
              onPressed: () => Navigator.pop(dialogContext, true),
              child: const Text('Hapus'),
            ),
          ],
        );
      },
    );

    if (confirmed != true || !context.mounted) {
      return;
    }

    final deleted = context
        .read<ActivityViewModel>()
        .deleteActivity(activity.id);
    if (deleted && context.mounted) {
      Navigator.pop(context, activity.name);
    }
  }

  @override
  Widget build(BuildContext context) {
    final activity = context
        .watch<ActivityViewModel>()
        .findActivityById(activityId);

    if (activity == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Detail Aktivitas')),
        body: const Center(child: Text('Aktivitas tidak ditemukan.')),
      );
    }

    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Aktivitas'),
        actions: [
          IconButton(
            tooltip: 'Edit aktivitas',
            onPressed: () => _editActivity(context, activity),
            icon: const Icon(Icons.edit_outlined),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: colors.primary,
                borderRadius: BorderRadius.circular(28),
              ),
              child: Column(
                children: [
                  Container(
                    width: 58,
                    height: 58,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.16),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: const Icon(
                      Icons.checklist_rounded,
                      color: Colors.white,
                      size: 32,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    activity.name,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 23,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Nilai counter saat ini',
                    style: TextStyle(color: Colors.white70),
                  ),
                  Text(
                    '${activity.counter}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 64,
                      height: 1.1,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  children: [
                    const Text(
                      'Ubah Nilai Counter',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 18),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _CounterButton(
                          tooltip: 'Kurangi counter',
                          icon: Icons.remove_rounded,
                          onPressed: () => _decrement(context),
                        ),
                        Container(
                          width: 100,
                          alignment: Alignment.center,
                          child: Text(
                            '${activity.counter}',
                            style: const TextStyle(
                              fontSize: 34,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                        _CounterButton(
                          tooltip: 'Tambah counter',
                          icon: Icons.add_rounded,
                          onPressed: () => _increment(context),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 50,
              child: OutlinedButton.icon(
                onPressed: () => _confirmReset(context),
                icon: const Icon(Icons.restart_alt_rounded),
                label: const Text('Reset Counter'),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 50,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: colors.errorContainer,
                  foregroundColor: colors.onErrorContainer,
                ),
                onPressed: () => _confirmDelete(context, activity),
                icon: const Icon(Icons.delete_outline_rounded),
                label: const Text('Hapus Aktivitas'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CounterButton extends StatelessWidget {
  const _CounterButton({
    required this.tooltip,
    required this.icon,
    required this.onPressed,
  });

  final String tooltip;
  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton.filled(
      tooltip: tooltip,
      onPressed: onPressed,
      icon: Icon(icon),
      iconSize: 30,
      padding: const EdgeInsets.all(14),
    );
  }
}
