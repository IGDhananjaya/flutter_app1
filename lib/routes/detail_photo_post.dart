import 'package:flutter/material.dart';
import 'package:tugas_ui/models/data.dart';
import 'package:tugas_ui/models/photo_post.dart';

class DetailPhotoPost extends StatelessWidget {
  final PostPhoto post;

  const DetailPhotoPost({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(post.user.username),
      // ),
      body: Column(
        children: [
          Expanded(
            child: Image.network(
              post.photo_name,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            post.description,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Text(
            'Dhananjaya',
            style: const TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}