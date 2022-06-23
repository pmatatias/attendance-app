import 'dart:async';
import 'package:attendance_app/utils/appstate.dart';
import 'package:attendance_app/utils/konstanta.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class MyMaps extends StatefulWidget {
  const MyMaps({Key? key}) : super(key: key);

  @override
  State<MyMaps> createState() => _MyMapsState();
}

class _MyMapsState extends State<MyMaps> {
  final Completer<GoogleMapController> _controller = Completer();
  Set<Marker> _markers = {};
  @override
  void initState() {
    init();
    super.initState();
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  void init() {
    final state = context.read<AppState>();

    if (state.masterData?.latitude != null &&
        state.masterData?.longitude != null) {
      _markers.add(
        Marker(
          markerId: MarkerId(state.masterData!.name.toString()),
          position:
              LatLng(state.masterData!.latitude!, state.masterData!.longitude!),
          icon: BitmapDescriptor.defaultMarker,
          infoWindow: InfoWindow(
            title: state.masterData!.name,
          ),
        ),
      );
    }
    if (state.userData?.latitude != null &&
        state.masterData?.longitude != null) {
      _markers.add(
        Marker(
          markerId: MarkerId(state.userData!.username.toString()),
          position: LatLng(state.userData!.latitude, state.userData!.longitude),
          icon: BitmapDescriptor.defaultMarkerWithHue(270),
          infoWindow: InfoWindow(
            title: state.userData?.username,
          ),
        ),
      );
    }
    setState(() {
      _markers = _markers;
    });
  }

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<AppState>();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text("Maps",style: kAppbarTitle,)),
        body: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: GoogleMap(
                onMapCreated: _onMapCreated,
                myLocationButtonEnabled: true,
                markers: _markers,
                initialCameraPosition: CameraPosition(
                    target: LatLng(appState.masterData?.latitude ?? -6.1990882,
                        appState.masterData?.longitude ?? 106.7462907),
                    zoom: 15.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
