import 'package:attendance_app/utils/palette.dart';
import 'package:flutter/material.dart';

class InfoTile extends StatelessWidget {
  InfoTile({
    Key? key,
    this.icon = Icons.radar,
    this.param = '',
    this.value,
  }) : super(key: key);

  final IconData icon;
  final String param;
  dynamic value;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Palette.kToDark.shade100,
            ),
            child: Icon(
              icon,
              
              color: Palette.secondary,
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value.toString(),
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
              Text(
                param,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                ),
              ),
            ],
          ))
        ],
      ),
    );
  }
}
