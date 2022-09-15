import 'package:attendance_app/component/info_tile.dart';
import 'package:attendance_app/utils/appstate.dart';
import 'package:attendance_app/utils/palette.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MasterInfo extends StatelessWidget {
  const MasterInfo({Key? key, this.onTap}) : super(key: key);
  final VoidCallback? onTap;

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
            // image: DecorationImage(
            //   fit: BoxFit.cover,
            //   colorFilter: ColorFilter.mode(
            //       Colors.black.withOpacity(0.07), BlendMode.dstATop),
            //   image: const Image(
            //     image: AssetImage('assets/building.png'),
            //   ).image,
            // ),
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
                  "Master Information",
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
                    if (onTap != null) {
                      onTap!();
                    }
                  },
                  child: state.masterData?.latitude != null
                      ? const Text("Update master location")
                      : const Text('Set new master location'),
                ),
                const SizedBox(
                  height: 20,
                ),
                InfoTile(
                  param: "Name",
                  value: state.masterData?.name ?? '-',
                  icon: Icons.business,
                ),
                const SizedBox(
                  height: 10,
                ),
                InfoTile(
                  param: "Latitude",
                  value: state.masterData?.latitude ?? '-',
                  icon: Icons.swap_horizontal_circle_outlined,
                ),
                const SizedBox(
                  height: 10,
                ),
                InfoTile(
                  param: "Longitude",
                  value: state.masterData?.longitude ?? '-',
                  icon: Icons.swap_vertical_circle_outlined,
                ),
              ]),
        ),
      ]),
    );
  }
}
