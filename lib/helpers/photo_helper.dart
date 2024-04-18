// // import 'package:flutter/foundation.dart';
// import 'package:sqflite/sqflite.dart';
// import 'dart:io' as io;
// import 'package:path/path.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:tugas_ui/models/photo_post.dart';

// class PhotoHelper {
//   static Database? _ph;
//   static const String ID = 'id';
//   static const String NAME = 'photo_name';
//   static const String DESC = 'desc';
//   static const String TABLE = 'postphoto';
//   static const String DB_NAME = 'photos.db';

//   PhotoHelper._privateConstructor();
//   static final PhotoHelper instance = PhotoHelper._privateConstructor();

//   Future<Database> get ph async {
//     if (_ph != null) return _ph!;
//     _ph = await _initDb();
//     return _ph!;
//   }

//   _initDb() async {
//     io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
//     String path = join(documentsDirectory.path, DB_NAME);
//     var ph = await openDatabase(path, version: 1, onCreate: _onCreate);
//     return ph;
//   }

//   Future _onCreate(Database db, int version) async {
//     await db.execute('''
//       CREATE TABLE $TABLE (
//         $ID INTEGER PRIMARY KEY,
//         $NAME TEXT,
//         $DESC TEXT
//       )
//     ''');
//   }

//   // Contoh fungsi untuk menambahkan data foto
//   Future<PostPhoto> addPhoto(PostPhoto photo) async {
//     var dbClient = await ph;
//     photo.id = await dbClient.insert(TABLE, photo.toMap());
//     return photo;
//   }

//   // Contoh fungsi untuk mengambil semua foto
//   Future<List<PostPhoto>> getPhotos() async {
//     var dbClient = await ph;
//     List<Map> maps = await dbClient.query(TABLE, columns: [ID, NAME, DESC]);
//     List<PostPhoto> photos = [];
//     if (maps.isNotEmpty) {
//       for (var map in maps) {
//         photos.add(PostPhoto.fromMap(map.cast<String, dynamic>()));
//       }
//     }
//     return photos;
//   }

//   Future<int> getPhotoCount() async {
//     final db = await ph;
//     final count = await db.rawQuery('SELECT COUNT(*) FROM $TABLE');
//     return Sqflite.firstIntValue(count) ?? 0;
//   }

//   Future<int> delete(int id) async {
//     var dbClient = await ph;
//     return await dbClient.delete(
//       TABLE,
//       where: '$ID = ?',
//       whereArgs: [id],
//     );
//   }

//   Future<void> update(PostPhoto photo) async {
//     final dbClient = await ph;
//     int rowsAffected = await dbClient.update(
//       TABLE,
//       photo.toMap(),
//       where: '$ID = ?',
//       whereArgs: [photo.id],
//     );

//     if (rowsAffected > 0) {
//       print("Update berhasil, $rowsAffected baris terpengaruh.");
//     } else {
//       print("Update gagal, tidak ada baris yang terpengaruh.");
//     }
//   }

//   Future<void> close() async {
//     var dbClient = await ph;
//     _ph = null;
//     await dbClient.close();
//   }
// }

///////////////////////////////////////////////////////////////

import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tugas_ui/models/photo_post.dart';

class PhotoHelper {
  static final PhotoHelper _instance = PhotoHelper._internal();
  static Database? _ph;

  factory PhotoHelper() => _instance;

  PhotoHelper._internal();

  Future<Database> get ph async {
    _ph ??= await initDatabase();
    return _ph!; // Use the already initialized _ph
  }

  initDatabase() async {
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, 'db_postphoto.db');
    var ph = await openDatabase(path, version: 1, onCreate: _onCreate);
    return ph;
  }

  // _onCreate(Database ph, int version) async {
  //   await ph.execute('CREATE TABLE postphoto (id INTEGER PRIMARY KEY, photo_name TEXT , desc TEXT)');
  // }

  _onCreate(Database ph, int version) async {
    await ph.execute(
        'CREATE TABLE postphoto (id INTEGER PRIMARY KEY, photo_name TEXT, desc TEXT, datetime DATETIME DEFAULT CURRENT_TIMESTAMP)');
  }

  // Future<PostPhoto> add(PostPhoto postphoto) async {
  //   var phClient = await ph;
  //   postphoto.id = await phClient.insert('postphoto', postphoto.toMap());
  //   return postphoto;
  // }

  Future<PostPhoto> add(PostPhoto postphoto) async {
    var phClient = await ph;
    postphoto.id = await phClient.insert('postphoto', postphoto.toMap());
    postphoto.datetime = DateTime.now();
    return postphoto;
  }

  Future<int> getPhotoCount() async {
    final db = await ph;
    final count = await db.rawQuery('SELECT COUNT(*) FROM postphoto');
    return Sqflite.firstIntValue(count) ?? 0;
  }

  // Future<List<PostPhoto>> getpostphoto() async {
  //   var phClient = await ph;
  //   List<Map<String, dynamic>> maps =
  //       await phClient.query('postphoto', orderBy: 'id DESC');
  //   List<PostPhoto> postphoto = [];
  //   if (maps.isNotEmpty) {
  //     for (int i = 0; i < maps.length; i++) {
  //       postphoto.add(PostPhoto.fromMap(maps[i]));
  //     }
  //   }
  //   return postphoto;
  // }

  Future<List<PostPhoto>> getpostphoto() async {
    var phClient = await ph;
    List<Map<String, dynamic>> maps =
        await phClient.query('postphoto', orderBy: 'datetime DESC');
    List<PostPhoto> postphoto = [];
    if (maps.isNotEmpty) {
      for (int i = 0; i < maps.length; i++) {
        postphoto.add(PostPhoto.fromMap(maps[i]));
      }
    }
    return postphoto;
  }

  Future<int> delete(int id) async {
    var phClient = await ph;
    return await phClient.delete(
      'postphoto',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> update(PostPhoto postphoto) async {
    var phClient = await ph;
    return await phClient.update(
      'postphoto',
      postphoto.toMap(),
      where: 'id = ?',
      whereArgs: [postphoto.id],
    );
  }

  Future<void> close() async {
    try {
      // Access database client
      var phClient = await ph;
      _ph = null;
      await phClient.close();
    } catch (error) {
      // Handle potential errors during closure
      debugPrint('Error closing database: $error');
    }
  }
}
