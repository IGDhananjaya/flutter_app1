import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tugas_ui/helpers/photo_helper.dart';
import 'package:tugas_ui/homePage.dart';
import 'package:tugas_ui/models/photo_post.dart';
// import 'package:tugas_ui/routes/profileIG_page.dart';

class PostPhotoPage extends StatefulWidget {
  @override
  _PostPhotoPageState createState() => _PostPhotoPageState();
}

class _PostPhotoPageState extends State<PostPhotoPage> {
  late PostPhoto _postPhoto;
  final _picker = ImagePicker();
  final _descriptionController = TextEditingController();

  @override
  // void initState() {
  //   super.initState();
  //   _postPhoto = PostPhoto(id: 0, photo_name: '', description: '');
  // }

  void initState() {
    super.initState();
    _postPhoto = PostPhoto(
        id: null, photo_name: '', description: '', datetime: DateTime.now());
  }

  // Future<void> _getImage(ImageSource source) async {
  //   final pickedFile = await _picker.pickImage(source: source);

  //   if (pickedFile != null) {
  //     setState(() {
  //       _postPhoto =
  //           PostPhoto(id: 0, photo_name: pickedFile.path, description: '');
  //     });
  //   }
  // }

  // Future<void> _getImage(ImageSource source) async {
  //   final pickedFile = await _picker.pickImage(source: source);

  //   if (pickedFile != null) {
  //     setState(() {
  //       _postPhoto = PostPhoto(
  //         id: Random().nextInt(1000000), // Generate a new unique id value
  //         photo_name: pickedFile.path,
  //         description: '',
  //       );
  //     });
  //   }
  // }

  Future<void> _getImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _postPhoto = PostPhoto(
          id: null, // Let the database generate the id value
          photo_name: pickedFile.path,
          description: '',
          datetime: DateTime.now(), // Add the datetime value
        );
      });
    }
  }

  //   Future<void> _savePost() async {
  //   if (_postPhoto.photoName.isNotEmpty) {
  //     final phHelper = PhotoHelper();
  //     await phHelper.add(_postPhoto);
  //     Navigator.pushReplacement(
  //       context,
  //       MaterialPageRoute(builder: (context) => ProfileIgPage()),
  //     );
  //   }
  // }

  // Future<void> _savePost() async {
  //   if (_postPhoto.photo_name.isNotEmpty) {
  //     final phHelper = PhotoHelper();
  //     await phHelper.ph; // Ensure the database is opened
  //     await phHelper.add(_postPhoto);
  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(builder: (context) => ProfileIgPage()),
  //     );
  //   }
  // }

  Future<void> _savePost() async {
    if (_postPhoto.photo_name.isNotEmpty) {
      final phHelper = PhotoHelper();
      await phHelper.ph; // Ensure the database is opened
      await phHelper.add(_postPhoto);

      // Navigate to the MyHomePage with _selectedIndex set to 4
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              MyHomePage(title: 'Home Screen', selectedIndex: 4),
        ),
      );
    }
  }

  // Future<void> _savePost() async {
  //   if (_postPhoto.photoName.isNotEmpty) {
  //     final phHelper = PhotoHelper();
  //     final rowsAffected = await phHelper.add(
  //         _postPhoto); // Asumsikan ini mengembalikan jumlah baris yang terpengaruh
  //     if (rowsAffected > 0) {
  //       // Data berhasil disimpan
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text('Photo saved')),
  //       );
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(builder: (context) => ProfileIgPage()),
  //       );
  //     } else {
  //       // Data gagal disimpan
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text('Failed to save photo')),
  //       );
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Post a photo'),
      // ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Image section
            Container(
              height: 250,
              width: double.infinity,
              decoration: _postPhoto.photo_name.isEmpty
                  ? BoxDecoration(color: Colors.grey[200])
                  : BoxDecoration(
                      image: DecorationImage(
                        image: FileImage(File(_postPhoto.photo_name)),
                        fit: BoxFit.cover,
                      ),
                    ),
              child: Align(
                alignment: Alignment.topRight,
                child: Row(
                  mainAxisSize: MainAxisSize
                      .min, // Menyusutkan Row agar sesuai dengan ukuran anak-anaknya
                  children: [
                    IconButton(
                      icon: Icon(Icons.camera_alt),
                      onPressed: () {
                        _getImage(ImageSource.camera);
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.photo_library), // Icon untuk gallery
                      onPressed: () {
                        _getImage(ImageSource.gallery);
                      },
                    ),
                  ],
                ),
              ),
            ),
            // Description section
            Container(
              padding: EdgeInsets.all(16),
              child: TextField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  hintText: 'Write a caption...',
                  border: InputBorder.none,
                ),
                maxLines: null,
                onChanged: (value) {
                  setState(() {
                    _postPhoto.description = value;
                  });
                },
              ),
            ),
            // Posting actions section
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: _savePost,
                    child: Text('Save'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
