import 'package:barberia/model/ListCategoria.dart';
import 'package:barberia/screens/user_history_screen.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:photo_view/photo_view.dart';

import '../cloud_firestore/lookbook_ref.dart';
import '../model/image_model.dart';
import 'booking_screen.dart';
import 'home_screen.dart';

class CategoriaPage extends StatelessWidget {
  const CategoriaPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map? parameters = ModalRoute.of(context)!.settings.arguments as Map?;
//get token
    print('bienvenido ' + parameters!['categoria']);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text(parameters!['categoria']),
        ),
        backgroundColor: Colors.black,
        body: FutureBuilder(
            future: getModelosCategorias(parameters!['categoria']),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                var banners = snapshot.data as List<ListCategorias>;

                return GridView.builder(

                  padding: const EdgeInsets.all(8.0),
                  shrinkWrap: true,
                  itemCount: banners.length,
                  itemBuilder: (context, index) {
                    return Column(
                        children: [
                          Flexible(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child:PhotoView(imageProvider: NetworkImage('${banners[index].imagen}'))  ,
                            ),
                          )
                          ,
                          SizedBox(
                            height: 15,
                          ),
                          Text('${banners[index].precio} Soles',  style: GoogleFonts.aclonica(
                              fontSize: 25,
                              fontWeight:
                              FontWeight.normal
                          ))
                        ]
                    );;
                  },
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisSpacing: 5,
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      childAspectRatio: 1),
                );
              }
            }));
  }
}
