import 'dart:convert';

import 'package:attendance_app/screen/master_config.dart';
import 'package:attendance_app/screen/my_maps.dart';
import 'package:attendance_app/utils/appstate.dart';
import 'package:attendance_app/utils/model.dart';
import 'package:attendance_app/utils/my_function.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    initFunction();
    super.initState();
  }

  void initFunction() async {
    final state = context.read<AppState>();
    final pref = await SharedPreferences.getInstance();

    final savedLoc = pref.getString('masterlocation');
    printLog(savedLoc);
    if (savedLoc != null) {
      MasterData savedData = MasterData.fromJson(jsonDecode(savedLoc));
      if (savedData.latitude != null && savedData.longitude != null) {
        state.setMasterLoc(LatLng(savedData.latitude!, savedData.longitude!));
        state.serMasterData(savedData);
      }
    }
  }

  void checkInAttendance(AppState state) async {
    Position? myLoc = await getCurrentDeviceLoc();
    printLog(state.masterData);
    printLog(state.masterData?.latitude);
    if (myLoc != null && state.masterData?.latitude != null) {
      double distance = Geolocator.distanceBetween(state.masterData!.latitude!,
          state.masterData!.longitude!, myLoc.latitude, myLoc.longitude);
      bool isattend = distance <= 50;
      Map<String, dynamic> latestuserLoc = {
        "username": "Potatoo",
        "latitude": myLoc.latitude,
        "longitude": myLoc.longitude,
        "distance": distance,
        "timestamps": myLoc.timestamp?.toIso8601String(),
        "isAttend": isattend,
      };
      final jsonData = json.encode(latestuserLoc);
      final pref = await SharedPreferences.getInstance();
      // save latest data to local storage
      pref.setString('userLoc', jsonData);

      UserData usrData = UserData.fromJson(jsonDecode(jsonData));
      state.setUserDataLoc(usrData);
      if (isattend) {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.SUCCES,
          animType: AnimType.SCALE,
          title: 'Success',
          desc: 'Update Master location : ',
          btnOkOnPress: () {},
        ).show();
      } else {
        AwesomeDialog(
                context: context,
                dialogType: DialogType.ERROR,
                animType: AnimType.SCALE,
                title: 'You are out of range',
                desc:
                    'You are around ${distance.round()} meters from checkin location!',
                btnCancelOnPress: () {},
                btnCancelText: "OK")
            .show();
      }
    } else {
      AwesomeDialog(
          context: context,
          dialogType: DialogType.INFO,
          animType: AnimType.SCALE,
          desc: 'Master Location is null, please Set New Master Location first',
          btnCancelOnPress: () {},
          btnOkText: "Set",
          btnOkOnPress: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const MasterLocSet()));
          }).show();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Attendance ')),
      body: Container(
        alignment: Alignment.center,
        child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const MyMaps()));
                },
                child: const Text('Maps'),
              ),
              Consumer<AppState>(builder: (context, state, child) {
                return ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const MasterLocSet()));
                  },
                  child: const Text('Set master location'),
                );
              }),
              Consumer<AppState>(builder: (context, state, child) {
                return ElevatedButton(
                  onPressed: () {
                    checkInAttendance(state);
                  },
                  child: const Text('Checkin attendance'),
                );
              }),
            ]),
      ),
    );
  }
}
