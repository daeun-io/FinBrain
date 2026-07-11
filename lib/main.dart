import 'package:finbrain/themes/color_theme.dart';
import 'package:finbrain/ui/screen/onboarding_screen.dart';
import 'package:finbrain/ui/viewModel/text_theme_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: "assets/keys.env");
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const ProviderScope(child: FinBrain()));
}

class FinBrain extends ConsumerWidget {
  const FinBrain({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = ref.watch(textThemeViewmodelProvider);

    return MaterialApp(
      title: "FinBrain",
      theme: ThemeData(
        textTheme: textTheme,
        colorScheme: lightTheme.colorScheme,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      darkTheme: ThemeData(
        textTheme: textTheme,
        colorScheme: darkTheme.colorScheme,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      themeMode: ThemeMode.system,
      home: OnBoardingScreen(),
    );
  }
}
