import 'dart:async';
import 'dart:isolate';
import 'package:Nexus/core/utils/helper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:rename/platform_file_editors/abs_platform_file_editor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/di/injection_container.dart';
import 'core/storage/digital_ocean_keys.dart';
import 'features/auth/presentation/change_notifier/auth_notifier.dart';
import 'features/chat/chat_manager.dart';
import 'features/explore/controllers/explore_ctr.dart';
import 'features/home/presentation/change_notifier/bottom_nav.dart';
import 'features/home/presentation/change_notifier/home_notifier.dart';
import 'features/profile/presentation/change_notifier/settings_notifier.dart';
import 'features/subscription/provider/subscription_provider.dart';
import 'features/subscription/services/subscription_service.dart';
import 'router.dart';
import 'theme.dart';

final navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  runZonedGuarded<Future<void>>(() async {
    WidgetsFlutterBinding.ensureInitialized();
    Animate.restartOnHotReload = true;
    await initializeDateFormatting(
        'en_US', null); // Initialize with your desired locale

    await configureDependencies();
    await Firebase.initializeApp();

    try {
      await SubscriptionService.init();
    } catch (e) {
      BaseHelper.showSnackBar('Error initializing subsccription service: $e');
      logger.e(
          'Error occurred initializing subscription service; ${e.toString()}');
    }

    if (kDebugMode) {
      await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(false);
    } else {
      await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
    }

    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]).then((_) => runApp(MyApp()));
  }, (error, stack) => FirebaseCrashlytics.instance.recordError(error, stack));

  Isolate.current.addErrorListener(RawReceivePort((pair) async {
    final List<dynamic> errorAndStacktrace = pair;

    await FirebaseCrashlytics.instance.recordError(
      errorAndStacktrace.first,
      errorAndStacktrace.last,
    );
  }).sendPort);

  DigitalOceanConfig.initDigitalOcean();
}

class MyApp extends StatelessWidget with WidgetsBindingObserver {
  MyApp({super.key});
  final ctr = Get.put(ExploreCtr());

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addObserver(this);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => BottomNavModel()),
        ChangeNotifierProvider(create: (_) => SettingsNotifier()),
        ChangeNotifierProvider(create: (_) => sl<AuthNotifier>()),
        ChangeNotifierProvider(create: (_) => sl<HomeNotifier>()),
        ChangeNotifierProvider(create: (_) => SubscriptionProvider()),
      ],
      child: Consumer<ThemeProvider>(builder: (context, theme, _) {
        return GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: ScreenUtilInit(
            splitScreenMode: false,
            builder: (context, child) => GetMaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Nexus',
              theme: lightTheme,
              // theme: darkTheme,
              initialRoute: AppRoutes.splash,
              getPages: appRouter,
              builder: EasyLoading.init(),
            ),
          ),
        );
      }),
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.paused) {
      logger.i('lifecycle-> paused');
      await clearSharedPreferences();
    } else if (state == AppLifecycleState.detached) {
      // App is terminated
      logger.i('App is terminated');
      await clearSharedPreferences();
    }
  }

  Future<void> clearSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('activeChatUserId', '');
    logger.i('Main: Active chat user ID cleared');
  }
}
