import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:youturn/features/chatbot/screen/chatbot_screen.dart';
import 'package:youturn/features/consulting/screen/consulting_seconds_screen.dart';

import 'features/auth/screen/login_screen.dart';
import 'features/auth/screen/signup_screen.dart';
import 'features/consulting/consulting_data.dart';
import 'features/consulting/screen/consulting_third_screen.dart';
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
      path: '/chatbot',
      builder: (context, state) => const ChatbotScreen(),
    ),
    GoRoute(
      path: '/consulting_seconds',
      builder: (context, state) {
        final consultingData = state.extra as Map<String, dynamic>;
        return ConsultingSecondScreen(consultingData: consultingData);
      },
    ),
    GoRoute(
      path: '/consulting_third',
      name: 'consulting_third',
      builder: (context, state) {
        final consultingDataMap = state.extra! as Map<String, dynamic>;
        final consultingData = ConsultingData.fromJson(consultingDataMap); // 🔥 여기서 변환
        return ConsultingThirdScreen(consultingData: consultingData);
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
