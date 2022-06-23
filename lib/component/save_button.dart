import 'package:attendance_app/utils/palette.dart';
import 'package:flutter/material.dart';

class ButtonSave extends StatelessWidget {
  VoidCallback onTap;
  String title;
  ButtonSave({Key? key, required this.onTap, this.title = "SAVE"})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      width: double.infinity,
      child: ElevatedButton(
        style: ButtonStyle(
          padding:
              MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(15)),
          backgroundColor:
              MaterialStateProperty.all<Color>(Palette.primary),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50.0),
          )),
        ),
        onPressed: onTap,
        child: const Text(
          'SAVE',
          style: TextStyle(
            color: Colors.white,
            letterSpacing: 1.5,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
