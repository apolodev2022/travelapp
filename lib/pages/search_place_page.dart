import 'package:flutter/material.dart';
import 'package:travelapp/models/place.dart';
import 'package:travelapp/models/result.dart';
import 'package:travelapp/pages/detail_search_place_page.dart';
import 'package:travelapp/repository/places_api.dart';

class SearchPlacePage extends StatefulWidget {
  const SearchPlacePage({Key? key}) : super(key: key);

  @override
  State<SearchPlacePage> createState() => _SearchPlacePageState();
}

class _SearchPlacePageState extends State<SearchPlacePage> {
  PlacesApi _placesApi = PlacesApi();
  final _parametro = TextEditingController();

  List<Results> listPlaces = <Results>[];

  Future _searchPlace() async {
    Result resultFuture =
        await _placesApi.getPlaces(_parametro.text, "2.436019", "-76.614239");
    setState(() {
      resultFuture.results?.forEach((element) {
        listPlaces.add(element);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Google Place API"),
        ),
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: Center(
              child: Column(children: [
                TextFormField(
                    controller: _parametro,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Dígite Lugar'),
                    keyboardType: TextInputType.text),
                const SizedBox(
                  height: 16.0,
                ),
                ElevatedButton(
                    style: TextButton.styleFrom(
                      textStyle: const TextStyle(fontSize: 20),
                    ),
                    onPressed: () {
                      _searchPlace();
                    },
                    child: const Text('Buscar Lugar')),
                Expanded(
                  child: ListView.builder(
                      itemCount: listPlaces.length,
                      itemBuilder: (BuildContext context, int index) {
                        Results place = listPlaces[index];
                        return Card(
                            child: ListTile(
                          leading: Image.network(
                            'https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photo_reference=${place.photos?.first.photoReference}' ??
                                "",
                            errorBuilder: (BuildContext context,
                                Object exeption, StackTrace? strackTrace) {
                              return const Image(
                                image: AssetImage('assets/images/Logo.png'),
                              );
                            },
                          ),
                          title: Text(place.name ?? "No title"),
                          subtitle: Text(place.vicinity ?? "No vicinity"),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        DetailSearchPlacePage(place: place)));
                          },
                        ));
                      }),
                )
              ]),
            )));
  }
}
