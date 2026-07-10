import 'package:finbrain/themes/color_theme.dart';
import 'package:finbrain/ui/screen/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: "assets/keys.env");
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const FinBrain());
}

class FinBrain extends StatelessWidget {
  const FinBrain({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        title: "FinBrain",
        theme: ThemeData(
          textTheme: GoogleFonts.notoSansKrTextTheme(),
          colorScheme: lightTheme.colorScheme,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        darkTheme: ThemeData(
          textTheme: GoogleFonts.notoSansKrTextTheme(),
          colorScheme: darkTheme.colorScheme,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        themeMode: ThemeMode.system,
        home: OnBoardingScreen(),
      ),
    );
  }
}
