import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';

Future<Position?> getCurrentDeviceLoc() async {
  try {
    printLog("[Request read location device...]");
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      return Future.error('Location services are disabled');
    }
    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        return Future.error('Location permission are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permission are permanently denied, we cannot request permission');
    }

    return await Geolocator.getCurrentPosition();
  } catch (e) {
    printLog('error get location $e');
    return null;
  }
}

void printLog(dynamic data) {
  if (kDebugMode) {
    print('[Debug] $data');
  }
}
