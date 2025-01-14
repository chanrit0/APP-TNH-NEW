import 'dart:io';
import 'package:app_tnh2/helper/RouteAwareAnalytics.dart';
import 'package:app_tnh2/provider/providerHome.dart';
import 'package:app_tnh2/screens/CheckAuth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:app_tnh2/widgets/app_loading.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  HttpOverrides.global = MyHttpOverrides();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(const MyApp());
  });
  FlutterNativeSplash.remove();
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyApp();
}

class _MyApp extends State<MyApp> {
  final MyRouteObserver routeObserver = MyRouteObserver();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) {
            return ProviderHome();
          }),
          Provider<AppLoading>(create: (_) => AppLoading()),
        ],
        child: ScreenUtilInit(
            designSize: const Size(360, 690),
            minTextAdapt: false,
            splitScreenMode: false,
            builder: (context, child) {
              return MaterialApp(
                  localizationsDelegates: const [
                    GlobalMaterialLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                  ],
                  supportedLocales: const [
                    Locale('en', 'US'), // English
                    Locale('th', 'TH'), // Thai
                  ],
                  debugShowCheckedModeBanner: false,
                  title: 'TNh HEALTH',
                  navigatorObservers: <NavigatorObserver>[routeObserver],
                  theme: ThemeData(
                    appBarTheme: Theme.of(context).appBarTheme.copyWith(
                        systemOverlayStyle: const SystemUiOverlayStyle(
                            systemNavigationBarIconBrightness:
                                Brightness.light)),
                    primaryColor: Colors.red,
                    fontFamily: 'RSU_BOLD',
                  ),
                  // navigatorObservers: [routeObserver],
                  initialRoute: '/',
                  routes: {
                    '/': (context) => const CheckAuth(),
                  });
            }));
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
