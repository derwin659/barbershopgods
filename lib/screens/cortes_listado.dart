import 'package:barberia/cloud_firestore/lookbook_ref.dart';
import 'package:barberia/model/populares_model.dart';
import 'package:barberia/screens/CategoriaPage.dart';
import 'package:barberia/screens/text_receta.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:google_fonts/google_fonts.dart';


Widget corteListado(context) {
  return  FutureBuilder(
      future: getPopulares(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          var banners = snapshot.data as List<PopularesModel>;
          return SingleChildScrollView(
            physics: ScrollPhysics(),
            child: Column(
              children: [
                ListView.builder(
                  padding: const EdgeInsets.all(8),
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: banners.length,
                  itemBuilder: (context, index) {
                    return
                      Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(left: 30.0, top: 0.0,right: 30),
                        child: Column(

                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: AspectRatio(
                                aspectRatio: 1,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(
                                      banners[index].imagen, fit: BoxFit.cover),
                                ),
                                ),
                              ),
                            SizedBox(height: 10,),
                            Text( banners[index].titulo,
                              style: GoogleFonts.courgette(
                                  fontSize: 20,
                                  fontWeight:
                                  FontWeight.normal,color: Colors.blue),),
                            SizedBox(height: 10,),
                            Text(banners[index].descripcion,
                              style: GoogleFonts.courgette(
                                  fontSize: 15,
                                  fontWeight:
                                  FontWeight.normal,color: Colors.black),),
                            SizedBox(
                              height: 10.0,
                            ),
                            Container(
                              child: Row(
                                children: [
                                  SizedBox(height: 10,),
                                  Expanded(child: Row(children: [
                                    Icon(Icons.timelapse,
                                        color: Colors.black),
                                    Container(
                                      child: Text(banners[index].time.toString()+' min' ,
                                        style: GoogleFonts.robotoMono(
                                            fontSize: 12,
                                            fontWeight: FontWeight.normal,
                                            color: Colors.black),),
                                    ),
                                    SizedBox(height: 20,),

                                  ],)),
                                ],
                              ),
                            )
                          ],
                        ),
                      );


                  },

                )
              ],
            ),
          );


        }
      });



}



