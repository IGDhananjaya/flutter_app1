import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tugas_ui/helpers/photo_helper.dart';
import 'package:tugas_ui/models/photo_post.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  // Inisialisasi database di memory untuk testing
  setUpAll(() async {
    databaseFactory = databaseFactoryFfi;
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'test.db');
    await deleteDatabase(path);
  });

  group('PhotoHelper Add Function', () {
    test('should add a photo post and return it with an id', () async {
      // Inisialisasi PhotoHelper
      final photoHelper = PhotoHelper();

      // Buat objek PostPhoto
      // Buat objek PostPhoto dengan menyediakan 3 argumen posisional yang dibutuhkan
      final postPhoto = PostPhoto(0, 'Test Photo', 'This is a test');

      // Simpan PostPhoto menggunakan fungsi add
      final result = await photoHelper.add(postPhoto);

      // Verifikasi bahwa foto berhasil disimpan dengan id yang tidak null
      expect(result.id, isNotNull);
    });
  });
}
