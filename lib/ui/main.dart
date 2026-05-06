import 'package:finbrain/ui/screen/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(
    MaterialApp(
      title: "FinBrain",
      theme: ThemeData(
        textTheme: GoogleFonts.notoSansKrTextTheme(),
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent
      ),
      home: MainScreen()
    )
  );
}