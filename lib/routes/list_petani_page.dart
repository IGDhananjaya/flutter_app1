import 'package:flutter/material.dart';
import 'package:tugas_ui/models/petani.dart';
import 'package:tugas_ui/services/apiStatic.dart';


class DatasScreen extends StatefulWidget {
  const DatasScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _DatasScreenState createState() => _DatasScreenState();
}

class _DatasScreenState extends State<DatasScreen> {
  late Future<Petani> futurePetani;


  @override
  void initState() {
    super.initState();
    // futurePetani = ApiStatic.getPetani();
  }

    @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // title: 'Fetch Data Example',
      // theme: ThemeData(
      //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      // ),
      home: Scaffold(
        // appBar: AppBar(
        //   title: const Text('Fetch Data Example'),
        // ),
        body: Center(
          child: FutureBuilder<Petani>(
            future: futurePetani,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final petani = snapshot.data!;

                return Text("${petani.nama}");
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            },
          ),
        ),
    ),
);
}
}