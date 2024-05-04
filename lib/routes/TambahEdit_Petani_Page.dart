import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tugas_ui/models/kelompokTani.dart';
import 'package:tugas_ui/models/petani.dart';
import 'package:tugas_ui/routes/list_petani_page.dart';
import 'package:tugas_ui/services/apiStatic.dart';

class TambahEditPetaniPage extends StatefulWidget {
  final Petani? petani;

  const TambahEditPetaniPage({Key? key, this.petani}) : super(key: key);

  @override
  State<TambahEditPetaniPage> createState() => _TambahEditPetaniPageState();
}

class _TambahEditPetaniPageState extends State<TambahEditPetaniPage> {
  late Future<List<Petani>> futurePetani;
  final ApiStatic apiService = ApiStatic();
  late String idKelompok;
  late String _selectedStatus = 'Aktif'; // Menambahkan variabel untuk menyimpan status yang dipilih

  // Tambahkan variabel untuk menyimpan daftar kelompok tani
  List<Kelompok> kelompokList = [];

  // Tambahkan variabel untuk menyimpan nilai kelompok tani yang dipilih
  Kelompok? selectedKelompok;

  // Controller untuk mengelola nilai input
  TextEditingController _namaController = TextEditingController();
  TextEditingController _nikController = TextEditingController();
  TextEditingController _alamatController = TextEditingController();
  TextEditingController _teleponController = TextEditingController();
  TextEditingController _fotoController = TextEditingController();

  // Method untuk mengambil daftar kelompok tani dari server
  void _fetchKelompokTani() async {
    ApiStatic apiStatic = ApiStatic();
    try {
      List<Kelompok> kelompok = await apiStatic.getKelompokTani();
      setState(() {
        kelompokList = kelompok;
        if (widget.petani != null) {
          // Jika ada data petani, set nilai idKelompok sesuai dengan data petani
          idKelompok = widget.petani!.idKelompokTani!;
          // Set nilai selectedKelompok sesuai dengan data petani
          selectedKelompok = kelompok.firstWhere(
            (kelompok) =>
                // ignore: unrelated_type_equality_checks
                kelompok.idKelompokTani == widget.petani!.idKelompokTani,
            orElse: () => kelompokList[
                0], // Jika tidak ditemukan, pilih elemen pertama dari kelompokList
          );
        }
      });
    } catch (e) {
      // Tangani kesalahan jika terjadi
      print('Error fetching kelompok tani: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    // Panggil method untuk mengambil daftar kelompok tani
    _fetchKelompokTani();
    futurePetani = apiService.fetchPetani();

    // Inisialisasi nilai input jika sedang dalam mode edit
    if (widget.petani != null) {
      _namaController.text = widget.petani!.nama ?? '';
      _nikController.text = widget.petani!.nik ?? '';
      _alamatController.text = widget.petani!.alamat ?? '';
      _teleponController.text = widget.petani!.telp ?? '';
      _fotoController.text = widget.petani!.foto ?? '';
      idKelompok = widget.petani!.idKelompokTani!.toString();
      _selectedStatus = widget.petani!.status ?? 'Aktif'; // Mengatur status yang dipilih
    }
  }

  // Method untuk memilih gambar dari galeri
  Future<void> _pickImageFromGallery() async {
    final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        // Ubah nilai fotoController sesuai dengan gambar yang dipilih dari galeri
        _fotoController.text = pickedImage.path!;
      });
    }
  }

  // Method untuk mengambil gambar melalui kamera
  Future<void> _pickImageFromCamera() async {
    final pickedImage = await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedImage != null) {
      setState(() {
        // Ubah nilai fotoController sesuai dengan gambar yang diambil dari kamera
        _fotoController.text = pickedImage.path!;
      });
    }
  }

  // Method untuk menyimpan data petani
  void _saveData(Petani? petani, BuildContext context) async {
    try {
      if (petani == null) {
        await ApiStatic().createPetani(Petani(
          idKelompokTani: idKelompok,
          nama: _namaController.text,
          nik: _nikController.text,
          alamat: _alamatController.text,
          telp: _teleponController.text,
          foto: _fotoController.text,
          status: _selectedStatus, // Menggunakan nilai _selectedStatus
        ));
        Fluttertoast.showToast(
          msg: 'Data berhasil ditambahkan',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.green,
          textColor: Colors.white,
        );
      } else {
        await ApiStatic().updatePetani(Petani(
          idPenjual: petani.idPenjual,
          idKelompokTani: idKelompok,
          nama: _namaController.text,
          nik: _nikController.text,
          alamat: _alamatController.text,
          telp: _teleponController.text,
          foto: _fotoController.text,
          status: _selectedStatus, // Menggunakan nilai _selectedStatus
        ));
        Fluttertoast.showToast(
          msg: 'Data berhasil diperbarui',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.green,
          textColor: Colors.white,
        );
      }

      // Kembali ke halaman utama
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => DatasScreen(futurePetani: futurePetani),
        ),
      );
    } catch (e) {
      Fluttertoast.showToast(
        msg: 'Error: $e',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    String pageTitle = widget.petani == null ? 'Tambah Petani' : 'Edit Petani';

    return Scaffold(
      appBar: AppBar(
        title: Text(pageTitle),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 250,
                width: double.infinity,
                decoration: _fotoController.text.isEmpty
                    ? BoxDecoration(color: Colors.grey[200])
                    : BoxDecoration(
                        image: DecorationImage(
                          image: FileImage(File(_fotoController.text)),
                          fit: BoxFit.cover,
                        ),
                      ),
                child: Align(
                  alignment: Alignment.topRight,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.camera_alt),
                        onPressed: _pickImageFromCamera,
                      ),
                      IconButton(
                        icon: Icon(Icons.photo_library),
                        onPressed: _pickImageFromGallery,
                      ),
                    ],
                  ),
                ),
              ),
              TextFormField(
                controller: _namaController,
                decoration: const InputDecoration(labelText: 'Nama'),
              ),
              TextFormField(
                controller: _nikController,
                decoration: const InputDecoration(labelText: 'NIK'),
              ),
              TextFormField(
                controller: _alamatController,
                decoration: const InputDecoration(labelText: 'Alamat'),
              ),
              TextFormField(
                controller: _teleponController,
                decoration: const InputDecoration(labelText: 'Telepon'),
              ),
              Row(
                children: [
                  Text('Status: '),
                  Row(
                    children: [
                      Radio<String>(
                        value: 'Aktif',
                        groupValue: _selectedStatus,
                        onChanged: (value) {
                          setState(() {
                            _selectedStatus = value!;
                          });
                        },
                      ),
                      Text('Aktif'),
                      Radio<String>(
                        value: 'Nonaktif',
                        groupValue: _selectedStatus,
                        onChanged: (value) {
                          setState(() {
                            _selectedStatus = value!;
                          });
                        },
                      ),
                      Text('Nonaktif'),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(5),
                child: DropdownButtonFormField<Kelompok>(
                  value: selectedKelompok,
                  hint: const Text("Pilih Kelompok"),
                  decoration: const InputDecoration(
                    icon: Icon(Icons.category_rounded),
                  ),
                  items: kelompokList.map((item) {
                    return DropdownMenuItem<Kelompok>(
                      value: item,
                      child: Text("${item.namaKelompok}"),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedKelompok = value!;
                      idKelompok = value.idKelompokTani.toString();
                    });
                  },
                  validator: (value) => value == null ? "Wajib Diisi" : null,
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (widget.petani == null) {
            _saveData(null, context);
          } else {
            _saveData(widget.petani, context);
          }
        },
        child: const Icon(Icons.save),
      ),
    );
  }
}

// import 'dart:convert';
// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:tugas_ui/models/kelompokTani.dart';
// import 'package:tugas_ui/models/petani.dart';
// import 'package:tugas_ui/routes/list_petani_page.dart';
// import 'package:tugas_ui/services/apiStatic.dart';

// class TambahEditPetaniPage extends StatefulWidget {
//   final Petani? petani;

//   const TambahEditPetaniPage({Key? key, this.petani}) : super(key: key);

//   @override
//   State<TambahEditPetaniPage> createState() => _TambahEditPetaniPageState();
// }

// class _TambahEditPetaniPageState extends State<TambahEditPetaniPage> {
//   late Future<List<Petani>> futurePetani;
//   final ApiStatic apiService = ApiStatic();
//   late String idKelompok;
//   late String _selectedStatus = 'Aktif';

//   // Tambahkan variabel controller untuk input foto
//   TextEditingController _fotoController = TextEditingController();

//   // Tambahkan variabel untuk menyimpan daftar kelompok tani
//   List<Kelompok> kelompokList = [];

//   // Tambahkan variabel untuk menyimpan nilai kelompok tani yang dipilih
//   Kelompok? selectedKelompok;

//   // Controller untuk mengelola nilai input
//   TextEditingController _namaController = TextEditingController();
//   TextEditingController _nikController = TextEditingController();
//   TextEditingController _alamatController = TextEditingController();
//   TextEditingController _teleponController = TextEditingController();

//   // Method untuk mengambil daftar kelompok tani dari server
//   void _fetchKelompokTani() async {
//     ApiStatic apiStatic = ApiStatic();
//     try {
//       List<Kelompok> kelompok = await apiStatic.getKelompokTani();
//       setState(() {
//         kelompokList = kelompok;
//         if (widget.petani != null) {
//           idKelompok = widget.petani!.idKelompokTani.toString();
//           selectedKelompok = kelompok.firstWhere(
//             (kelompok) => kelompok.idKelompokTani == widget.petani!.idKelompokTani,
//             orElse: () => kelompokList[0],
//           );
//         }
//       });
//     } catch (e) {
//       print('Error fetching kelompok tani: $e');
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     _fetchKelompokTani();
//     futurePetani = apiService.fetchPetani();

//     if (widget.petani != null) {
//       _namaController.text = widget.petani!.nama;
//       _nikController.text = widget.petani!.nik;
//       _alamatController.text = widget.petani!.alamat;
//       _teleponController.text = widget.petani!.telp;
//       _fotoController.text = widget.petani!.foto;
//       idKelompok = widget.petani!.idKelompokTani.toString();
//       _selectedStatus = widget.petani!.status;
//     }
//   }

//   Future<void> _pickImageFromGallery() async {
//     final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
//     if (pickedImage != null) {
//       setState(() {
//         _fotoController.text = pickedImage.path!;
//       });
//     }
//   }

//   Future<void> _pickImageFromCamera() async {
//     final pickedImage = await ImagePicker().pickImage(source: ImageSource.camera);
//     if (pickedImage != null) {
//       setState(() {
//         _fotoController.text = pickedImage.path!;
//       });
//     }
//   }

//   void _saveData(Petani? petani, BuildContext context) async {
//     try {
//       if (petani == null) {
//         await ApiStatic().createPetani(Petani(
//           idPenjual: 0, // Atur nilai idPenjual sesuai kebutuhan
//           nama: _namaController.text,
//           nik: _nikController.text,
//           alamat: _alamatController.text,
//           telp: _teleponController.text,
//           foto: _fotoController.text,
//           idKelompokTani: int.parse(idKelompok),
//           status: _selectedStatus,
//           namaKelompok: selectedKelompok!.namaKelompok,
//           createdAt: '', // Atur nilai createdAt sesuai kebutuhan
//           updatedAt: '', // Atur nilai updatedAt sesuai kebutuhan
//         ));
//         Fluttertoast.showToast(
//           msg: 'Data berhasil ditambahkan',
//           toastLength: Toast.LENGTH_SHORT,
//           gravity: ToastGravity.BOTTOM,
//           backgroundColor: Colors.green,
//           textColor: Colors.white,
//         );
//       } else {
//         await ApiStatic().updatePetani(Petani(
//           idPenjual: petani.idPenjual,
//           nama: _namaController.text,
//           nik: _nikController.text,
//           alamat: _alamatController.text,
//           telp: _teleponController.text,
//           foto: _fotoController.text,
//           idKelompokTani: int.parse(idKelompok),
//           status: _selectedStatus,
//           namaKelompok: selectedKelompok!.namaKelompok,
//           createdAt: petani.createdAt,
//           updatedAt: petani.updatedAt,
//         ));
//         Fluttertoast.showToast(
//           msg: 'Data berhasil diperbarui',
//           toastLength: Toast.LENGTH_SHORT,
//           gravity: ToastGravity.BOTTOM,
//           backgroundColor: Colors.green,
//           textColor: Colors.white,
//         );
//       }

//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(
//           builder: (context) => DatasScreen(futurePetani: futurePetani),
//         ),
//       );
//     } catch (e) {
//       Fluttertoast.showToast(
//         msg: 'Error: $e',
//         toastLength: Toast.LENGTH_LONG,
//         gravity: ToastGravity.BOTTOM,
//         backgroundColor: Colors.red,
//         textColor: Colors.white,
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     String pageTitle = widget.petani == null ? 'Tambah Petani' : 'Edit Petani';

//     return Scaffold(
//       appBar: AppBar(
//         title: Text(pageTitle),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Container(
//                 height: 250,
//                 width: double.infinity,
//                 decoration: _fotoController.text.isEmpty
//                     ? BoxDecoration(color: Colors.grey[200])
//                     : BoxDecoration(
//                         image: DecorationImage(
//                           image: FileImage(File(_fotoController.text)),
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                 child: Align(
//                   alignment: Alignment.topRight,
//                   child: Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       IconButton(
//                         icon: Icon(Icons.camera_alt),
//                         onPressed: _pickImageFromCamera,
//                       ),
//                       IconButton(
//                         icon: Icon(Icons.photo_library),
//                         onPressed: _pickImageFromGallery,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               TextFormField(
//                 controller: _namaController,
//                 decoration: const InputDecoration(labelText: 'Nama'),
//               ),
//               TextFormField(
//                 controller: _nikController,
//                 decoration: const InputDecoration(labelText: 'NIK'),
//               ),
//               TextFormField(
//                 controller: _alamatController,
//                 decoration: const InputDecoration(labelText: 'Alamat'),
//               ),
//               TextFormField(
//                 controller: _teleponController,
//                 decoration: const InputDecoration(labelText: 'Telepon'),
//               ),
//               Row(
//                 children: [
//                   Text('Status: '),
//                   Row(
//                     children: [
//                       Radio<String>(
//                         value: 'Aktif',
//                         groupValue: _selectedStatus,
//                         onChanged: (value) {
//                           setState(() {
//                             _selectedStatus = value!;
//                           });
//                         },
//                       ),
//                       Text('Aktif'),
//                       Radio<String>(
//                         value: 'Nonaktif',
//                         groupValue: _selectedStatus,
//                         onChanged: (value) {
//                           setState(() {
//                             _selectedStatus = value!;
//                           });
//                         },
//                       ),
//                       Text('Nonaktif'),
//                     ],
//                   ),
//                 ],
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(5),
//                 child: DropdownButtonFormField<Kelompok>(
//                   value: selectedKelompok,
//                   hint: const Text("Pilih Kelompok"),
//                   decoration: const InputDecoration(
//                     icon: Icon(Icons.category_rounded),
//                   ),
//                   items: kelompokList.map((item) {
//                     return DropdownMenuItem<Kelompok>(
//                       value: item,
//                       child: Text("${item.namaKelompok}"),
//                     );
//                   }).toList(),
//                   onChanged: (value) {
//                     setState(() {
//                       selectedKelompok = value!;
//                       idKelompok = value.idKelompokTani.toString();
//                     });
//                   },
//                   validator: (value) => value == null ? "Wajib Diisi" : null,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           if (widget.petani == null) {
//             _saveData(null, context);
//           } else {
//             _saveData(widget.petani, context);
//           }
//         },
//         child: const Icon(Icons.save),
//       ),
//     );
//   }
// }
