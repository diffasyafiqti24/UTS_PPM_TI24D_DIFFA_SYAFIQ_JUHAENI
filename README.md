# Aktivitasku - Activity Counter MVVM

Project UTS mata kuliah Pemrograman Mobile berupa aplikasi Activity Counter menggunakan Flutter, Dart, Provider, ChangeNotifier, dan arsitektur MVVM yang dilengkapi Data serta Repository.

## Identitas

- Nama: **DIFFA SYAFIQ JUHAENI**
- NIM: **20240040133**
- Kelas: **TI24D**

## Fitur

- Tiga halaman: Home, Tambah/Edit, dan Detail Aktivitas.
- Tambah dan edit aktivitas dengan validasi nama wajib diisi.
- Tambah dan kurangi counter dengan batas minimum 0.
- Reset counter menggunakan AlertDialog konfirmasi.
- Hapus aktivitas menggunakan dialog konfirmasi.
- SnackBar saat aktivitas ditambahkan/dihapus dan saat counter berubah.
- Tampilan otomatis diperbarui melalui ChangeNotifier.
- Data sementara disimpan dalam List tanpa database atau API.

## Struktur Folder Utama

```text
lib/
├── main.dart
├── models/
│   └── activity_model.dart
├── data/
│   └── activity_data.dart
├── repositories/
│   └── activity_repository.dart
├── viewmodels/
│   └── activity_viewmodel.dart
└── views/
    ├── home_view.dart
    ├── activity_form_view.dart
    └── activity_detail_view.dart
```
