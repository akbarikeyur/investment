import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles {
  static TextStyle regular({double size = 16, Color color = Colors.black}) {
    return GoogleFonts.onest(
      fontSize: size,
      fontWeight: FontWeight.normal,
      color: color,
    );
  }

  static TextStyle medium({double size = 16, Color color = Colors.black}) {
    return GoogleFonts.onest(
      fontSize: size,
      fontWeight: FontWeight.w500,
      color: color,
    );
  }

  static TextStyle bold({double size = 16, Color color = Colors.black}) {
    return GoogleFonts.onest(
      fontSize: size,
      fontWeight: FontWeight.bold,
      color: color,
    );
  }

  static TextStyle light({double size = 16, Color color = Colors.black}) {
    return GoogleFonts.onest(
      fontSize: size,
      fontWeight: FontWeight.w300,
      color: color,
    );
  }
}
