import 'package:finbrain/themes/color_theme.dart';
import 'package:finbrain/ui/screen/onboarding_screen.dart';
import 'package:finbrain/ui/viewModel/text_theme_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future main() async {
  WidgetsBinding binding =  WidgetsFlutterBinding.ensureInitialized();

  final view = binding.platformDispatcher.views.first;
  final size = view.physicalSize / view.devicePixelRatio;
  final isPhone = size.shortestSide < 600;
  if(isPhone){
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown
    ]);
  } else {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

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
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: lightTheme.colorScheme.onTertiary
        )
      ),
      darkTheme: ThemeData(
        textTheme: textTheme,
        colorScheme: darkTheme.colorScheme,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: darkTheme.colorScheme.onTertiary
        )
      ),
      themeMode: ThemeMode.system,
      home: OnBoardingScreen(),
    );
  }
}
