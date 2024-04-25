import 'package:flutter/material.dart';
import 'package:tugas_ui/models/petani.dart';

class DetailPetaniPage extends StatelessWidget {
  final Petani petani;

  const DetailPetaniPage({required this.petani});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Petani'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (petani.foto != null)
              Container(
                height: 200,
                width: double.infinity,
                child: Image.network(
                  petani.foto!,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.error, color: Colors.red),
                        Text('Gambar tidak dapat diakses'),
                      ],
                    );
                  },
                ),
              ),
            const SizedBox(height: 16),
            Text(
              'ID Penjual: ${petani.idPenjual}',
              style:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text('ID Kelompok Tani: ${petani.idKelompokTani}'),
            const SizedBox(height: 16),
            Text(
              'Nama: ${petani.nama}',
              style:
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text('NIK: ${petani.nik}'),
            const SizedBox(height: 8),
            Text('Alamat: ${petani.alamat}'),
            const SizedBox(height: 8),
            Text('No. Telp: ${petani.telp}'),
            const SizedBox(height: 16),
            Text(
              'Foto: ${petani.foto}',
              style:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text('Status: ${petani.status}'),
            const SizedBox(height: 16),
            Text(
              'Nama Kelompok: ${petani.namaKelompok}',
              style:
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}