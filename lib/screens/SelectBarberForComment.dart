import 'package:animations/animations.dart';


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../cloud_firestore/all_salon_ref.dart';
import '../model/barber_model.dart';
import '../model/salon_model.dart';
import '../state/state_management.dart';
import 'CommentBox.dart';

class AnimationsPackageExample extends ConsumerWidget {

 final String  salonId;
 final String  cityName;
 static  var  barberModel;
 AnimationsPackageExample({required this.salonId, required String this.cityName});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
print(salonId);
print(cityName);
    return Scaffold(
      backgroundColor: Colors.blue[100],
      appBar: AppBar(title: Text("Deja tu comentario al barbero"),
    backgroundColor: Colors.blue,
    ),
    body: FutureBuilder(
    future: getBarbersBySalonD(salonId,cityName) ,
    builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting)
    return Center(
    child: CircularProgressIndicator(),
    );
    else{
    var barbers = snapshot.data as List<BarberModel>;
    if (barbers.length == 0){
    return Center(
    child: Text('Lista de barberos se encuentra vació'),
    );
    }

    else{
    return ListView.builder(
          padding: EdgeInsets.all(8),
          itemCount: barbers.length,
          itemBuilder: (context, index){

            return
               Column(
                  children: <Widget>[
                    SizedBox(height: 10,),
                    OpenContainer(
                      transitionDuration: Duration(milliseconds: 500),
                      closedBuilder: (ctx, action) =>  Container(

                        color: Colors.white,
                        child:   ListTile(
                            leading: CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage("${barbers[index].foto}"),
            ),
                            title: Text('${barbers[index].name}',
                                style: GoogleFonts.courgette(
            color: Colors.black,
            fontSize: 20,
            fontWeight:
            FontWeight.bold)),
                            subtitle: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [

                                RatingBar.builder(
                                  itemSize: 20,
                                  allowHalfRating: true,
                                  initialRating: barbers[index].rating,
                                  ignoreGestures: true,
                                  direction: Axis.horizontal,
                                  itemCount: 5,
                                  itemBuilder: (context, _) =>
                                      Icon(Icons.star, color: Colors.amber),
                                  itemPadding: EdgeInsets.all(4),
                                  onRatingUpdate: (value) {},
                                ),
                                Icon(Icons.arrow_forward_ios_outlined,color: Colors.blue,)
                              ],
                            ),
                          ),

                        ),

                      openBuilder: (ctx, action) =>  Scaffold(
                        body: Center(

                          child:  TestMe(cityName:cityName,salonId:salonId,usuario:ref.read(userInformation.state).state.name,name: barbers[index].name,foto: barbers[index].foto,descripcion: barbers[index].descripcion,like: barbers[index].like,docId:barbers[index].docId.toString())
                        ),
                      ),
                    ),
                    const Divider(thickness: 2, color: Colors.blue),
                  ]
              );

          });
    }
    }
    }));


  }
}
