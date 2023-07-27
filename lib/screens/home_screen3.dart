

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
import 'booking_screen.dart';
import 'gps_access_screen.dart';
import 'grid_category.dart';

class HomeScreen3 extends ConsumerWidget {
  const HomeScreen3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    //Setup message display
    initFirebaseMessagingHandler(channel,context);
    //

    //var watch = context.watch(userInformation.state);
    var userWatch = ref
        .watch(userInformation.state)
        .state;
    //print(userWatch);
    return SafeArea(
        child: Scaffold(

          floatingActionButton: FloatingActionButton(
            foregroundColor: Colors.white,
            backgroundColor: Colors.green,
            child: Icon(Icons.whatsapp_sharp,size: 38,),
            onPressed: (){
              launchWhasapt(number:"+51958062847",message: "¡Hola quiero reservar pero tengo una consulta!");
            },
          ),
          resizeToAvoidBottomInset: true,
          backgroundColor: Colors.white,

          body: CustomScrollView(
            slivers: [
              SliverList(
                delegate: SliverChildListDelegate([
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        //Perfil del usuario
                        FutureBuilder(
                            future: getUserProfiles(
                                FirebaseAuth.instance.currentUser!.uid),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                context.toString();
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else {
                                var userModel = snapshot.data as UserModel;
                                userWatch.name = userModel.name;
                                userWatch.email = userModel.email;
                                Authent authe=new Authent();
                                if(FirebaseAuth.instance.currentUser!.photoURL != null){
                                  return Container(
                                      decoration:
                                      const BoxDecoration(color: Colors.blue),
                                      padding: const EdgeInsets.all(10),
                                      child: StreamBuilder(
                                        stream: FirebaseAuth.instance.authStateChanges(),
                                        builder: (context,snapshot){
                                          if (snapshot.connectionState ==
                                              ConnectionState.waiting) {
                                            context.toString();
                                            return const Center(
                                              child: CircularProgressIndicator(),
                                            );
                                          }else {
                                            var user = snapshot.data;
                                            return   Row(
                                              children: [
                                                CircleAvatar(
                                                  maxRadius: 25,
                                                  child:  ClipOval(
                                                      child:  Image.network(user!.photoURL.toString(),fit: BoxFit.fill)
                                                  ),

                                                ),
                                                const SizedBox(
                                                  width: 20,
                                                  height: 5,
                                                ),
                                                Expanded(
                                                    child: Column(
                                                      children: [
                                                        Text(
                                                          'BARBERSHOP GODS',
                                                          style: GoogleFonts.aclonica(
                                                              fontSize: 16,
                                                              fontWeight:
                                                              FontWeight.bold
                                                          ),
                                                        ),
                                                        const SizedBox(

                                                          height: 5,
                                                        ),
                                                        Text(
                                                          'Hola ${user?.displayName}',
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: GoogleFonts.aclonica(
                                                              fontSize: 13,
                                                              fontWeight:
                                                              FontWeight.normal
                                                          ),
                                                        ),
                                                        const SizedBox(

                                                          height: 5,
                                                        ),
                                                        Text(
                                                          '${user?.email}',
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: GoogleFonts.aclonica(
                                                              fontSize: 12,
                                                              fontWeight:
                                                              FontWeight.normal
                                                          ),
                                                        )
                                                      ],
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                    )),
                                                Column(
                                                  children: [
                                                    IconButton(
                                                        onPressed: () =>

                                                            Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder: (
                                                                        context) =>
                                                                        SignInScreen()))

                                                        ,
                                                        icon: Icon(
                                                          Icons.power_settings_new,
                                                          color: Colors.white,
                                                        )),
                                                    userModel.isStaff
                                                        ? IconButton(
                                                        onPressed: () =>
                                                            Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder: (
                                                                        context) =>
                                                                        StaffHome())),
                                                        icon: Icon(
                                                          Icons.admin_panel_settings,
                                                          color: Colors.white,
                                                        ))
                                                        : Container(),

                                                  ],
                                                )
                                              ],
                                            );}
                                        },
                                      ));
                                }else{

                                  return Container(
                                      decoration:
                                      const BoxDecoration(color: Colors.blue),
                                      padding: const EdgeInsets.all(16),
                                      child: Row(
                                        children: [
                                          const CircleAvatar(
                                            maxRadius: 30,
                                            backgroundColor: Colors.blueGrey,
                                            child: Icon(
                                              Icons.person,
                                              color: Colors.white,
                                              size: 30,
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 20,
                                          ),
                                          Expanded(
                                              child: Column(
                                                children: [
                                                  Text(
                                                    'BARBERSHOP GODS',
                                                    style: GoogleFonts.aclonica(
                                                        color: Colors.white,
                                                        fontSize: 23,
                                                        fontWeight:
                                                        FontWeight.bold),
                                                  ),
                                                  Text(
                                                    'Hola ${userModel
                                                        .name}',
                                                    overflow: TextOverflow
                                                        .ellipsis,
                                                    style: GoogleFonts.aclonica(
                                                        color: Colors.white,
                                                        fontSize: 20,
                                                        fontWeight:
                                                        FontWeight.normal),
                                                  ),
                                                  Text(
                                                    '${userModel.email}',
                                                    overflow: TextOverflow
                                                        .ellipsis,
                                                    style: GoogleFonts.aclonica(
                                                        color: Colors.white,
                                                        fontSize: 15,
                                                        fontWeight:
                                                        FontWeight.normal),
                                                  )
                                                ],
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                              )),
                                          Column(
                                            children: [
                                              IconButton(
                                                  onPressed: () =>
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (
                                                                  context) =>
                                                                  SignInScreen()))
                                                  ,
                                                  icon: Icon(
                                                    Icons.power_settings_new,
                                                    color: Colors.white,
                                                  )),
                                              userModel.isStaff
                                                  ? IconButton(
                                                  onPressed: () =>
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (
                                                                  context) =>
                                                                  StaffHome())),
                                                  icon: Icon(
                                                    Icons.admin_panel_settings,
                                                    color: const Color(0xFFEBBEA7),
                                                  ))
                                                  : Container(),

                                            ],
                                          )


                                        ],
                                      ));
                                }
                              }
                            }),
                        //Menu
                        Padding(
                            padding: const EdgeInsets.all(4),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment
                                  .spaceBetween,
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                      onTap: () =>
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      BookingScren())),
                                      child: Container(
                                        child: Card(
                                          color:  Colors.blue,
                                          child: Padding(
                                              padding: const EdgeInsets.all(
                                                  8),
                                              child: Column(
                                                mainAxisAlignment:
                                                MainAxisAlignment.center,
                                                children: [
                                                  const Icon(
                                                    Icons.add,
                                                    size: 50,
                                                    color: Colors.white,
                                                  ),
                                                  Text(
                                                      'Reservar',
                                                      style: GoogleFonts.aclonica(
                                                          fontSize: 14,
                                                          fontWeight:
                                                          FontWeight.normal
                                                      )
                                                  )
                                                ],
                                              )),
                                        ),
                                      )),
                                ),
                                Expanded(
                                  child: GestureDetector(
                                      onTap: () =>
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      VideosBarber())),
                                      child: Container(
                                        child: Card(
                                          color:  Colors.blue,
                                          child: Padding(
                                              padding: const EdgeInsets.all(
                                                  8),
                                              child: Column(
                                                mainAxisAlignment:
                                                MainAxisAlignment.center,
                                                children: [
                                                  const Icon(
                                                      Icons.video_collection,
                                                      size: 50,
                                                      color: Colors.white
                                                  ),
                                                  Text(
                                                    'Videos',
                                                    style: GoogleFonts.aclonica(
                                                        fontSize: 14,
                                                        fontWeight:
                                                        FontWeight.normal
                                                    ),
                                                  )
                                                ],
                                              )),
                                        ),
                                      )),
                                ),
                                Expanded(
                                    child: GestureDetector(
                                      onTap: () =>
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      UserHistory())),
                                      child: Container(
                                        child: Card(
                                          color:  Colors.blue,
                                          child: Padding(
                                              padding: const EdgeInsets.all(
                                                  8),
                                              child: Column(
                                                mainAxisAlignment:
                                                MainAxisAlignment.center,
                                                children: [
                                                  const Icon(
                                                      Icons.calendar_month,
                                                      size: 50,
                                                      color: Colors.white
                                                  ),
                                                  Text(
                                                    'Mis Reservas',
                                                    style: GoogleFonts.aclonica(
                                                        fontSize: 14,
                                                        fontWeight:
                                                        FontWeight.normal
                                                    ),
                                                  )
                                                ],
                                              )),
                                        ),
                                      ),
                                    )),
                              ],
                            )),
                        //Banner
                        FutureBuilder(
                            future: getBanners(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else {
                                var banners = snapshot.data as List<
                                    ImageModel>;
                                return CarouselSlider(
                                  items: banners
                                      .map((e) =>
                                      Container(
                                        child: ClipRRect(

                                          borderRadius: BorderRadius
                                              .circular(8),
                                          child: Image.network(e.image),
                                        ),
                                      ))
                                      .toList(),
                                  options: CarouselOptions(
                                      enlargeCenterPage: true,
                                      aspectRatio: 3.0,
                                      autoPlay: true,
                                      autoPlayInterval: const Duration(
                                          seconds: 3)),
                                );
                              }
                            }),
                        //Lookbo
                        Text(
                          'CATALOGOS',
                          style: GoogleFonts.courgette(
                              fontSize: 25,
                              fontWeight:
                              FontWeight.normal,color: Colors.blue),textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 10,),
                        SliderCategorias(),
                        SizedBox(height: 10,),
                        Text(
                          'TENDENCIA EN CORTES',
                          style: GoogleFonts.courgette(
                              fontSize: 25,
                              fontWeight:
                              FontWeight.normal,color: Colors.blue),textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 10,),
                        corteListado(context)
                      ],

                    ),

                  ),


                ],
                ),

              )

            ],

          ),

        ));



  }

  void launchWhasapt( {@required number,@required message}) async {
    String uri="whatsapp://send?phone=$number&text=$message";

    await canLaunch(uri) ? launch(uri) : print("No puede abrir whasapt");
  }
}
