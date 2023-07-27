

import 'package:barberia/model/image_model.dart';
import 'package:barberia/model/user_model.dart';
import 'package:barberia/screens/CategoriaPage.dart';
import 'package:barberia/screens/barber_booking_history_screen.dart';
import 'package:barberia/screens/cortes_listado.dart';
import 'package:barberia/screens/home.dart';
import 'package:barberia/screens/loading_screens.dart';
import 'package:barberia/screens/signin_screen.dart';
import 'package:barberia/screens/staff_home_screen.dart';
import 'package:barberia/screens/swiperPopulares.dart';
import 'package:barberia/screens/swiper_categorias.dart';
import 'package:barberia/screens/ubicaciones.dart';
import 'package:barberia/screens/user_history_screen.dart';
import 'package:barberia/screens/videos_barberia.dart';
import 'package:barberia/screens/whasaptClon.dart';
import 'package:barberia/services/Authent.dart';
import 'package:barberia/state/state_management.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';
import '../cloud_firestore/banner_ref.dart';
import '../cloud_firestore/lookbook_ref.dart';
import '../cloud_firestore/user_ref.dart';
import '../fcm/fcm_notification_handler.dart';
import '../main.dart';
import 'SelectBarberForComment.dart';
import 'booking_screen.dart';
import 'gps_access_screen.dart';
import 'grid_category.dart';
import 'home_screen3.dart';

class HomeScreen1 extends StatefulWidget {

  const HomeScreen1({super.key});

  @override
  _HomeScreen1State createState() => _HomeScreen1State();

}

class _HomeScreen1State extends  State<HomeScreen1>{
  final _page = [
    HomeScreen3(),
    UserHistory(),
    BookingScren(),
    LoadingScreens(),
    AnimationsPackageExample(salonId: '0ODa6FGIz8zCbVzM2Dwz', cityName: 'Cusco')
  ];
  int _activePage = 0;

  @override
  Widget build(BuildContext context) {

    const _kPages = <String, IconData>{
      'Inicio': Icons.home,
      'Reservas': Icons.calendar_month,
      'Reservar': Icons.add,
      'Mapa': Icons.map,
      'Opiniones': Icons.message,

    };



    return DefaultTabController(
      length: 5,
      initialIndex: _activePage,
      child: Scaffold(

        body: _page[_activePage],
        bottomNavigationBar: ConvexAppBar(
          // Optional badge argument: keys are tab indices, values can be
          // String, IconData, Color or Widget.
            color: Colors.white,
            style: TabStyle.reactCircle,
            items: <TabItem>[
              for (final entry in _kPages.entries)
                TabItem(icon: entry.value, title: entry.key),
            ],
            onTap: (int i) {
              setState(() {
                _activePage = i;
              });
            }),
      ),

    );

  }

}







