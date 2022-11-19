import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:travelapp/models/place.dart';
import 'package:travelapp/repository/firebase_api.dart';

class NewPlacePage extends StatefulWidget {
  const NewPlacePage({Key? key}) : super(key: key);

  @override
  _NewPlacePageState createState() => _NewPlacePageState();
}

class _NewPlacePageState extends State<NewPlacePage> {
  final FirebaseApi _firebaseApi = FirebaseApi();

  final _name = TextEditingController();
  final _city = TextEditingController();
  final _deparment = TextEditingController();
  final _temperature = TextEditingController();
  final _description = TextEditingController();

  double _rating = 3.0;

  void _showMsg(BuildContext context, String msg) {
    final Scaffold = ScaffoldMessenger.of(context);
    Scaffold.showSnackBar(
      SnackBar(
          content: Text(msg),
          action: SnackBarAction(
              label: 'Aceptar', onPressed: Scaffold.hideCurrentSnackBar)),
    );
  }

  void _createPlace(Place place) async {
    var result = await _firebaseApi.createPlace(place);
    _showMsg(context, result);
    Navigator.pop(context);
  }

  void _savePlace() {
    var name = "";
    var city = "";
    var deparment = "";
    var temperature = "";
    if (_name.text.isNotEmpty) name = _name.text;
    if (_city.text.isNotEmpty) city = _city.text;
    if (_deparment.text.isNotEmpty) deparment = _deparment.text;
    if (_temperature.text.isNotEmpty) temperature = _temperature.text;
    var place = Place("", _name.text, _city.text, _deparment.text,
        _temperature.text, _rating, _description.text);
    _createPlace(place);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Nuevo Lugar")),
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 16),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    controller: _name,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), labelText: 'Nombre'),
                    keyboardType: TextInputType.text,
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  TextFormField(
                    controller: _city,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), labelText: 'Ciudad'),
                    keyboardType: TextInputType.text,
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  TextFormField(
                    controller: _deparment,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Departamento'),
                    keyboardType: TextInputType.text,
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  TextFormField(
                    controller: _temperature,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), labelText: 'Temperatura'),
                    keyboardType: TextInputType.text,
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  RatingBar.builder(
                    initialRating: 3,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {
                      _rating = rating;
                    },
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  const Text(
                    'Agrega una descripción',
                    style: TextStyle(fontSize: 20),
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  TextFormField(
                      controller: _description,
                      minLines: 1,
                      maxLines: 5,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Descripción'),
                      keyboardType: TextInputType.multiline),
                  const SizedBox(
                    height: 16.0,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        _savePlace();
                      },
                      child: const Text('Guardar Lugar'))
                ],
              ),
            )));
  }
}
