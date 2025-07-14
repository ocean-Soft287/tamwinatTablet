import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:search_appp/core/network/Dio/cash_helper.dart';
import 'package:search_appp/core/routes/app_routes.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:search_appp/core/routes/naviation_service.dart';
import 'package:search_appp/core/routes/routes.dart';
import 'package:search_appp/core/services/firebase_messaging_service.dart';
import 'package:search_appp/core/services/flutter_local_notification.dart';
import 'package:search_appp/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
await EasyLocalization.ensureInitialized();

 await CacheHelper.init();
 await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
await NotificationsService.init();
  final firebaseMessagingService = FirebaseMessagingService.instance();

  await firebaseMessagingService.init(localNotificationsService: NotificationsService());

  runApp(EasyLocalization(    supportedLocales: const [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      startLocale: const Locale('en'),
      fallbackLocale: const Locale('en'),  child: MyApp(appRoutes: AppRoutes())));

}

class MyApp extends StatelessWidget {
  final AppRoutes appRoutes;

  const MyApp({
    super.key,
    required this.appRoutes,
  });

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp(
        title: 'Flutter Demo',

        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        debugShowCheckedModeBanner: false,
        navigatorKey: NavigationService.navigatorKey,
        onGenerateRoute: appRoutes.generateroute,
        initialRoute: Routes.home,
        theme: ThemeData(
          useMaterial3: false,
        ),
      ),
    );
  }
}
