import 'package:finbrain/ui/screen/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(
    ProviderScope(
      child: MaterialApp(
        title: "FinBrain",
        theme: ThemeData(
          textTheme: GoogleFonts.notoSansKrTextTheme(),
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent
        ),
        home: const MainScreen()
      ),
    )
  );
}