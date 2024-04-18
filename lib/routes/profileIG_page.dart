import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tugas_ui/helpers/photo_helper.dart';
import 'package:tugas_ui/models/photo_post.dart';

// import '../models/highlight.dart';

class ProfileIgPage extends StatefulWidget {
  const ProfileIgPage({Key? key}) : super(key: key);

  @override
  _ProfileIgPageState createState() => _ProfileIgPageState();
}

class _ProfileIgPageState extends State<ProfileIgPage> {
  late Stream<List<PostPhoto>> _postsStream;

  @override
  void initState() {
    super.initState();
    final phHelper = PhotoHelper();
    _postsStream = Stream.fromFuture(phHelper.getpostphoto());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Profile'),
      // ),
      body: DefaultTabController(
        length: 1,
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            const SliverToBoxAdapter(child: ProfileHeader()),
            SliverPersistentHeader(
              pinned: true,
              delegate: ProfileTabbar(
                child: Material(
                  child: TabBar(
                    labelColor: Colors.black,
                    indicatorColor: Colors.black,
                    tabs: [
                      Tab(
                        icon: Icon(Icons.grid_on),
                      ),
                      // Tab(
                      //   icon: Icon(Icons.assignment_ind_outlined),
                      // ),
                    ],
                  ),
                ),
              ),
            ),
          ],
          body: TabBarView(
            children: [
              StreamBuilder<List<PostPhoto>>(
                stream: _postsStream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return _ProfileGridView(posts: snapshot.data!);
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              ),
              // Container(
              //   color: Colors.white,
              //   child: const Center(
              //     child: Text('Grid View 2'),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProfileGridView extends StatelessWidget {
  final List<PostPhoto> posts;

  const _ProfileGridView({Key? key, required this.posts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.zero,
      physics: const ClampingScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 2,
        crossAxisSpacing: 2,
      ),
      itemCount: posts.length,
      itemBuilder: (BuildContext context, int index) {
        final post = posts[index];
        return Container(
          color: Colors.grey,
          child: Image.file(
            File(post.photo_name),
            fit: BoxFit.cover,
          ),
        );
      },
    );
  }
}

class ProfileTabbar extends SliverPersistentHeaderDelegate {
  final Widget child;

  ProfileTabbar({required this.child});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  // TODO: implement maxExtent
  double get maxExtent => 48;

  @override
  // TODO: implement minExtent
  double get minExtent => 48;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      false;
}

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: const [
          _ProfileInfo(),
          SizedBox(height: 12.0),
          _ProfileBio(),
          SizedBox(height: 12.0),
          _ProfileButtons(),
          // _StoryHighlights(),
        ],
      ),
    );
  }
}

// class _StoryHighlights extends StatelessWidget {
//   const _StoryHighlights({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 90,
//       child: ListView.builder(
//         scrollDirection: Axis.horizontal,
//         shrinkWrap: true,
//         itemCount: Highlight.highlights.length,
//         itemBuilder: (BuildContext context, int index) {
//           final highlight = Highlight.highlights[index];
//           return Container(
//             margin: const EdgeInsets.only(right: 12.0),
//             child: Column(
//               children: [
//                 Expanded(
//                   child: Container(
//                     height: 62,
//                     width: 62,
//                     padding: const EdgeInsets.all(4.0),
//                     decoration: BoxDecoration(
//                       border: Border.all(color: Colors.grey.shade300),
//                       shape: BoxShape.circle,
//                     ),
//                     child: Container(
//                       height: 60,
//                       width: 60,
//                       decoration: BoxDecoration(
//                         shape: BoxShape.circle,
//                         color: Colors.grey,
//                         border: Border.all(color: Colors.grey.shade300),
//                         image: DecorationImage(
//                           image: AssetImage(highlight.image),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 4.0),
//                 Text(
//                   highlight.name,
//                   textAlign: TextAlign.center,
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

class _ProfileButtons extends StatelessWidget {
  const _ProfileButtons({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextButton(
          onPressed: () {},
          style: TextButton.styleFrom(
            backgroundColor: Colors.grey.shade300,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
          ),
          child: Text(
            "Edit Profile",
            style: Theme.of(context).textTheme.button,
          ),
        ),
        Row(
          children: [
            Expanded(
              child: TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  backgroundColor: Colors.grey.shade300,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                ),
                child: Text(
                  "Ad Tools",
                  style: Theme.of(context).textTheme.button,
                ),
              ),
            ),
            const SizedBox(width: 8.0),
            Expanded(
              child: TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  backgroundColor: Colors.grey.shade300,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                ),
                child: Text(
                  "Insights",
                  style: Theme.of(context).textTheme.button,
                ),
              ),
            ),
            const SizedBox(width: 8.0),
            Expanded(
              child: TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  backgroundColor: Colors.grey.shade300,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                ),
                child: Text(
                  "Contact",
                  style: Theme.of(context).textTheme.button,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _ProfileBio extends StatelessWidget {
  const _ProfileBio({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Dhananjaya",
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 4.0),
        Text(
          "Software",
          style: Theme.of(context)
              .textTheme
              .titleSmall!
              .copyWith(color: Colors.grey),
        ),
        const SizedBox(height: 4.0),
        Text(
          """Software Engineer Studied Program""",
          style: Theme.of(context).textTheme.titleSmall,
        ),
      ],
    );
  }
}

class _ProfileInfo extends StatelessWidget {
  const _ProfileInfo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final phHelper = PhotoHelper();
    return FutureBuilder<int>(
      future: phHelper.getPhotoCount(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Row(
            children: [
              const _ProfileImage(),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _ProfileFollowersCountWidget(
                      count: snapshot.data.toString(),
                      title: "Posts",
                    ),
                    _ProfileFollowersCountWidget(
                      count: "0",
                      title: "Followers",
                    ),
                    _ProfileFollowersCountWidget(
                      count: "0",
                      title: "Following",
                    ),
                  ],
                ),
              ),
            ],
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}

class _ProfileFollowersCountWidget extends StatelessWidget {
  const _ProfileFollowersCountWidget({
    Key? key,
    required this.title,
    required this.count,
  }) : super(key: key);

  final String title, count;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          count,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        Text(title),
      ],
    );
  }
}

class _ProfileImage extends StatelessWidget {
  const _ProfileImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 80,
          width: 80,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            // color: Colors.red,
            image: DecorationImage(
              image: AssetImage('images/coba_profile.jpg'),
            ),
          ),
        ),
        Positioned(
          right: 0,
          bottom: 0,
          child: Container(
            height: 22,
            width: 22,
            decoration: BoxDecoration(
              color: Colors.blue,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2),
            ),
            child: const Icon(
              Icons.add,
              color: Colors.white,
              size: 15,
            ),
          ),
        ),
      ],
    );
  }
}

// class _InstagramProfileAppBar extends StatelessWidget {
//   const _InstagramProfileAppBar({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return SliverAppBar(
//       pinned: true,
//       title: Row(
//         children: const [
//           Text(
//             "ebapp",
//             style: TextStyle(
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           Icon(Icons.keyboard_arrow_down),
//         ],
//       ),
//       actions: [
//         IconButton(
//           onPressed: () {},
//           icon: const Icon(Icons.add_box_outlined),
//         ),
//         IconButton(
//           onPressed: () {},
//           icon: const Icon(Icons.dehaze_outlined),
//         ),
//       ],
//     );
//   }
// }
