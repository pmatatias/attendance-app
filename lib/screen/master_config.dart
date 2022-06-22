import 'dart:async';
import 'dart:convert';
import 'package:attendance_app/utils/appstate.dart';
import 'package:attendance_app/utils/model.dart';
import 'package:attendance_app/utils/my_function.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MasterLocSet extends StatefulWidget {
  const MasterLocSet({Key? key, this.iniLoc}) : super(key: key);
  final LatLng? iniLoc;

  @override
  State<MasterLocSet> createState() => _MasterLocSetState();
}

class _MasterLocSetState extends State<MasterLocSet> {
  final Completer<GoogleMapController> _controller = Completer();
  Set<Marker> _marker = {};
  LatLng? _latLng;

  @override
  void initState() {
    init();
    super.initState();
  }

  void init() async {
    final state = context.read<AppState>();
    await Future.delayed(const Duration(milliseconds: 50));
    AwesomeDialog(
            context: context,
            dialogType: DialogType.INFO,
            animType: AnimType.SCALE,
            desc:
                'Tap anywhere on the map to add new location, and dont forget to save',
            btnOkOnPress: () {})
        .show();


    if (state.masterData?.latitude != null &&
        state.masterData?.longitude != null) {
      _marker.add(
        Marker(
          markerId: const MarkerId('Master_loc'),
          position:
              LatLng(state.masterData!.latitude!, state.masterData!.longitude!),
          infoWindow: InfoWindow(title: "${state.masterData?.name}"),
        ),
      );
    }
    setState(() {
      _marker = _marker;
    });

  }

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  Future<void> onSave(AppState appState) async {
    if (_latLng != null) {
      final pref = await SharedPreferences.getInstance();
      pref.remove('masterlocation');
      Map<String, dynamic> masterSavedLocation = {
        'name': "Headquarter",
        'latitude': _latLng!.latitude,
        'longitude': _latLng!.longitude,
      };
      final jsonn = json.encode(masterSavedLocation);
      pref.setString("masterlocation", jsonn);

      MasterData data = MasterData.fromJson(jsonDecode(jsonn));

      appState.serMasterData(data);

      AwesomeDialog(
        context: context,
        dialogType: DialogType.SUCCES,
        animType: AnimType.SCALE,
        title: 'Success',
        desc:
            'Master location Updated to : ( ${appState.masterData?.latitude} , ${appState.masterData?.longitude} )  ',
        btnOkOnPress: () {},
      ).show();
    } else {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.ERROR,
        animType: AnimType.SCALE,
        desc: 'New master location not found! ',
        btnCancelOnPress: () {},
      ).show();
    }
  }

  void onTap(LatLng pos) {
    _marker = {};
    _marker.add(
      Marker(
          markerId: const MarkerId('Master_loc'),
          position: pos,
          infoWindow: const InfoWindow(title: "New Location")),
    );

    setState(() {
      _latLng = pos;
    });
  }

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<AppState>();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Set Master loc"),
          actions: [
            TextButton(
              onPressed: () {
                onSave(appState);
              },
              child: const Text(
                "Save",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        body: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: GoogleMap(
                onMapCreated: _onMapCreated,
                markers: _marker,
                onTap: onTap,
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
