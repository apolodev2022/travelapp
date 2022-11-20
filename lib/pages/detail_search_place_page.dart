import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';
import 'package:travelapp/boxes.dart';
import 'package:travelapp/models/local_place.dart';
import 'package:travelapp/models/result.dart';

class DetailSearchPlacePage extends StatefulWidget {
  final Results place;

  const DetailSearchPlacePage({super.key, required this.place});

  @override
  State<DetailSearchPlacePage> createState() => _DetailSearchPlacePageState();
}

class _DetailSearchPlacePageState extends State<DetailSearchPlacePage> {
  var isFavorite = false;

  @override
  void initState() {
    // TODO: implement initState
    _getLocalPlace();
    super.initState();
  }

  void _getLocalPlace() {
    final box = Boxes.getFavoritesBox();
    box.values.forEach((element) {
      if (element.id == widget.place.placeId) {
        isFavorite = true;
      }
    });
  }

  void _onFavoritesButtonClicked() async {
    var localPlace = LocalPlace()
      ..id = widget.place.placeId
      ..name = widget.place.name
      ..city = widget.place.vicinity
      ..type = widget.place.types?[0]
      ..imageLink = widget.place.photos?.first.photoReference;

    final box = Boxes.getFavoritesBox();
    // box.add(localPlace);

    if (isFavorite) {
      box.delete(localPlace.id);
    } else {
      box.put(localPlace.id, localPlace);
    }

    setState(() {
      isFavorite = !isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.place.name ?? "Detalle"),
        ),
        body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                  Image.network(
                    'https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photo_reference=${widget.place.photos?.first.photoReference}' ??
                        "",
                    errorBuilder: (BuildContext context, Object exeption,
                        StackTrace? strackTrace) {
                      return const Image(
                        image: AssetImage('assets/images/Logo.png'),
                      );
                    },
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: IconButton(
                          alignment: Alignment.topRight,
                          icon: Icon(isFavorite
                              ? Icons.favorite
                              : Icons.favorite_border),
                          color: Colors.red,
                          onPressed: () {
                            _onFavoritesButtonClicked();
                          },
                        ),
                      ),
                    ],
                  ),
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Ciudad: ${widget.place.vicinity}",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 17.0, fontStyle: FontStyle.italic))),
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Tipo: ${widget.place.types?.iterator}",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 17.0, fontStyle: FontStyle.italic)))
                ]))));
  }
}
