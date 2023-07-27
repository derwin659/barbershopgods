

import 'package:barberia/main.dart';
import 'package:barberia/screens/barber_booking_history_screen.dart';
import 'package:barberia/screens/booking_screen.dart';
import 'package:barberia/screens/home_screen.dart';
import 'package:barberia/screens/oferta.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

void initFirebaseMessagingHandler(AndroidNotificationChannel? channel, BuildContext context){


  FirebaseMessaging.onMessage.listen((RemoteMessage remoteMessage) {

    RemoteNotification? notification = remoteMessage.notification;
    AndroidNotification? android = remoteMessage.notification?.android;

    if(notification != null && android != null){
      flutterLocalNotificationsPlugin!.show(notification.hashCode, notification.title, notification.body, NotificationDetails(
        android: AndroidNotificationDetails(
          channel!.id,
          channel!.name,
          icon:'launch_background'
        )
      ));
    }
  });

  //get token
  FirebaseMessaging.instance.getInitialMessage().then((message) {
    print("FirebaseMessaging.instance.getInitialMessage");
    if(message != null){
      print("Nueva notificacion");
      if(message.data['message_id'] != null){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>Oferta()));
      }
    }
  }
  );
  FirebaseMessaging.instance
      .getToken()
      .then((value) => print('Token $value'));

  //subscripcion topico, ejemplo name is:dedmoSubscribe
  FirebaseMessaging.instance
      .subscribeToTopic('demoSubscribe')
      .then((value) => print('Succes Suscriptores'));

  FirebaseMessaging.instance
      .subscribeToTopic(FirebaseAuth.instance.currentUser!.uid)
      .then((value) => print('Succes Barber ID'));

  FirebaseMessaging.onMessage.listen((message) {
    if(message.notification != null){
      print("FirebaseMesagging.onMessage");
      print(message.notification!.title);
      print(message.notification!.body);
      print("messageType${message.data['oferta']}");
      Navigator.push(context, MaterialPageRoute(builder: (context)=>Oferta()));
    }

  });

 FirebaseMessaging.onMessageOpenedApp.listen((message)  async{
    if(message.notification != null){
      Navigator.push(context, MaterialPageRoute(builder: (context)=>Oferta()));
    }
  });
}