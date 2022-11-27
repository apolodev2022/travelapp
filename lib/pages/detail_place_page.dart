import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';

class DetailStorePage extends StatefulWidget {
  var place;

  DetailStorePage(this.place);

  @override
  State<DetailStorePage> createState() => _DetailStorePageState(place);
}

class _DetailStorePageState extends State<DetailStorePage> {
  var place;

  _DetailStorePageState(this.place);

  final Completer<GoogleMapController> _controller = Completer();

  final Set<Marker> _markers = Set<Marker>();

  CustomInfoWindowController _customInfoWindowController =
      CustomInfoWindowController();

  @override
  void dispose() {
    _customInfoWindowController.dispose();
    super.dispose();
  }

  // static final CameraPosition _kGooglePlex = CameraPosition(
  //   target: LatLng(37.42796133580664, -122.085749655962),
  //   zoom: 14.4746,
  // );

  // static final CameraPosition _kLake = CameraPosition(
  //     bearing: 192.8334901395799,
  //     target: LatLng(37.43296265331129, -122.08832357078792),
  //     tilt: 59.440717697143555,
  //     zoom: 19.151926040649414);

  // Future<void> _goToTheLake() async {
  //   final GoogleMapController controller = await _controller.future;
  //   controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(widget.place['name'])),
        body: Stack(
          children: [
            GoogleMap(
              mapType: MapType.terrain,
              initialCameraPosition: CameraPosition(
                target: LatLng(place['latitude'], place['longitude']),
                zoom: 15,
              ),
              markers: _markers,
              onTap: (position) {
                _customInfoWindowController.hideInfoWindow!();
              },
              onCameraMove: (position) {
                _customInfoWindowController.onCameraMove!();
              },
              onMapCreated: (GoogleMapController controller) async {
                _customInfoWindowController.googleMapController = controller;
                // _controller.complete(controller);
                _showMarker();
              },
            ),
            CustomInfoWindow(
              controller: _customInfoWindowController,
              height: 200,
              width: 200,
              offset: 50,
            )
          ],
        )
        // floatingActionButton: FloatingActionButton.extended(
        //   onPressed: _goToTheLake,
        //   label: Text('To the lake!'),
        //   icon: Icon(Icons.directions_boat),
        // ),
        );
  }

  void _showMarker() {
    setState(() {
      _markers.add(Marker(
          markerId: MarkerId(place['name']),
          icon: BitmapDescriptor.defaultMarker,
          position: LatLng(place['latitude'], place['longitude']),
          infoWindow: InfoWindow(
              title: place['name'], snippet: "Telefóno> ${place['phone']}"),
          onTap: () {
            _customInfoWindowController.addInfoWindow!(
              Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(place['urlPicture']),
                                fit: BoxFit.fitWidth,
                                filterQuality: FilterQuality.high),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(10.0),
                              topRight: Radius.circular(10.0),
                            ),
                            color: Colors.blue,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Horario: ${place['schedule']}",
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 10.0),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Dirección: ${place['address']}",
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 10.0),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Telefóno: ${place['phone']}",
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 10.0),
                        ),
                      ),
                    ],
                  )),
              LatLng(place['latitude'], place['longitude']),
            );
          }));
    });
  }
}
