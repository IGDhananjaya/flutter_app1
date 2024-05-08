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

  static Future<ErrorMSG> savePetani(petani, filepath) async {
    try {
      print(petani);
      var url = Uri.parse('https://dev.wefgis.com/api/petani');

      var request = http.MultipartRequest('POST', url);
      request.fields['nama'] = petani.nama;
      request.fields['nik'] = petani.nik;
      request.fields['alamat'] = petani.alamat;
      request.fields['telp'] = petani.telp;
      request.fields['status'] = petani.status;
      request.fields['id_kelompok_tani'] = petani.idKelompokTani;
      if (filepath != '') {
        request.files.add(await http.MultipartFile.fromPath('foto', filepath));
      }
      request.headers.addAll({
        'Authorization': 'Bearer ' + _token,
      });
      var response = await request.send();

      if (response.statusCode == 200) {
        // return Petani.fromJson(jsonDecode(response.body));
        final respStr = await response.stream.bytesToString();
        print(jsonDecode(respStr));
        // print(respStr);

        // return Petani.fromJson(jsonDecode(response.body));
        return ErrorMSG.fromJson(jsonDecode(respStr));
        // return ErrorMSG.fromJson(jsonDecode(respStr));
      } else {
        //return ErrorMSG.fromJson(jsonDecode(response.body));
        // return ErrorMSG(success: false, message: 'err Request');

        throw Exception('Failed to update petani');
      }
    } catch (e) {
      // ErrorMSG responseRequest =
      //     ErrorMSG(success: false, message: 'error caught: $e');
      // return responseRequest;
      print(e);
      throw Exception('Error $e');
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
  static Future<ErrorMSG> updatePetani(Petani petani, {String? filepath}) async {
    try {
      var url = Uri.parse('https://dev.wefgis.com/api/petani/${petani.idPenjual}');

      var request = http.MultipartRequest('PUT', url);
      request.fields['nama'] = petani.nama!;
      request.fields['nik'] = petani.nik!;
      request.fields['alamat'] = petani.alamat!;
      request.fields['telp'] = petani.telp!;
      request.fields['status'] = petani.status!;
      request.fields['id_kelompok_tani'] = petani.idKelompokTani!;
      if (filepath!= null) {
        request.files.add(await http.MultipartFile.fromPath('foto', filepath));
      }
      request.headers.addAll({
        'Authorization': 'Bearer $_token',
      });
      var response = await request.send();

      if (response.statusCode == 200) {
        final respStr = await response.stream.bytesToString();
        return ErrorMSG.fromJson(jsonDecode(respStr));
      } else {
        throw Exception('Failed to update petani: ${response.statusCode}');
      }
    } catch (e) {
      print(e);
      throw Exception('Error updating petani: $e');
    }
  }


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
