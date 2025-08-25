import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:youturn/features/chatbot/screen/chatbot_screen.dart';
import 'package:youturn/features/consulting/screen/consulting_seconds_screen.dart';

import 'features/auth/screen/login_screen.dart';
import 'features/auth/screen/signup_screen.dart';
import 'features/consulting/consulting_data.dart';
import 'features/consulting/screen/consulting_result_screen.dart';
import 'features/consulting/screen/consulting_screen.dart';
import 'features/consulting/screen/consulting_third_screen.dart';
import 'features/screens/home_screen.dart';
import 'features/screens/main_screen.dart';

final GoRouter _router = GoRouter(
  initialLocation: '/login',
  routes: [
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/signup',
      builder: (context, state) => const SignupScreen(),
    ),
    GoRoute(
      path: '/main',
      builder: (context, state) => const MainScreen(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/chatbot',
      builder: (context, state) => const ChatbotScreen(),
    ),
    GoRoute(
      path: '/consulting',
      builder: (context, state) => const ConsultingScreen(),
    ),
    GoRoute(
      path: '/consulting_seconds',
      builder: (context, state) {
        final consultingData = state.extra as ConsultingData;
        return ConsultingSecondScreen(consultingData: consultingData);
      },
    ),
    GoRoute(
      path: '/consulting_third',
      name: 'consulting_third',
      builder: (context, state) {
        final consultingData = state.extra as ConsultingData;
        return ConsultingThirdScreen(consultingData: consultingData);
      },
    ),
    GoRoute(
      path: '/consulting_result',
      builder: (context, state) {
        final resultText = state.extra as String;
        return ConsultingResultScreen(resultText: resultText);
      },
    ),
  ],
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      debugShowCheckedModeBanner: false,
    );
  }
}
