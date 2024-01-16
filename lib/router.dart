import 'package:get/get.dart';
import 'package:nexus/features/auth/views/auth_handler.dart';
import 'package:nexus/features/auth/views/login.dart';
import 'package:nexus/features/auth/views/onboarding.dart';
import 'package:nexus/features/auth/views/onboarding_handler.dart';
import 'package:nexus/features/auth/views/splash.dart';

class AppRoutes {
  static String splash = '/';
  static String authHandler = '/auth_handler';
  static String onboardingHandler = '/onboarding_handler';
  static String onboarding = '/onboarding';
  static String welcome = '/welcome';
  static String login = '/login';
  static String signUp = '/sign_up';
}

final appRouter = [
  GetPage(
    name: AppRoutes.splash,
    page: () => const SplashScreen(),
  ),
  GetPage(
    name: AppRoutes.authHandler,
    page: () => const AuthHandler(),
    binding: BindingsBuilder(() {}),
  ),
  GetPage(
    name: AppRoutes.onboardingHandler,
    page: () => const OnboardingHandler(),
    binding: BindingsBuilder(() {}),
  ),
  GetPage(
    name: AppRoutes.onboarding,
    page: () => const OnboardingScreen(),
    binding: BindingsBuilder(() {}),
  ),
  GetPage(
    name: AppRoutes.login,
    page: () => const LoginScreen(),
    binding: BindingsBuilder(() {}),
  ),
];
