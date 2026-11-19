import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewmodels/activity_viewmodel.dart';

class ActivityFormView extends StatefulWidget {
  const ActivityFormView({
    super.key,
    this.activityId,
    this.initialName,
  });

  final String? activityId;
  final String? initialName;

  bool get isEditing => activityId != null;

  @override
  State<ActivityFormView> createState() => _ActivityFormViewState();
}

class _ActivityFormViewState extends State<ActivityFormView> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.initialName ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _save() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final viewModel = context.read<ActivityViewModel>();
    final success = widget.isEditing
        ? viewModel.updateActivityName(
            widget.activityId!,
            _nameController.text,
          )
        : viewModel.addActivity(_nameController.text);

    if (!success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Aktivitas gagal disimpan.')),
      );
      return;
    }

    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isEditing ? 'Edit Aktivitas' : 'Tambah Aktivitas'),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Icon(
                    widget.isEditing
                        ? Icons.edit_note_rounded
                        : Icons.add_task_rounded,
                    size: 34,
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Text(
                      widget.isEditing
                          ? 'Perbarui nama aktivitas agar mudah dikenali.'
                          : 'Buat aktivitas baru dan mulai hitung progresnya.',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),
            Form(
              key: _formKey,
              child: TextFormField(
                controller: _nameController,
                autofocus: true,
                textInputAction: TextInputAction.done,
                onFieldSubmitted: (_) => _save(),
                decoration: const InputDecoration(
                  labelText: 'Nama aktivitas',
                  hintText: 'Contoh: Olahraga Pagi',
                  prefixIcon: Icon(Icons.check_circle_outline_rounded),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Nama aktivitas wajib diisi.';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 52,
              child: ElevatedButton.icon(
                onPressed: _save,
                icon: const Icon(Icons.save_outlined),
                label: const Text('Simpan'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
