import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:travelapp/pages/detail_place_page.dart';

class PlacesStorePage extends StatefulWidget {
  const PlacesStorePage({super.key});

  @override
  State<PlacesStorePage> createState() => _PlacesStorePageState();
}

class _PlacesStorePageState extends State<PlacesStorePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 16),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection("places").snapshots(),
          builder: ((context, snapshot) {
            if (!snapshot.hasData) return const Text("Loading");
            return ListView.builder(
                itemCount: snapshot.data?.docs.length,
                itemBuilder: ((context, index) {
                  QueryDocumentSnapshot place = snapshot.data!.docs[index];
                  return Card(
                      child: ListTile(
                    leading: Image.network(
                      place['urlPicture'] ?? "",
                      errorBuilder: (BuildContext context, Object exception,
                          StackTrace? strackTrace) {
                        return const Image(
                          image: AssetImage('assets/images/Logo.png'),
                        );
                      },
                    ),
                    title: Text(place['name']),
                    subtitle: Text(place['address']),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  DetailStorePage(place)));
                    },
                  ));
                }));
          }),
        ),
      ),
    );
  }
}
