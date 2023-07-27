// @dart=2.9
import 'package:barberia/blocs/blocs.dart';
import 'package:barberia/fcm/fcm_background_handler.dart';
import 'package:barberia/screens/CategoriaPage.dart';
import 'package:barberia/screens/Onboarding.dart';
import 'package:barberia/screens/login.dart';
import 'package:barberia/screens/signin_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
AndroidNotificationChannel channel;
bool show=true;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs=await SharedPreferences.getInstance();
  show=await prefs.getBool('ON_BOARDING') ?? true;
  //Firebase
  await Firebase.initializeApp();

  //Configuracion Firebase
  FirebaseMessaging.onBackgroundMessage(firebaseBackgroundHandler);

  //Flutter  Local Notifications

  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  channel = const AndroidNotificationChannel('edmt.dev', 'EDMT Dev',
      importance: Importance.max);

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert:true,
    badge: true,
    sound: true
  );

  runApp(MultiBlocProvider(providers: [BlocProvider(create: (context)=>GpsBloc())], child: ProviderScope(child: MyApp(),)));
}

class MyApp extends StatelessWidget {



  static final String title = 'Main Page';

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: title,
      theme: ThemeData.dark().copyWith(accentColor: Colors.indigo),
      initialRoute: '/',
      routes: {
        '/':(context)=>  show ? OnboardingScreens() :const SignInScreen(),
        'categorias':(context)=> const CategoriaPage()
      }
    );
  }
}
