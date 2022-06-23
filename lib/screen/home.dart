import 'dart:convert';

import 'package:attendance_app/component/master_info.dart';
import 'package:attendance_app/component/user_info.dart';
import 'package:attendance_app/screen/master_config.dart';
import 'package:attendance_app/screen/my_maps.dart';
import 'package:attendance_app/utils/appstate.dart';
import 'package:attendance_app/utils/konstanta.dart';
import 'package:attendance_app/utils/model.dart';
import 'package:attendance_app/utils/palette.dart';
import 'package:flutter/material.dart';
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
    final userLoc = pref.getString('userLoc');

    if (savedLoc != null) {
      MasterData savedData = MasterData.fromJson(jsonDecode(savedLoc));
      if (savedData.latitude != null && savedData.longitude != null) {
        state.setMasterLoc(LatLng(savedData.latitude!, savedData.longitude!));
        state.serMasterData(savedData);
      }
    }
    if (userLoc != null) {
      final user = UserData.fromJson(jsonDecode(userLoc));
      state.setUserDataLoc(user);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.kToDark.shade800,
      appBar: AppBar(
          title: const Text(
        'Attendance ',
        style: kAppbarTitle,
      )),
      body: ListView(
          // mainAxisSize: MainAxisSize.max,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MasterInfo(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const MasterLocSet()));
              },
            ),
            Container(
              color: Palette.kToDark.shade900,
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              margin: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'View on maps',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                  ),
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => const MyMaps()));
                      },
                      icon:  Icon(
                        Icons.pin_drop,
                        color: Palette.ok,
                      )),
                ],
              ),
            ),
            const UserInfo(),
          ]),
    );
  }
}
