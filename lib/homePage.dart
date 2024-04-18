import 'package:flutter/material.dart';
import 'package:tugas_ui/models/data.dart';
import 'package:tugas_ui/routes/about_page.dart';
import 'package:tugas_ui/routes/books_screen.dart';
import 'package:tugas_ui/routes/list_petani_page.dart';
// import 'package:tugas_ui/routes/account_page.dart';
import 'package:tugas_ui/routes/login_page.dart';
// import 'package:tugas_ui/routes/login_page.dart';
import 'package:tugas_ui/routes/long_list.dart';
import 'package:tugas_ui/routes/post_page.dart';
import 'package:tugas_ui/routes/post_photo_page.dart';
import 'package:tugas_ui/routes/profileIG_page.dart';
import 'package:tugas_ui/routes/profile_page.dart';
import 'package:tugas_ui/routes/reels_page.dart';
import 'package:tugas_ui/routes/search.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Home Screen'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  // const MyHomePage({Key? key, required this.title}) : super(key: key);
  const MyHomePage({Key? key, required this.title, this.selectedIndex = 0})
      : super(key: key);
  final String title;
  final int selectedIndex;

  // int get selectedIndex => _MyHomePageState()._selectedIndex;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  final List<String> people = ['Jojo', 'Todo', 'Desri'];

  late final List<Widget> _screens;
  // final List<PostSQF> postsqf = allData.map((post) => PostSQF.fromMap(post)).toList();

  @override
  void initState() {
    super.initState();
    // Get the first PostSQF object from the allData list
    // final PostSQF post = allData.first;
    _screens = [
      ListViewPage(people: allData),
      const SearchPage(),
      ReelsPage(),
      PostPhotoPage(), // Add TrySaveImage widget here
      ProfileIgPage(),
      DatasScreen(),
    ];
  }

  final List<String> _appBarTitles = const [
    'Home',
    'Search',
    'Reels',
    'Add Post',
    'Personal',
    'Petani'
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // if (index == 4) {
    //   ProfileIgPage();
    // }
  }

  @override
  Widget build(BuildContext context) {
    final int? selectedIndex =
        ModalRoute.of(context)?.settings.arguments as int?;
    if (selectedIndex != null) {
      _selectedIndex = selectedIndex;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(_appBarTitles[_selectedIndex]),
        backgroundColor: Colors.black12,
      ),
      // body: Column(
      //   crossAxisAlignment: CrossAxisAlignment.stretch,
      //   children: [
      //     Expanded(child: _screens[_selectedIndex]),
      //   ],
      // ),
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
      drawer: Drawer(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black54,
                blurRadius: 10.0,
                spreadRadius: 2.0,
                offset: Offset(3.0, 3.0),
              ),
            ],
          ),
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.black12,
                ),
                child: Text('Drawer Header'),
              ),
              ListTile(
                title: const Text('Home'),
                trailing: const Icon(Icons.home),
                onTap: () {
                  Navigator.pop(context);
                  _onItemTapped(0);
                },
              ),
              ListTile(
                title: const Text('Profile'),
                trailing: const Icon(Icons.person),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ProfilePage()),
                  );
                },
              ),
              ListTile(
                title: const Text('Long List'),
                trailing: const Icon(Icons.list_rounded),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LongList()),
                  );
                },
              ),
              ListTile(
                title: const Text('SQFlite Test'),
                trailing: const Icon(Icons.data_object),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => BooksScreen()),
                  );
                },
              ),
              Divider(),
              ListTile(
                title: const Text('Information'),
                trailing: const Icon(Icons.info_rounded),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AboutPage()),
                  );
                },
              ),
              ListTile(
                title: Text('Logout'),
                trailing: const Icon(Icons.door_back_door),
                onTap: () {
                  // Clear any saved user data here if necessary

                  // Navigate to LoginPage
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black54,
              blurRadius: 10.0,
              spreadRadius: 2.0,
              offset: Offset(3.0, 3.0),
            ),
          ],
        ),
        child: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
              backgroundColor: Colors.black12,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Search',
              backgroundColor: Colors.black12,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.movie_creation),
              label: 'Reels',
              backgroundColor: Colors.black12,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add_a_photo),
              label: 'Add Post',
              backgroundColor: Colors.black12,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Personal',
              backgroundColor: Colors.black12,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.family_restroom),
              label: 'Petani List',
              backgroundColor: Colors.black12,
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.black,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}

// class ListViewPage extends StatelessWidget {
//   final List<String> people;

//   const ListViewPage({Key? key, required this.people}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       itemCount: people.length,
//       itemBuilder: (context, index) {
//         return PostPage(name: people.elementAt(index));
//       },
//     );
//   }
// }

class ListViewPage extends StatelessWidget {
  final List<Posting> people;

  const ListViewPage({Key? key, required this.people}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: people.length,
      itemBuilder: (context, index) {
        final Posting posting = people[index];
        return PostPage(post: posting);
      },
    );
  }
}

// class ListViewPage extends StatelessWidget {
//   final List<PostSQF> posts;

//   const ListViewPage({Key? key, required this.posts}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       itemCount: posts.length,
//       itemBuilder: (context, index) {
//         final PostSQF post = posts[index];
//         return PostPageSQF(postsqf: post);
//       },
//     );
//   }
// }