import 'package:attendance_app/screen/home.dart';
import 'package:attendance_app/utils/appstate.dart';
import 'package:attendance_app/utils/palette.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
        create: (context) => AppState(), child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Palette.primary,
        errorColor: Palette.danger,
        primarySwatch: Palette.kToDark,
      ),
      home: const Home(),
    );
  }
}
