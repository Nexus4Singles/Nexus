import 'dart:async';
import 'dart:isolate';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nexus/core/di/injection_container.dart';
import 'package:nexus/features/auth/presentation/change_notifier/auth_notifier.dart';
import 'package:nexus/features/explore/controllers/explore_ctr.dart';
import 'package:nexus/features/home/presentation/change_notifier/bottom_nav.dart';
import 'package:nexus/features/home/presentation/change_notifier/home_notifier.dart';
import 'package:nexus/features/profile/presentation/change_notifier/settings_notifier.dart';
import 'package:nexus/router.dart';
import 'package:nexus/theme.dart';
import 'package:provider/provider.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() {
  runZonedGuarded<Future<void>>(() async {
    WidgetsFlutterBinding.ensureInitialized();
    Animate.restartOnHotReload = true;
    await initializeDateFormatting(
        'en_US', null); // Initialize with your desired locale

    await configureDependencies();
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
}
