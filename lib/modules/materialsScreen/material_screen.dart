import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MaterialScreen extends StatelessWidget {
  const MaterialScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text('MaterialScreen',
            style: GoogleFonts.lato(
              color: Colors.red,
              fontSize: 20,
            )),
      ),
    );
  }
}
