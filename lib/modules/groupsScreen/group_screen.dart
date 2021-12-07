import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GroupScreen extends StatelessWidget {
  const GroupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text('GroupScreen',
            style: GoogleFonts.lato(
              color: Colors.red,
              fontSize: 20,
            )),
      ),
    );
  }
}
