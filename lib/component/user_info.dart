import 'dart:convert';

import 'package:attendance_app/component/info_tile.dart';
import 'package:attendance_app/screen/master_config.dart';
import 'package:attendance_app/utils/appstate.dart';
import 'package:attendance_app/utils/model.dart';
import 'package:attendance_app/utils/my_function.dart';
import 'package:attendance_app/utils/palette.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserInfo extends StatefulWidget {
  const UserInfo({Key? key, this.onTap}) : super(key: key);
  final VoidCallback? onTap;

  @override
  State<UserInfo> createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
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
      Navigator.pop(context);
      if (isattend) {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.SUCCES,
          animType: AnimType.SCALE,
          title: 'Success',
          desc: 'Checkin success! You are around ${distance.round()} meters',
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
      Navigator.pop(context);
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
    var state = context.watch<AppState>();
    return Container(
      decoration: BoxDecoration(color: Palette.kToDark.shade800),
      width: double.infinity,
      child: Stack(children: [
        Container(
          decoration: BoxDecoration(
            // color: cCall,
            borderRadius: BorderRadius.circular(8),
            image: DecorationImage(
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.07), BlendMode.dstATop),
              image: Image(
                image: state.userData?.isAttend == true
                    ? const AssetImage('assets/location.png')
                    : const AssetImage('assets/location2.png'),
              ).image,
            ),
            // width: 80,
          ),
          alignment: Alignment.center,
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "User Information",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: () {
                      showLoaderDialogLoading(context);
                      checkInAttendance(state);
                    },
                    child: const Text("Check in Attendance")),
                const SizedBox(
                  height: 10,
                ),
                const Text("Latest updated user position"),
                const SizedBox(
                  height: 10,
                ),
                InfoTile(
                  param: "Name",
                  value: state.userData?.username ?? '-',
                  icon: Icons.business,
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      child: InfoTile(
                        param: "Latitude",
                        value: state.userData?.latitude ?? '-',
                        icon: Icons.swap_horizontal_circle_outlined,
                      ),
                    ),
                    Expanded(
                      child: InfoTile(
                        param: "Distance",
                        value:
                            '${state.userData?.distance?.round() ?? '-'} meters',
                        icon: Icons.ads_click_outlined,
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      child: InfoTile(
                        param: "Longitude",
                        value: state.userData?.longitude ?? '-',
                        icon: Icons.swap_vertical_circle_outlined,
                      ),
                    ),
                    Expanded(
                      child: InfoTile(
                        param: "Attended",
                        value: state.userData?.isAttend == true ? 'Yes' : 'No',
                        icon: state.userData?.isAttend == true
                            ? Icons.check
                            : Icons.close,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                    child: Text(
                  state.userData?.timestamps ?? '-',
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ))
              ]),
        ),
      ]),
    );
  }
}
