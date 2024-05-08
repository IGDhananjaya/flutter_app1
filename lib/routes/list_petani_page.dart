import 'package:flutter/material.dart';
import 'package:tugas_ui/models/petani.dart';
import 'package:tugas_ui/routes/EditPetaniPage.dart';
import 'package:tugas_ui/routes/TambahPetaniPage.dart';
import 'package:tugas_ui/routes/detail_petani_page.dart';
import 'package:tugas_ui/services/apiStatic.dart';

class DatasScreen extends StatefulWidget {
  const DatasScreen({Key? key, required this.futurePetani}) : super(key: key);

  final Future<List<Petani>> futurePetani;

  @override
  State<DatasScreen> createState() => _DatasScreenState();
}

class _DatasScreenState extends State<DatasScreen> {
  late final ApiStatic _apiStatic;

  @override
  void initState() {
    super.initState();
    _apiStatic = ApiStatic();
  }

  void refreshData() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Petani List'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TambahPetaniPage(petani: Petani(),),
                ),
              );
              refreshData();
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder<List<Petani>>(
                future: widget.futurePetani,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (snapshot.hasData) {
                    final List<Petani> petaniList = snapshot.data!;
                    return ListView.builder(
                      itemCount: petaniList.length,
                      itemBuilder: (BuildContext context, int index) => Column(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      DetailPetaniPage(
                                    petani: petaniList[index],
                                  ),
                                ),
                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    const SizedBox(width: 16),
                                    Text(
                                      '${petaniList[index].nama}',
                                      style: const TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.edit),
                                      onPressed: () async {
                                        await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                EditPetaniPage(
                                              petani: petaniList[index],
                                            ),
                                          ),
                                        );
                                        refreshData();
                                      },
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.delete),
                                      onPressed: () async {
                                        final confirmed = await showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              title:
                                                  const Text('Confirm Delete'),
                                              content: const Text(
                                                  'Are you sure you want to delete this petani?'),
                                              actions: [
                                                TextButton(
                                                  child: const Text('Cancel'),
                                                  onPressed: () {
                                                    Navigator.of(context)
                                                        .pop(false);
                                                  },
                                                ),
                                                TextButton(
                                                  child: const Text('Delete'),
                                                  onPressed: () async {
                                                    try {
                                                      final idPenjual =
                                                          petaniList[index]
                                                              .idPenjual;
                                                      if (idPenjual != null) {
                                                        final apiInstance =
                                                            ApiStatic(); // Create an instance of ApiStatic
                                                        await ApiStatic
                                                            .deletePetani(
                                                                idPenjual); // Call deletePetani on the instance
                                                        setState(() {});
                                                      }
                                                    } catch (e) {
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                        SnackBar(
                                                          content: Text(
                                                              'Failed to delete petani: $e'),
                                                        ),
                                                      );
                                                    }
                                                    Navigator.pop(
                                                        context, true);
                                                  },
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                        if (confirmed != null && confirmed) {
                                          refreshData();
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  } else {
                    return const Text('No data available');
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
