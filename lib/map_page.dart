import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:khaled_belarbi/models/map_model.dart';

class MapPage extends StatefulWidget {
  final List<ImageDataModel>? imageDataModel;
  final String? lat;
  final String? lng;
  const MapPage({Key? key, this.lat, this.lng, this.imageDataModel = const []}) : super(key: key);

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late GoogleMapController mapController;
  final Map<String, Marker> _markers = {};

  final LatLng _center = const LatLng(23.173939, 81.565125);


  @override
  void dispose() {
    mapController.dispose();
    super.dispose();
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    _markers.clear();
    if (widget.lat != null || widget.lng != null) {
      setState(() {
        final marker = Marker(
          markerId: const MarkerId("id1"),
          position: LatLng(double.parse(widget.lat!), double.parse(widget.lng!)),
          infoWindow: const InfoWindow(
            title: "title",
            snippet: "snippet",
          ),
        );
        _markers["id1"] = marker;
      });
      mapController.animateCamera(
          CameraUpdate.newLatLngZoom(LatLng(double.parse(widget.lat!), double.parse(widget.lng!)), 10));
    } else if (widget.imageDataModel!.isNotEmpty) {

      setState(() {
        for (final model in widget.imageDataModel!) {
          if (model.lat != "" && widget.lng != "") {
            final marker = Marker(
              markerId: MarkerId(model.path!),
              position: LatLng(double.parse(model.lat!), double.parse(model.lng!)),
              infoWindow: const InfoWindow(
                title: "title",
                snippet: "snippet",
              ),
            );
            _markers[model.path!] = marker;
          }
        }
      });

      mapController.animateCamera(
          CameraUpdate.newLatLngBounds(_getBounds(_markers.values.toList()), 50));
    }

    print("Markers.length: ${_markers.length}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Maps Sample App'),
        backgroundColor: Colors.green[700],
      ),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: _center,
          zoom: 5,
        ),
        markers: _markers.values.toSet(),
      ),
    );
  }

  LatLngBounds _getBounds(List<Marker> markerLocations) {
    var lngs = markerLocations.map<double>((m) => m.position.longitude).toList();
    var lats = markerLocations.map<double>((m) => m.position.latitude).toList();

    var topMost = lngs.reduce(max);
    var leftMost = lats.reduce(min);
    var rightMost = lats.reduce(max);
    var bottomMost = lngs.reduce(min);

    var bounds = LatLngBounds(
      northeast: LatLng(rightMost, topMost),
      southwest: LatLng(leftMost, bottomMost),
    );

    return bounds;
  }
}
