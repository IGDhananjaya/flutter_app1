import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  final double coverHeight=280;
  final double profileHeight=144;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.blue,
        title: const Text("Profile"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: buildTop(),
          ),
          SliverToBoxAdapter(
            child: buildContent(),
          ),
        ],
      ),
    );
  }

  Widget buildTop(){
    final bottom=profileHeight/2;
    final top=coverHeight-profileHeight/2;
    return Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: bottom),
            child: buildCoverImages(),
          ),
          Positioned(
            top: top,
            child: buildProfileImage(),
          ),
        ],
      );
  }

  Widget buildCoverImages()=>Container(
    color: Colors.grey,
    child: Image(
      image: AssetImage('images/day 1 cxamp-43.jpg'),
      width: double.infinity,
      height: coverHeight,
      fit: BoxFit.cover,
    ),
  );

  Widget buildProfileImage()=>CircleAvatar(
    radius: profileHeight/2,
    backgroundColor: Colors.grey.shade800,
    backgroundImage: AssetImage('images/coba_profile.jpg'),
  );

  Widget buildContent()=>Column(
    children: [
      const SizedBox(height: 8,),
      Text(
        'I Gede Dhananjaya',
        style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
      ),
      const SizedBox(height: 8,),
      Text(
        'Undiksha',
        style: TextStyle(fontSize: 20, color: Colors.black38),
      ),

      const SizedBox(height: 16,),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          buildSocialIcon(FontAwesomeIcons.facebook),
          const SizedBox(width: 12,),
          buildSocialIcon(FontAwesomeIcons.github),
          const SizedBox(width: 12,),
          buildSocialIcon(FontAwesomeIcons.twitter),
          const SizedBox(width: 12,),
          buildSocialIcon(FontAwesomeIcons.linkedin),
        ],
      ),

      const SizedBox(height: 16,),
      Divider(),
      // const SizedBox(height: 16,),
      // NumberWidget(),
      // const SizedBox(height: 16,),
      // Divider(),
      const SizedBox(height: 16,),
      buildAbout(),
      const SizedBox(height: 32,)
    ],
  );

  Widget buildAbout()=>Container(
    padding: EdgeInsets.symmetric(horizontal: 48),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'About',
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16,),
        Text(
          'Software Engineer Study Program',
          style: TextStyle(fontSize: 18, height: 1.4),
        ),
      ],
    ),
  );

  Widget buildSocialIcon(IconData icon)=>CircleAvatar(
    radius: 25,
    child: Material(
      shape: CircleBorder(),
      clipBehavior: Clip.hardEdge,
      color: Colors.transparent,
      child: InkWell(
        onTap: () {},
        child: Center(child: Icon(icon, size: 32,),),
      ),
    ),
  );
}