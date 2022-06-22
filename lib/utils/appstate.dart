import 'package:attendance_app/utils/model.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AppState extends ChangeNotifier {
  LatLng _masterloc = const LatLng(-6.1990882, 106.7462907);
  UserData? _userData;
  MasterData? _masterData;

  UserData? get userData => _userData;
  MasterData? get masterData => _masterData;
  LatLng get masterLoc => _masterloc;

  void setUserDataLoc(UserData newdataUser) {
    _userData = newdataUser;
    notifyListeners();
  }

  void serMasterData(MasterData master) {
    _masterData = master;
    notifyListeners();
  }

  void setMasterLoc(LatLng newLoc) {
    _masterloc = newLoc;
    notifyListeners();
  }


  void updateMasterloc() {
    _masterloc = _masterloc;

    notifyListeners();
  }
}
