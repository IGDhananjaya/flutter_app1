// class Petani{
//   Petani({
//         required this.idPenjual,
//         required this.nama,
//         required this.nik,
//         required this.alamat,
//         required this.telp,
//         required this.foto,
//         required this.idKelompokTani,
//         required this.status,
//         required this.namaKelompok,
//     });
//     int idPenjual;
//     String nama;
//     String nik;
//     String alamat;
//     String telp;
//     String foto;
//     int idKelompokTani;
//     String status;
//     String namaKelompok;
    
//     factory Petani.fromJson(Map<String, dynamic> json) => Petani(
//         idPenjual: json["id_penjual"] as int,
//         nama: (json["nama"]==null || json["nama"]=='')?'':json["nama"].toString(),
//         nik: (json["nik"]==null || json["nik"]=='')?'':json["nik"].toString(),
//         alamat: json["alamat"].toString(),
//         telp: json["telp"].toString(),
//         foto: json["foto"].toString(),
//         idKelompokTani: json["id_kelompok_tani"] as int,
//         status: json["status"].toString(),
//         namaKelompok: json["nama_kelompok"].toString(),
//     );
// }

class Petani {
  final String? idPenjual;
  final String? idKelompokTani;
  final String? nama;
  final String? nik;
  final String? alamat;
  final String? telp;
  final String? foto;
  final String? status;
  final String? namaKelompok;
  

  const Petani({
    this.idPenjual,
    this.idKelompokTani,
    this.nama,
    this.nik,
    this.alamat,
    this.telp,
    this.foto,
    this.status,
    this.namaKelompok,
  });

  factory Petani.fromJson(Map<String, dynamic> json) {
    return Petani(
      idPenjual: json['idPenjual'],
      idKelompokTani: json['idKelompokTani'],
      nama: json['nama'],
      nik: json['nik'],
      alamat: json['alamat'],
      telp: json['telp'],
      foto: json['foto'],
      status: json['status'],
      namaKelompok: json['namaKelompok'],
    );
  }

}