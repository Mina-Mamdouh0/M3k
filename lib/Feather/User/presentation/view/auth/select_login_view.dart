
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:go_router/go_router.dart';
import 'package:m3k/Core/translations/locale_keys.g.dart';
import 'package:m3k/Core/unit/app_router.dart';
import 'package:m3k/Core/unit/assets_data.dart';
import 'package:m3k/Core/unit/color_data.dart';
import 'package:m3k/Core/unit/constant_data.dart';
import 'package:m3k/Core/unit/size_data.dart';
import 'package:m3k/Core/unit/styles.dart';
import 'package:m3k/Core/unit/unit.dart';
import 'package:m3k/Core/widget/main_button_custom.dart';
import 'package:m3k/Feather/User/presentation/manager/user_cubit.dart';

class SelectLoginView extends StatefulWidget {
  const SelectLoginView({Key? key}) : super(key: key);

  @override
  State<SelectLoginView> createState() => _SelectLoginViewState();
}

class _SelectLoginViewState extends State<SelectLoginView> {

  late AndroidNotificationChannel channel;
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  void requestPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      debugPrint('User granted permission');
    } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
      debugPrint('User granted provisional permission');
    } else {
      debugPrint('User declined or has not accepted permission');
    }
  }

  void listenFCM() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null && !kIsWeb) {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              // TODO add a proper drawable resource to android, for now using
              icon: 'launch_background',
            ),
          ),
        );
      }
    });
  }
  void loadFCM() async {
    if (!kIsWeb) {
      channel = const AndroidNotificationChannel(
        'high_importance_channel', // id
        'High Importance Notifications', // title
        importance: Importance.high,
        enableVibration: true,
      );
      flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel);
      await FirebaseMessaging.instance
          .setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );
    }
  }


  @override
  void initState() {

    BlocProvider.of<UserCubit>(context).getDeviceToken();

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {});
    requestPermission();
    loadFCM();
    listenFCM();


    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(SizeData.s20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: SizeData.s30,),
            AspectRatio(
              aspectRatio: 1.2/0.3,
              child: Image.asset(AssetsData.logoImage),
            ),
            const Spacer(),

            Text(LocaleKeys.kBeneficiaryOrCompanion.tr(),
                style: Styles.textStyle24.copyWith(
                    fontSize: Unit(context).getWidthSize*0.074,
                    color: ColorData.blackColor
                ),textAlign: TextAlign.center),
            SizedBox(height: SizeData.s15,),
            Text(LocaleKeys.kDescSelectLogin.tr(),
                style: Styles.textStyle22.copyWith(
                  fontSize: Unit(context).getWidthSize*0.053,
                ),
                textAlign: TextAlign.center),

            const Spacer(),
            MainButtonSecondCustom(
              text: LocaleKeys.kBeneficiary.tr(),
              fct: (){
                BlocProvider.of<UserCubit>(context).selectTypeLogin(SelectLoginEnum.beneficiary.name);
                GoRouter.of(context).push(AppRouter.kLoginView);
              },
            ),
            SizedBox(height: SizeData.s20,),
            MainButtonSecondCustom(
              text: LocaleKeys.kAmenities.tr(),
              fct: (){
                BlocProvider.of<UserCubit>(context).selectTypeLogin(SelectLoginEnum.amenities.name);
                GoRouter.of(context).push(AppRouter.kLoginView);
              },
            ),
            const Spacer(flex: 2),

          ],
        ),
      ),
    );
  }
}
