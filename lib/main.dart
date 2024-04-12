import 'package:flutter/material.dart';
// import 'package:tugas_ui/homePage.dart';
import 'package:tugas_ui/routes/login_page.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Test',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
      // routes: {
      //   '/front_page': (context) => frontpage(),
      //   '/second_screen': (context) => SecondScreen(),
      // },
    );
  }
}
