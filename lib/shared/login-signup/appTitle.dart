import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget appTitle() {
  return RichText(
    textAlign: TextAlign.center,
    text: TextSpan(
        text: 'B',
        style: GoogleFonts.portLligatSans(
          fontSize: 30,
          fontWeight: FontWeight.w700,
          color: Color(0xffe46b10),
        ),
        children: [
          TextSpan(
            text: 'aazar',
            style: TextStyle(color: Colors.black, fontSize: 30),
          ),
          TextSpan(
            text: 'V',
            style: TextStyle(color: Color(0xffe46b10), fontSize: 30),
          ),
          TextSpan(
            text: 'ihar',
            style: TextStyle(color: Colors.black, fontSize: 30),
          ),
        ]),
  );
}
