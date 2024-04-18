// import 'dart:math';

// class PostPhoto {
//   int? id;
//   String photo_name;
//   String description;

//   PostPhoto({this.id, required this.photo_name, required this.description});

//     // PostPhoto({required this.photo_name, required this.description})
//     //   : id = Random().nextInt(1000000); 

//   // Konversi objek PostPhoto ke Map. Berguna untuk operasi INSERT dan UPDATE.
//   Map<String, dynamic> toMap() {
//     var map = <String, dynamic>{
//       'id' : id,
//       'photo_name': photo_name,
//       'desc': description,
//     };
//     // Tidak perlu menambahkan id jika null karena SQLite akan mengisinya secara otomatis untuk kolom PRIMARY KEY.
//     // if (id != null) {
//     //   map['id'] = id;
//     // }
//     return map;
//   }

//   // Membuat objek PostPhoto dari Map. Berguna untuk operasi SELECT.
//   PostPhoto.fromMap(Map<String, dynamic> map)
//       : id = map['id'],
//         photo_name = map['photo_name'],
//         description = map['desc'];

//   // @override
//   // String toString() {
//   //   return 'PostPhoto{id: $id, photoName: $photoName, description: $description}';
//   // }
// }

/////////////////////////////////

import 'dart:math';

class PostPhoto {
  int? id;
  String photo_name;
  String description;
  DateTime datetime;

  PostPhoto({this.id, required this.photo_name, required this.description, required this.datetime});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'photo_name': photo_name,
      'desc': description,
      'datetime': datetime.toIso8601String(),
    };
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }

  PostPhoto.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        photo_name = map['photo_name'],
        description = map['desc'],
        datetime = DateTime.parse(map['datetime']);
}