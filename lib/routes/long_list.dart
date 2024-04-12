import 'package:flutter/material.dart';
import 'package:tugas_ui/models/post.dart';
import 'package:tugas_ui/services/postapi.dart';

class LongList extends StatefulWidget {
  const LongList({super.key});

  @override
  State<LongList> createState() => _LongListState();
}

class _LongListState extends State<LongList> {
  // final List<String>_items=['item 1', 'item 2', 'item 3'];
  final List<Map>photos=[
  //     {
  //     "albumId": 1,
  //     "id": 1,
  //     "title": "accusamus beatae ad facilis cum similique qui sunt",
  //     "url": "https://via.placeholder.com/600/92c952",
  //     "thumbnailUrl": "https://via.placeholder.com/150/92c952"
  //   },
  //   {
  //     "albumId": 1,
  //     "id": 2,
  //     "title": "reprehenderit est deserunt velit ipsam",
  //     "url": "https://via.placeholder.com/600/771796",
  //     "thumbnailUrl": "https://via.placeholder.com/150/771796"
  //   },
  //   {
  //     "albumId": 1,
  //     "id": 3,
  //     "title": "officia porro iure quia iusto qui ipsa ut modi",
  //     "url": "https://via.placeholder.com/600/24f355",
  //     "thumbnailUrl": "https://via.placeholder.com/150/24f355"
  //   }
  ];
  Future<List<Post>> postsFuture = PostAPI.getPosts();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.blue,
        title: Text("Long List"),
        leading: BackButton(onPressed: () {
          Navigator.of(context).pop();
        }),
      ),
      body: Center(
        // FutureBuilder
        child: FutureBuilder<List<Post>>(
          future: postsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // until data is fetched, show loader
              return const CircularProgressIndicator();
            } else if (snapshot.hasData) {
              // once data is fetched, display it on screen (call buildPosts())
              final posts = snapshot.data!;
              return buildPosts(posts);
            } else {
              // if no data, show simple Text
              return const Text("No data available");
            }
          },
        ),
      ),
    );
  }

  // function to display fetched data on screen
  Widget buildPosts(List<Post> posts) {
    // ListView Builder to show data in a list
    return ListView.builder(
      itemCount: posts.length,
      itemBuilder: (context, index) {
        final post = posts[index];
        return Container(
          color: Colors.grey.shade300,
          margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          height: 100,
          width: double.maxFinite,
          child: Row(
            children: [
              Expanded(flex: 1, child: Image.network(post.url!)),
              SizedBox(width: 10),
              Expanded(flex: 3, child: Text(post.title!)),],
          ),
        );
      },
    );
  }
}