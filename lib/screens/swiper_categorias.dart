import 'package:barberia/cloud_firestore/lookbook_ref.dart';
import 'package:barberia/model/image_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:google_fonts/google_fonts.dart';

import 'CategoriaPage.dart';
import 'cortes_listado.dart';

class SliderCategorias extends StatelessWidget {
  SliderCategorias();
  @override
  Widget build(BuildContext context) {
    final Object? categoria =ModalRoute.of(context)!.settings.arguments;
    return  FutureBuilder(
          future: getLookbook(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              var banners = snapshot.data as List<ImageModel>;
              var shortestSide = MediaQuery.of(context).size.shortestSide;
          var altura=420;
          double viewportFraction= 0.8;
          double scale= 0.9;
          if(shortestSide>=600){
            viewportFraction= 0.6;
            scale= 0.7;
            altura=600;
          }
// Determine if we should use mobile layout or not, 600 here is
// a common breakpoint for a typical 7-inch tablet.


              return Container(
                height: altura.toDouble(),
                  alignment: Alignment.center,
                  child: Swiper(
                    autoplay: true,
                    duration: 400,
                    itemBuilder: (context, int index) {
                      return  GestureDetector(
                        child: Container(
                          alignment: Alignment.center,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Image.network(banners[index].image,fit: BoxFit.cover),
                              ),
                              SizedBox(height: 5,),
                              Text('${banners[index].descripcion}'.toUpperCase(),  style: GoogleFonts.courgette(
                                  fontSize: 25,
                                  fontWeight:
                                  FontWeight.normal,color: Colors.blue))
                            ],
                          ),
                        ),
                          onTap: () {
                            Navigator.pushNamed(context, 'categorias',arguments: {'categoria':banners[index].category});
                            // Navigator.pushNamed(context,'categoria');
                          }
                      );

                    },
                    itemCount: banners.length,
                    viewportFraction: viewportFraction,
                    scale: scale,
                    pagination: new SwiperPagination(  margin: new EdgeInsets.all(5.0)),
                    control: new SwiperControl( color:Colors.blue ),
                  ),
                );


            }
          });


  }


}

