import 'package:finbrain/themes/color_theme.dart';
import 'package:finbrain/ui/screen/main_screen.dart';
import 'package:finbrain/ui/screen/onboarding_screen.dart';
import 'package:finbrain/ui/viewModel/text_theme_viewmodel.dart';
import 'package:finbrain/ui/widget/custom_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future main() async {
  WidgetsBinding binding =  WidgetsFlutterBinding.ensureInitialized();

  // 기기에 따라 방향 설정
  // Set orientation by device
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

  // API 키 로드
  // Load api key
  await dotenv.load(fileName: "assets/keys.env");

  // Firestore 초기화
  // Initialize firestore
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  
  runApp(const ProviderScope(child: FinBrain()));
}

class FinBrain extends ConsumerWidget {
  const FinBrain({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 텍스트 테마 관찰해 동적으로 적용
    // Watch text theme and apply it dynamically
    final textTheme = ref.watch(textThemeViewmodelProvider);

    return MaterialApp(
      title: "FinBrain",
      debugShowCheckedModeBanner: false,
      key: ValueKey(textTheme),
      // 라이트 모드(light mode)
      theme: ThemeData(
        textTheme: textTheme,
        colorScheme: lightTheme.colorScheme,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: lightTheme.colorScheme.onTertiary
        )
      ),
      // 다크 모드(dark mode)
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
      // Firebase 로그인 상태 스트림을 구독해 이에 따라 화면 이동
      // Subscribe Firebase auth state to navigate screen
      home: StreamBuilder<String?>(
        stream: FirebaseAuth.instance.authStateChanges().map((user) => user?.uid).distinct(),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting){
            return CustomProgressIndicator();
          }
          if(snapshot.hasData && snapshot.data != null) {
            return const MainScreen();
          }
          return OnBoardingScreen();
        }
      ),
    );
  }
}
