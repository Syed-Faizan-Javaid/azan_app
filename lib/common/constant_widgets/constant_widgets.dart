import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Container buildContainer(String text, String time) {
  return Container(
    padding: const EdgeInsets.fromLTRB(19, 6.5, 19, 8.5),
    margin: const EdgeInsets.all(10),
    width: 120,
    height: 80,
    decoration: BoxDecoration(
      color: const Color(0xfffcffff),
      borderRadius: BorderRadius.circular(10),
      boxShadow: const [
        BoxShadow(
          color: Color(0x11000000),
          offset: Offset(0, 5),
          blurRadius: 5,
        ),
      ],
    ),
    child: SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            // sunriseU7M (1:274)
            margin: const EdgeInsets.fromLTRB(0, 0, 0, 8),
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w400,
                height: 1.5,
                color: const Color(0xff1da599),
              ),
            ),
          ),
          Text(
            // amPVD (1:275)
            time,
            style: GoogleFonts.inter(
              fontSize: 18,
              fontWeight: FontWeight.w400,
              height: 1.2125,
              letterSpacing: 0.44,
              color: const Color(0xff404040),
            ),
          ),
        ],
      ),
    ),
  );
}
