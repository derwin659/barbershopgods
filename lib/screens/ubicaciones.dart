import 'package:barberia/screens/user_history_screen.dart';
import 'package:barberia/screens/viaje_gods.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';

import 'booking_screen.dart';
import 'home_screen.dart';
import 'loading_screens.dart';

class Ubicaciones extends StatefulWidget {
  const Ubicaciones({Key? key}) : super(key: key);

  @override
  State<Ubicaciones> createState() => _UbicacionesState();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}

class _UbicacionesState extends State<Ubicaciones> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("REGRESAR"),
          backgroundColor: Colors.blue,
        ),
        body: Container(
          color: Colors.blueGrey,
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Card(
                semanticContainer: true,
                borderOnForeground: true,
                child: Text('!!Estamos aqui para llevarte facilmente!!',
                    style: GoogleFonts.courgette(
                        fontSize: 25,
                        fontWeight:
                        FontWeight.normal),
                    textAlign: TextAlign.center),
              ),
              SizedBox(
                height: 50,
              ),
              Text('Desde: Mi ubicación Actual',
                  style: GoogleFonts.courgette(
                      fontSize: 20,
                      fontWeight:
                      FontWeight.normal),
                  textAlign: TextAlign.start),
              Text('Hasta: BarberShop GODS ',
                  style: GoogleFonts.courgette(
                      fontSize: 20,
                      fontWeight:
                      FontWeight.normal),
                  textAlign: TextAlign.start),
              SizedBox(
                height: 50,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ViajeGods()));
                },
                child: Text(
                  "Comenzar el viaje",
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          ),
        ));
  }
}
