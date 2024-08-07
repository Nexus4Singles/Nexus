import 'dart:async';
import 'dart:isolate';
import 'package:Nexus/router.dart';
import 'package:Nexus/theme.dart';
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

import 'core/di/injection_container.dart';
import 'features/auth/presentation/change_notifier/auth_notifier.dart';
import 'features/explore/controllers/explore_ctr.dart';
import 'features/home/presentation/change_notifier/bottom_nav.dart';
import 'features/home/presentation/change_notifier/home_notifier.dart';
import 'features/profile/presentation/change_notifier/settings_notifier.dart';
import 'features/subscription/provider/subscription_provider.dart';
import 'features/subscription/services/subscription_service.dart';

void main() {
  runZonedGuarded<Future<void>>(() async {
    WidgetsFlutterBinding.ensureInitialized();
    Animate.restartOnHotReload = true;
    await initializeDateFormatting(
        'en_US', null); // Initialize with your desired locale

    await configureDependencies();
    try {
      await SubscriptionService.init();
    } catch (e){
      logger.e('Error occurred initializing subscription service; ${e.toString()}');
    }
    await Firebase.initializeApp();

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
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final ctr = Get.put(ExploreCtr());

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => BottomNavModel()),
        ChangeNotifierProvider(create: (_) => SettingsNotifier()),
        ChangeNotifierProvider(create: (_) => sl<AuthNotifier>()),
        ChangeNotifierProvider(create: (_) => sl<HomeNotifier>()),
        ChangeNotifierProvider(create: (_) => SubscriptionProvider())
      ],
      child: Consumer<ThemeProvider>(builder: (context, theme, _) {
        return ScreenUtilInit(
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
        );
      }),
    );
  }
}
