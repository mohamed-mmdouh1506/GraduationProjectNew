import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text('SettingScreen',
            style: GoogleFonts.lato(
              color: Colors.red,
              fontSize: 20,
            )),
      ),
    );
  }
}
