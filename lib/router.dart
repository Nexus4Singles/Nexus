import 'package:get/get.dart';
import 'package:nexus/features/auth/views/auth_handler.dart';
import 'package:nexus/features/auth/views/login.dart';
import 'package:nexus/features/auth/views/onboarding.dart';
import 'package:nexus/features/auth/views/onboarding_handler.dart';
import 'package:nexus/features/auth/views/splash.dart';
import 'package:nexus/screens/notificatin_screen/notification.dart';
import 'package:nexus/screens/registration_screen/congratulations.dart';
import 'package:nexus/screens/registration_screen/create_account.dart';
import 'package:nexus/screens/registration_screen/existing_user.dart';
import 'package:nexus/screens/registration_screen/forgotten_password.dart';
import 'package:nexus/screens/registration_screen/verify_account.dart';
import 'package:nexus/screens/userprofile_and_settings/about.dart';
import 'package:nexus/screens/userprofile_and_settings/addcard.dart';
import 'package:nexus/screens/userprofile_and_settings/cancel_plan.dart';
import 'package:nexus/screens/userprofile_and_settings/change_password.dart';
import 'package:nexus/screens/userprofile_and_settings/delete_account.dart';
import 'package:nexus/screens/userprofile_and_settings/edit_profile.dart';
import 'package:nexus/screens/userprofile_and_settings/login_modal_sheet.dart';
import 'package:nexus/screens/userprofile_and_settings/payment.dart';
import 'package:nexus/screens/userprofile_and_settings/payment_success.dart';
import 'package:nexus/screens/userprofile_and_settings/privacy.dart';
import 'package:nexus/screens/userprofile_and_settings/profile.dart';
import 'package:nexus/screens/userprofile_and_settings/review.dart';
import 'package:nexus/screens/userprofile_and_settings/settings.dart';
import 'package:nexus/screens/userprofile_and_settings/subscription.dart';
import 'package:nexus/screens/userprofile_and_settings/subscription3.dart';
import 'package:nexus/screens/userprofile_and_settings/subscription4.dart';
import 'package:nexus/screens/userprofile_and_settings/terms.dart';
import 'package:nexus/screens/userprofile_and_settings/verify_acc.dart';

class AppRoutes {
  static String splash = '/';
  static String authHandler = '/auth_handler';
  static String onboardingHandler = '/onboarding_handler';
  static String onboarding = '/onboarding';
  static String welcome = '/welcome';
  static String login = '/login';
  static String signUp = '/sign_up';
  static String existingUser = '/existinguserscreen';
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
  GetPage(
    name: AppRoutes.existingUser,
    page: () => const ExistingUserScreen(),
    binding: BindingsBuilder(() {}),
  ),
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
];
