import 'package:get/get.dart';
import 'package:nexus/features/chat/views/chat_with.dart';
import 'package:nexus/features/chat/views/chats.dart';
import 'package:nexus/features/auth/presentation/views/auth_handler.dart';
import 'package:nexus/features/auth/presentation/views/login.dart';
import 'package:nexus/features/auth/presentation/views/onboarding.dart';
import 'package:nexus/features/auth/presentation/views/onboarding_handler.dart';
import 'package:nexus/features/auth/presentation/views/setting_up/audio1.dart';
import 'package:nexus/features/auth/presentation/views/setting_up/audio2.dart';
import 'package:nexus/features/auth/presentation/views/setting_up/audio3.dart';
import 'package:nexus/features/auth/presentation/views/setting_up/audio_recoding_completed.dart';
import 'package:nexus/features/auth/presentation/views/splash.dart';
import 'package:nexus/features/home/presentation/views/nav.dart';
// import 'package:nexus/features/home/presentation/views/photo_view.dart';
import 'package:nexus/features/home/presentation/views/user_details.dart';
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
import 'package:nexus/features/profile/presentation/views/compatibilty_quiz.dart';
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
import 'package:nexus/features/settings/presentation/views/subscription3.dart';
import 'package:nexus/features/settings/presentation/views/subscription4.dart';
import 'package:nexus/features/profile/presentation/views/terms.dart';
import 'package:nexus/features/profile/presentation/views/verify_acc.dart';
import 'package:nexus/features/auth/presentation/views/setting_up/age.dart';
import 'package:nexus/features/auth/presentation/views/setting_up/audio_recording.dart';

import 'package:nexus/features/auth/presentation/views/setting_up/desired_quality.dart';
import 'package:nexus/features/auth/presentation/views/setting_up/extra_info.dart';
import 'package:nexus/features/auth/presentation/views/setting_up/gender.dart';
import 'package:nexus/features/auth/presentation/views/setting_up/hobbies.dart';
import 'package:nexus/features/auth/presentation/views/setting_up/profile_completed.dart';
import 'package:nexus/features/auth/presentation/views/setting_up/upload_photo.dart';

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
  static String gender = '/genderscreen';
  static String extraInfo = '/extrainformationscreen';
  static String hobbies = '/hobbiesscreen';
  static String desiredQuality = '/desiredqualityscreen';
  static String uploadPhoto = '/uploadphotoscreen';
  static String audioRecording = '/audiorecordingscreen';
  static String audio1 = '/audio1screen';
  static String audio2 = '/audio2screen';
  static String audio3 = '/audio3screen';
  static String audio4 = '/audio4screen';
  static String regSuccessful = '/regsuccessful';
  static String chats = '/chatsscreen';
  static String chatWith = '/chatwithscreen';
  static String age = '/age';
  static String compatibilityQuiz = '/compatibility_quiz';
  static String userDetails = '/user_details';
  static String photoViews = '/photo_views';
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
  GetPage(
    name: AppRoutes.gender,
    page: () => const GenderScreen(),
    binding: BindingsBuilder(() {}),
  ),
  GetPage(
    name: AppRoutes.age,
    page: () => const AgeScreen(),
    binding: BindingsBuilder(() {}),
  ),
  GetPage(
    name: AppRoutes.extraInfo,
    page: () => const ExtraInformationScreen(),
    binding: BindingsBuilder(() {}),
  ),
  GetPage(
    name: AppRoutes.hobbies,
    page: () => const HobbiesScreen(),
    binding: BindingsBuilder(() {}),
  ),
  GetPage(
    name: AppRoutes.desiredQuality,
    page: () => const DesiredQualityScreen(),
    binding: BindingsBuilder(() {}),
  ),
  GetPage(
    name: AppRoutes.uploadPhoto,
    page: () => const UploadPhotoScreen(),
    binding: BindingsBuilder(() {}),
  ),
  GetPage(
    name: AppRoutes.audioRecording,
    page: () => const AudioRecordingScreen(),
    binding: BindingsBuilder(() {}),
  ),
  GetPage(
    name: AppRoutes.audio1,
    page: () => const Audio1Screen(),
    binding: BindingsBuilder(() {}),
  ),
  GetPage(
    name: AppRoutes.audio2,
    page: () => const Audio2Screen(),
    binding: BindingsBuilder(() {}),
  ),
  GetPage(
    name: AppRoutes.audio3,
    page: () => const Audio3Screen(),
    binding: BindingsBuilder(() {}),
  ),
  GetPage(
    name: AppRoutes.audio4,
    page: () => const Audio4Screen(),
    binding: BindingsBuilder(() {}),
  ),
  GetPage(
    name: AppRoutes.regSuccessful,
    page: () => const RegSuccessful(),
    binding: BindingsBuilder(() {}),
  ),
  GetPage(
    name: AppRoutes.chats,
    page: () => const ChatsScreen(),
    binding: BindingsBuilder(() {}),
  ),
  GetPage(
    name: AppRoutes.chatWith,
    page: () => const ChatWithScreen(),
    binding: BindingsBuilder(() {}),
  ),
  GetPage(
    name: AppRoutes.compatibilityQuiz,
    page: () => const CompatibilityQuizScreen(),
    binding: BindingsBuilder(() {}),
  ),
  GetPage(
    name: AppRoutes.userDetails,
    page: () => const UserDetailScreen(),
    binding: BindingsBuilder(() {}),
  ),
  // GetPage(
  //   name: AppRoutes.photoViews,
  //   page: () => const PhotoViewScreen(),
  //   binding: BindingsBuilder(() {}),
  // ),
];
