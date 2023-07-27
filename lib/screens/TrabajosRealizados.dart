import 'package:barberia/model/ListCategoria.dart';
import 'package:barberia/model/ListTrabajosRealizados.dart';
import 'package:barberia/model/salon_model.dart';
import 'package:barberia/screens/user_history_screen.dart';
import 'package:barberia/state/state_management.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:photo_view/photo_view.dart';

import '../cloud_firestore/lookbook_ref.dart';
import '../model/image_model.dart';
import 'booking_screen.dart';
import 'home_screen.dart';

class TrabajosRealizadosPage extends ConsumerWidget {
  const TrabajosRealizadosPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context,WidgetRef ref) {

//get token


    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text('Lista de Trabajos realizados'),
        ),
        backgroundColor: Colors.black,
        body: FutureBuilder(

            future: getModelosPorBarberos(ref),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                var banners = snapshot.data as List<ListTrabajosRealizados>;

                return GridView.builder(
                  padding: const EdgeInsets.all(20.0),
                  shrinkWrap: true,
                  itemCount: banners.length,
                  itemBuilder: (context, index) {
                    return Column(

                            children: [
                              Flexible(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child:PhotoView(
                                  initialScale: PhotoViewComputedScale.contained * 0.9,
                                      imageProvider: NetworkImage('${banners[index].foto}')
                                  )  ,
                                ),
                              )
                              ,
                              SizedBox(
                                height: 15,
                              ),
                              Text('${banners[index].name}'.toUpperCase(),  style: GoogleFonts.courgette(
                                  fontSize: 25,
                                  fontWeight:
                                  FontWeight.normal,color: Colors.white))
                            ]
                        );
                  },
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisSpacing: 5,
                      crossAxisCount: 1,
                      crossAxisSpacing: 3,
                      childAspectRatio: 1),
                );
              }
            }));
  }
}
