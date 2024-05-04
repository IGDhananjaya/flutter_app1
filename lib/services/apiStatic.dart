import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tugas_ui/models/errorMSG.dart';
import 'package:tugas_ui/models/kelompokTani.dart';
import 'package:tugas_ui/models/petani.dart';

class ApiStatic {
  //static final host='http://192.168.43.189/webtani/public';
  static final host = 'https://dev.wefgis.com';
  static var _token = "8|x6bKsHp9STb0uLJsM11GkWhZEYRWPbv0IqlXvFi7";
  Future<SharedPreferences> preferences = SharedPreferences.getInstance();
  static Future<void> getPref() async {
    Future<SharedPreferences> preferences = SharedPreferences.getInstance();
    final SharedPreferences prefs = await preferences;
    _token = prefs.getString('token') ?? "";
  }

  static getHost() {
    return host;
  }
  
  // static Future<List<Petani>> getPetani() async{
  //   List<Petani> petani=[];
  //   for (var i = 0; i < 10; i++) {
  //       petani.add(
  //         Petani(
  //           idPenjual: i, nama: "Nama Petani"+i.toString(), nik: "123"+i.toString(),alamat: "Alamat", telp: "0362",foto: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSrynWADIdRZwu5T-vrTuGR0a7Rk7zJ4yxP9LiRJB88TFdVFIxaIa_qtc1EzZrBQWcDPkg&usqp=CAU",idKelompokTani: 1,status: "Y",namaKelompok: "Jaya Mula",
  //         )
  //       );
  //   }
  //   return petani;
  // }

  // static Future<List<Petani>> getPetani() async {
  //   //String response='{"current_page":1,"data":[{"id_penjual":1,"nama":"Sugi Tumang","nik":"39949","alamat":"Srikandi","telp":"0882788","foto":"petanis\/farmer_10763.png","id_kelompok_tani":1,"status":"Y","created_at":null,"updated_at":null,"nama_kelompok":"Suda Merta"},{"id_penjual":2,"nama":"Jaya Suda","nik":"38839","alamat":"Bekisar","telp":"099383","foto":"petanis\/images.jpg","id_kelompok_tani":1,"status":"Y","created_at":null,"updated_at":null,"nama_kelompok":"Suda Merta"}],"first_page_url":"http:\/\/192.168.43.189\/belajarapi\/public\/api\/petani?page=1","from":1,"last_page":1,"last_page_url":"http:\/\/192.168.43.189\/belajarapi\/public\/api\/petani?page=1","links":[{"url":null,"label":"&laquo; Previous","active":false},{"url":"http:\/\/192.168.43.189\/belajarapi\/public\/api\/petani?page=1","label":"1","active":true},{"url":null,"label":"Next &raquo;","active":false}],"next_page_url":null,"path":"http:\/\/192.168.43.189\/belajarapi\/public\/api\/petani","per_page":10,"prev_page_url":null,"to":2,"total":2}';
  //   try {
  //     getPref();
  //     final response =
  //         await http.get(Uri.parse("$host/api/petani?s="), headers: {
  //       'Authorization': 'Bearer ' + _token,
  //     });
  //     // print('ss1');
  //     if (response.statusCode == 200) {
  //       //print('ss2');
  //       var json = jsonDecode(response.body);
  //       // print(json);
  //       final parsed=json['data'].cast<Map<String, dynamic>>();
  //       // final parsed = json['data'] as List<dynamic>;
  //       // final mapped = parsed.map((e) => e as Map<String, dynamic>);
  //       // print(parsed);
  //       // print(Map);
  //       return parsed.map<Petani>((json) => Petani.fromJson(json)).toList();
  //     } else {
  //       return [];
  //     }
  //   } catch (e) {
  //     return [];
  //   }
  // }

  Future<List<Petani>> fetchPetani() async {
    http.Response response;
    try {
      response =
          await http.get(Uri.parse('https://dev.wefgis.com/api/petani?s'));

      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        final data = json['data'];

        if (data is List) {
          return data.map((petaniJson) => Petani.fromJson(petaniJson)).toList();
        } else {
          throw Exception('Data is not in the expected format');
        }
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      // Tangani kesalahan jika terjadi
      return []; // Return an empty list if there's an error
    }
  }

  // static Future<List<Petani>> getPetani() async {
  //   try {
  //     final response = await http.get(
  //       Uri.parse('https://dev.wefgis.com/api/petani?s'),
  //       headers: {
  //         'Authorization': 'Bearer $_token', // Adding the token to the headers
  //       },
  //     );

  //     if (response.statusCode == 200) {
  //       // If the server returns a 200 OK response,
  //       // then parse the JSON.
  //       var json = jsonDecode(response.body);
  //       final data = json['data'];

  //       // Check if data is a list and is not empty
  //       if (data is List && data.isNotEmpty) {
  //         // Convert each element of the list to Petani object
  //         return data
  //             .map((e) => Petani.fromJson(e as Map<String, dynamic>))
  //             .toList();
  //       } else {
  //         throw Exception('Data is empty or not in the expected format');
  //       }
  //     } else {
  //       // If the server does not return a 200 OK response,
  //       // throw an exception.
  //       throw Exception('Failed to load data');
  //     }
  //   } catch (e) {
  //     // Catching any exceptions that might occur during the execution
  //     throw Exception('Error: $e');
  //   }
  // }

  static Future<List<Petani>> getPetaniFilter(
      int pageKey, String _s, String _selectedChoice) async {
    try {
      getPref();
      final response = await http.get(
          Uri.parse("$host/api/petani?page=" +
              pageKey.toString() +
              "&s=" +
              _s +
              "&publish=" +
              _selectedChoice),
          headers: {
            'Authorization': 'Bearer ' + _token,
          });
      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        //print(json);
        final parsed = json['data'].cast<Map<String, dynamic>>();
        return parsed.map<Petani>((json) => Petani.fromJson(json)).toList();
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }

  // static Future<List<Kelompok>> getKelompokTani() async {
  //   try {
  //     final response =
  //         await http.get(Uri.parse("$host/api/kelompoktani"), headers: {
  //       'Authorization': 'Bearer ' + _token,
  //     });
  //     if (response.statusCode == 200) {
  //       var json = jsonDecode(response.body);
  //       final parsed = json.cast<Map<String, dynamic>>();
  //       return parsed.map<Kelompok>((json) => Kelompok.fromJson(json)).toList();
  //     } else {
  //       return [];
  //     }
  //   } catch (e) {
  //     return [];
  //   }
  // }

  // static Future<ErrorMSG> savePetani(id, petani, filepath) async {
  //   try {
  //     var url = Uri.parse('$host/api/petani');
  //     if (id != 0) {
  //       url = Uri.parse('$host/api/petani/' + id.toString());
  //     }
  //     var request = http.MultipartRequest('POST', url);
  //     request.fields['nama'] = petani['nama'];
  //     request.fields['nik'] = petani['nik'];
  //     request.fields['alamat'] = petani['alamat'];
  //     request.fields['telp'] = petani['telp'];
  //     request.fields['status'] = petani['status'];
  //     request.fields['id_kelompok_tani'] =
  //         petani['id_kelompok_tani'].toString();
  //     if (filepath != '') {
  //       request.files.add(await http.MultipartFile.fromPath('foto', filepath));
  //     }
  //     request.headers.addAll({
  //       'Authorization': 'Bearer ' + _token,
  //     });
  //     var response = await request.send();
  //     //final response = await http.post(Uri.parse('$_host/panen'), body:_panen);
  //     if (response.statusCode == 200) {
  //       //return ErrorMSG.fromJson(jsonDecode(response.body));
  //       final respStr = await response.stream.bytesToString();
  //       //print(jsonDecode(respStr));
  //       return ErrorMSG.fromJson(jsonDecode(respStr));
  //     } else {
  //       //return ErrorMSG.fromJson(jsonDecode(response.body));
  //       return ErrorMSG(success: false, message: 'err Request');
  //     }
  //   } catch (e) {
  //     ErrorMSG responseRequest =
  //         ErrorMSG(success: false, message: 'error caught: $e');
  //     return responseRequest;
  //   }
  // }

  Future<Petani> createPetani(Petani petani) async {
    final response = await http.post(
      Uri.parse('https://dev.wefgis.com/api/petani'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'id_kelompok_tani': petani.idKelompokTani,
        'nama': petani.nama,
        'nik': petani.nik,
        'alamat': petani.alamat,
        'telp': petani.telp,
        'foto': petani.foto,
        'status': petani.status,
        'nama_kelompok': petani.namaKelompok,
      }),
    );

    if (response.statusCode == 201) {
      return Petani.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create petani');
    }
  }

  // Fetch all kelompok tani
  Future<List<Kelompok>> getKelompokTani() async {
    try {
      final response =
          await http.get(Uri.parse("$host/api/kelompoktani"), headers: {
        'Authorization': 'Bearer ' + _token,
      });
      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        final parsed = json.cast<Map<String, dynamic>>();
        return parsed.map<Kelompok>((json) => Kelompok.fromJson(json)).toList();
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }

  // Update an existing petani
  Future<Petani> updatePetani(Petani petani) async {
    final response = await http.put(
      Uri.parse('https://dev.wefgis.com/api/petani/${petani.idPenjual}'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'id_kelompok_tani': petani.idKelompokTani,
        'nama': petani.nama,
        'nik': petani.nik,
        'alamat': petani.alamat,
        'telp': petani.telp,
        'foto': petani.foto,
        'status': petani.status,
        'nama_kelompok': petani.namaKelompok,
      }),
    );

    if (response.statusCode == 200) {
      return Petani.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to update petani');
    }
  }

  // static Future<ErrorMSG> savePetani(
  //     int id, Petani petani, String filePath) async {
  //   try {
  //     var url = Uri.parse('$host/api/petani');
  //     if (id != 0) {
  //       url = Uri.parse('$host/api/petani/$id');
  //     }

  //     var request = http.MultipartRequest(id != 0 ? 'PUT' : 'POST', url);
  //     request.fields['nama'] = petani.nama!;
  //     request.fields['nik'] = petani.nik!;
  //     request.fields['alamat'] = petani.alamat!;
  //     request.fields['telp'] = petani.telp!;
  //     request.fields['status'] = petani.status!;
  //     request.fields['id_kelompok_tani'] =
  //         petani.idKelompokTani?.toString() ?? '';

  //     if (filePath.isNotEmpty) {
  //       request.files.add(await http.MultipartFile.fromPath('foto', filePath));
  //     }

  //     request.headers.addAll({
  //       'Authorization': 'Bearer $_token',
  //     });

  //     var response = await request.send();

  //     if (response.statusCode == 200) {
  //       final respStr = await response.stream.bytesToString();
  //       return ErrorMSG.fromJson(jsonDecode(respStr));
  //     } else {
  //       return ErrorMSG(
  //           success: false, message: 'Error: ${response.statusCode}');
  //     }
  //   } catch (e) {
  //     return ErrorMSG(success: false, message: 'Error caught: $e');
  //   }
  // }

  static Future<ErrorMSG> deletePetani(id) async {
    try {
      final response = await http
          .delete(Uri.parse('$host/api/petani/' + id.toString()), headers: {
        'Authorization': 'Bearer ' + _token,
      });
      if (response.statusCode == 200) {
        return ErrorMSG.fromJson(jsonDecode(response.body));
      } else {
        return ErrorMSG(
            success: false, message: 'Err, periksan kembali inputan anda');
      }
    } catch (e) {
      ErrorMSG responseRequest =
          ErrorMSG(success: false, message: 'error caught: $e');
      return responseRequest;
    }
  }

  static Future<ErrorMSG> sigIn(_post) async {
    try {
      final response =
          await http.post(Uri.parse('$host/api/login'), body: _post);
      if (response.statusCode == 200) {
        var res = jsonDecode(response.body);
        //print(res);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        // var idppl=res['data']['id_ppl']==null?'':res['data']['id_ppl'] ;
        // var idp=res['data']['id_penjual']==null?'':res['data']['id_penjual'];
        prefs.setString('token', res['token']);
        prefs.setString('name', res['user']['name']);
        prefs.setString('email', res['user']['email']);
        prefs.setInt('level', 1);
        return ErrorMSG.fromJson(res);
      } else {
        return ErrorMSG.fromJson(jsonDecode(response.body));
      }
    } catch (e) {
      ErrorMSG responseRequest =
          ErrorMSG(success: false, message: 'error caught: $e');
      return responseRequest;
    }
  }
}
