import 'package:get/get.dart';
import 'package:nexus/features/auth/presentation/views/auth_handler.dart';
import 'package:nexus/features/auth/presentation/views/login.dart';
import 'package:nexus/features/auth/presentation/views/onboarding.dart';
import 'package:nexus/features/auth/presentation/views/onboarding_handler.dart';
import 'package:nexus/features/auth/presentation/views/splash.dart';
import 'package:nexus/features/home/presentation/views/nav.dart';
import 'package:nexus/features/notifications/presentation/views/notification.dart';
import 'package:nexus/features/auth/presentation/views/congratulations.dart';
import 'package:nexus/features/auth/presentation/views/create_account.dart';
// import 'package:nexus/features/auth/presentation/views/login.dart';
import 'package:nexus/features/auth/presentation/views/forgotten_password.dart';
import 'package:nexus/features/auth/presentation/views/verify_account.dart';
import 'package:nexus/features/profile/presentation/views/about.dart';
import 'package:nexus/features/profile/presentation/views/add_card.dart';
import 'package:nexus/features/profile/presentation/views/cancel_plan.dart';
import 'package:nexus/features/profile/presentation/views/change_password.dart';
import 'package:nexus/features/profile/presentation/views/delete_account.dart';
import 'package:nexus/features/profile/presentation/views/edit_profile.dart';
import 'package:nexus/features/profile/presentation/widgets/login_modal_sheet.dart';
import 'package:nexus/features/profile/presentation/views/payment.dart';
import 'package:nexus/features/profile/presentation/views/payment_success.dart';
import 'package:nexus/features/profile/presentation/views/privacy.dart';
import 'package:nexus/features/profile/presentation/views/profile.dart';
import 'package:nexus/features/profile/presentation/views/review.dart';
import 'package:nexus/features/profile/presentation/views/settings.dart';
import 'package:nexus/features/profile/presentation/views/subscription.dart';
import 'package:nexus/screens/userprofile_and_settings/subscription3.dart';
import 'package:nexus/screens/userprofile_and_settings/subscription4.dart';
import 'package:nexus/features/profile/presentation/views/terms.dart';
import 'package:nexus/features/profile/presentation/views/verify_acc.dart';

class AppRoutes {
  static String splash = '/';
  static String authHandler = '/auth_handler';
  static String onboardingHandler = '/onboarding_handler';
  static String onboarding = '/onboarding';
  static String welcome = '/welcome';
  static String login = '/login';
  static String signUp = '/sign_up';
  // static String existingUser = '/existinguserscreen';
  static String createAccount = '/createaccountscreen';
  static String verifyAccount = '/verifyaccountscreen';
  static String congratulations = '/congratulationscreen';
  static String forgottenPassword = '/forgottenpasswordscreen';
  static String settings = '/settingscreen';
  static String subscription = '/subscriptionscreen';
  static String payment = '/paymentmethodscreen';
  static String addcard = '/addcardscreen';
  static String review = '/reviewsummaryscreen';
  static String paymentSuccess = '/paymentsuccessscreen';
  static String cancelPlan = '/changeplanscreen';
  static String subscription3 = '/cancelsubscreen';
  static String subscription4 = '/subcancelledscreen';
  static String loginModaalSheet = '/loginmodalshheet';
  static String about = '/aboutnexusscreen';
  static String terms = '/termsscreen';
  static String privacy = '/privacypolicyscreen';
  static String deleteAccount = '/deleteaccountscreen';
  static String changePassword = '/changepasswordscreen';
  static String verifyAcc = '/verifyaccscreen';
  static String editProfile = '/editprofile';
  static String notification = '/notificationscreen';
  static String profile = '/profilescreen';
  static String mainNav = '/main_nav';
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
  // GetPage(
  //   name: AppRoutes.login,
  //   page: () => const LoginScreen(),
  //   binding: BindingsBuilder(() {}),
  // ),
  GetPage(
    name: AppRoutes.createAccount,
    page: () => const CreateAccountScreen(),
    binding: BindingsBuilder(() {}),
  ),
  GetPage(
    name: AppRoutes.verifyAccount,
    page: () => const VerifyAccountScreen(),
    binding: BindingsBuilder(() {}),
  ),
  GetPage(
    name: AppRoutes.congratulations,
    page: () => const CongratulationScreen(),
    binding: BindingsBuilder(() {}),
  ),
  GetPage(
    name: AppRoutes.forgottenPassword,
    page: () => const ForgottenPasswordScreen(),
    binding: BindingsBuilder(() {}),
  ),
  GetPage(
    name: AppRoutes.settings,
    page: () => const SettingScreen(),
    binding: BindingsBuilder(() {}),
  ),
  GetPage(
    name: AppRoutes.subscription,
    page: () => const SubsciptionScreen(),
    binding: BindingsBuilder(() {}),
  ),
  GetPage(
    name: AppRoutes.payment,
    page: () => const PaymentMethodScreen(),
    binding: BindingsBuilder(() {}),
  ),
  GetPage(
    name: AppRoutes.addcard,
    page: () => const AddCardScreen(),
    binding: BindingsBuilder(() {}),
  ),
  GetPage(
    name: AppRoutes.review,
    page: () => const ReviewSummaryScreen(),
    binding: BindingsBuilder(() {}),
  ),
  GetPage(
    name: AppRoutes.paymentSuccess,
    page: () => const PaymentSuccessScreen(),
    binding: BindingsBuilder(() {}),
  ),
  GetPage(
    name: AppRoutes.cancelPlan,
    page: () => const ChangePlanScreen(),
    binding: BindingsBuilder(() {}),
  ),
  GetPage(
    name: AppRoutes.subscription3,
    page: () => const CancelSubScreen(),
    binding: BindingsBuilder(() {}),
  ),
  GetPage(
    name: AppRoutes.subscription4,
    page: () => const SubCancelledScreen(),
    binding: BindingsBuilder(() {}),
  ),
  GetPage(
    name: AppRoutes.loginModaalSheet,
    page: () => const LoginModalSheet(),
    binding: BindingsBuilder(() {}),
  ),
  GetPage(
    name: AppRoutes.about,
    page: () => const AboutNexusScreen(),
    binding: BindingsBuilder(() {}),
  ),
  GetPage(
    name: AppRoutes.terms,
    page: () => const TermsScreen(),
    binding: BindingsBuilder(() {}),
  ),
  GetPage(
    name: AppRoutes.privacy,
    page: () => const PrivacyPolicyScreen(),
    binding: BindingsBuilder(() {}),
  ),
  GetPage(
    name: AppRoutes.deleteAccount,
    page: () => const DeleteAccountScreen(),
    binding: BindingsBuilder(() {}),
  ),
  GetPage(
    name: AppRoutes.changePassword,
    page: () => const ChangePasswordScreen(),
    binding: BindingsBuilder(() {}),
  ),
  GetPage(
    name: AppRoutes.verifyAcc,
    page: () => const VerifyAccScreen(),
    binding: BindingsBuilder(() {}),
  ),
  GetPage(
    name: AppRoutes.editProfile,
    page: () => const EditProfile(),
    binding: BindingsBuilder(() {}),
  ),
  GetPage(
    name: AppRoutes.notification,
    page: () => const NotificationScreen(),
    binding: BindingsBuilder(() {}),
  ),
  GetPage(
    name: AppRoutes.profile,
    page: () => const ProfileScreen(),
    binding: BindingsBuilder(() {}),
  ),
  GetPage(
    name: AppRoutes.mainNav,
    page: () => const MainNav(),
    binding: BindingsBuilder(() {}),
  ),
];
