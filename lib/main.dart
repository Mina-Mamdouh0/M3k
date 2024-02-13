import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:m3k/Core/helper/shared_pref_services.dart';
import 'package:m3k/Core/translations/codegen_loader.g.dart';
import 'package:m3k/Core/unit/app_router.dart';
import 'package:m3k/Core/unit/color_data.dart';
import 'package:m3k/Feather/User/presentation/manager/user_cubit.dart';
import 'firebase_options.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}


void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferencesServices.init();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(
      EasyLocalization(
          path: 'assets/translations',
          supportedLocales:const  [
            Locale('en'),
            Locale('ar'),
          ],
          fallbackLocale: const Locale('ar'),
          startLocale: Locale(SharedPreferencesServices.getDate(key: 'Lung')??'ar'),
          assetLoader: const CodegenLoader(),
          child:MultiBlocProvider(
            providers: [
              BlocProvider (create: (BuildContext context) => UserCubit(),),
            ],
            child: const MyApp(),)));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'M3K',
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: ThemeData(
        scaffoldBackgroundColor: ColorData.whiteColor,
      ),
      routerConfig: AppRouter.router,
    );
  }
}

