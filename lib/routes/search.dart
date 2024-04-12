import 'package:flutter/material.dart';
import 'package:tugas_ui/models/post.dart';
import 'package:tugas_ui/services/postapi.dart';
// import 'package:tugas_ui/utils/post_api.dart'; // Import kelas yang memanggil API

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late Future<List<Post>> _postsFuture;

  @override
  void initState() {
    super.initState();
    _postsFuture = PostAPI.getPosts(); // Panggil metode untuk mendapatkan postingan
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Container(
            padding: EdgeInsets.all(8),
            color: Colors.grey,
            child: Row(
              children: [
                Icon(
                  Icons.search,
                  color: Colors.black38,
                ),
                Container(
                  child: Text(
                    'Search',
                    style: TextStyle(color: Colors.black38),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      body: FutureBuilder<List<Post>>(
        future: _postsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            return ExploreGrid(posts: snapshot.data ?? []);
          }
        },
      ),
    );
  }
}

class ExploreGrid extends StatelessWidget {
  final List<Post> posts;

  const ExploreGrid({Key? key, required this.posts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemCount: posts.length,
      itemBuilder: (context, index) {
        return GridTile(
          child: Image.network(
            posts[index].url ?? '', // Use null-aware operator to handle nullable url
            fit: BoxFit.cover,
          ),
        );
      },
    );
  }
}

