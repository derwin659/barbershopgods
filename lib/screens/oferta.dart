

import 'package:barberia/screens/booking_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../cloud_firestore/oferta.dart';
import '../model/ofertaModel.dart';


class Oferta extends ConsumerWidget {
  const Oferta({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Oferta'),
        backgroundColor: const Color(0xFF0E6BAC),
      ),
      body: Container(
        width: 600,
        child:  FutureBuilder(
          future: getOferta(),
          builder: (context,snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }else{
              var oferta = snapshot.data as List<OfertaModel>;
              return ListView.builder(
                itemCount: oferta.length,
                padding: const EdgeInsets.all(8),
                itemBuilder: (context,  index) {

                  return  Column(
                    children: [
                      SizedBox(height: 15,),
                      Text(oferta[index].descripcion,
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF130F0F)),textAlign: TextAlign.justify)
                      ,
                      SizedBox(height: 15,),
                      Image.network(
                             oferta[index].imagen, fit: BoxFit.fitWidth),
                      SizedBox(height: 30,),
                      ButtonBar(
                        alignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>BookingScren()));
                          }, child:Text(
                              'Reservar ahora',
                              style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFFFFFFFF)),textAlign: TextAlign.justify
                          ) )
                        ],
                      )
                    ],
                  );

                },

              );
            }
          },

        )

       ,
        color: Colors.white,
      )
    );
  }
}
