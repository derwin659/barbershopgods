
import 'package:barberia/model/booking_model.dart';
import 'package:barberia/screens/loading_screens.dart';
import 'package:barberia/screens/videos_barberia.dart';
import 'package:barberia/state/state_management.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../cloud_firestore/user_ref.dart';
import '../model/comment_model.dart';
import '../utils/utils.dart';
import 'CommentBox.dart';
import 'SelectBarberForComment.dart';
import 'booking_screen.dart';
import 'home_screen.dart';

class UserHistory extends ConsumerWidget  {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final _controllerComment = TextEditingController();


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double rating = 0.0;
    var calificacion = ref.watch(selectedCalificacion.state).state;
    print('nuevo valor derwin');
    print(calificacion);

    var watchRefresh = ref.watch(deleteFlagRefresh.state);

    return SafeArea(
        child: Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              title: const Text('Tus reservas'),
              backgroundColor: Colors.blue,
            ),
            resizeToAvoidBottomInset: true,
            backgroundColor: const Color(0xFFFFFFFF),
            body: Padding(
                padding: const EdgeInsets.all(12),
                child: displayUserHistor(ref))));
  }

  displayUserHistor(WidgetRef ref) {
    return FutureBuilder(
        future: getUserHistory(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return const Center(child: CircularProgressIndicator());
          else {
            var userBooking = snapshot.data as List<BookingModel>;

            print(userBooking.length);
            if (userBooking.length == 0)
              return const Center(
                child: Text('No puede cargar la información del usuario'),
              );
            else {
              return FutureBuilder(
                  future: syncTime(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting)
                      return const Center(child: CircularProgressIndicator());
                    else {

                      var syncTime = snapshot.data as DateTime;

                      return ListView.builder(
                          itemCount: userBooking.length,
                          itemBuilder: (context, index) {

                            var calificacion = userBooking[index].rating.toDouble();

                           print('derwin rating');
                            print(calificacion);
                           print(ref.read(selectedCalificacion.state).state.toString());
                            var isExpired = DateTime.fromMillisecondsSinceEpoch(
                                    userBooking[index].timeStamp)
                                .isBefore(syncTime);

                            return Card(
                              color: const Color(0xFF0A0101),
                              elevation: 8,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(12),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(children: [
                                              Text(
                                                'Fecha del Servicio',
                                                style: GoogleFonts.courgette(
                                                  fontSize: 17,
                                                    fontWeight:
                                                    FontWeight.bold
                                                ),
                                              ),
                                              Text(
                                                DateFormat("dd/MM/yy").format(
                                                    DateTime
                                                        .fromMillisecondsSinceEpoch(
                                                            userBooking[index]
                                                                .timeStamp)),
                                                style: GoogleFonts.courgette(
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.normal),
                                              )
                                            ]),
                                            Column(children: [
                                              Text(
                                                'Hora del Servicio',
                                                style: GoogleFonts.courgette(
                                                    fontSize: 17,
                                                    fontWeight:
                                                    FontWeight.bold
                                                ),
                                              ),
                                              Text(
                                                TIME_SLOT.elementAt(
                                                    userBooking[index].slot),
                                                style: GoogleFonts.courgette(
                                                    fontSize: 15,
                                                    fontWeight:
                                                    FontWeight.normal),
                                              )
                                            ])
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Divider(
                                    thickness: 2,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(12),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(children: [
                                              Text(
                                                '${userBooking[index].salonName}',
                                                style: GoogleFonts.courgette(
                                                    fontSize: 17,
                                                    fontWeight:
                                                    FontWeight.bold
                                                ),
                                              ),
                                              Text(
                                                '${userBooking[index].salonAddress}',
                                                style: GoogleFonts.courgette(
                                                    fontSize: 15,
                                                    fontWeight:
                                                    FontWeight.normal),
                                              )
                                            ]),
                                            SizedBox(height: 1,),
                                            Expanded(child: Column(children: [
                                              Text(
                                                'Barbero Favorito',
                                                style: GoogleFonts.courgette(
                                                    fontSize: 17,
                                                    fontWeight:
                                                    FontWeight.bold
                                                ),
                                              ),
                                              Text(
                                                '${userBooking[index].barberName}',
                                                style: GoogleFonts.courgette(
                                                    fontSize: 15,
                                                    fontWeight:
                                                    FontWeight.normal),
                                              )
                                            ])),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  const Divider(
                                    thickness: 2,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(12),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children: [

                                            Column(children: [
                                              Text(
                                                'Servicio Realizado',
                                                style: GoogleFonts.courgette(
                                                    fontSize: 17,
                                                    fontWeight:
                                                    FontWeight.bold
                                                ),
                                              ),
                                           Text( userBooking[index].done
                                               ?  '${userBooking[index].services}'
                                               : 'Servicios aun no realizado'
                                                 ,
                                                  style: GoogleFonts.courgette(
                                                      fontSize: 15,
                                                      fontWeight:
                                                      FontWeight.normal) ,
                                              )

                                            ]),

                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(12),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children: [

                                            Column(children: [
                                              Text(
                                                  userBooking[index].done
                                                      ? 'Calificar a ${userBooking[index].barberName}'
                                                      : 'No se puede calificar',
                                                  style: GoogleFonts.courgette(
                                                    color: Colors.white,
                                                      fontSize: 17,
                                                      fontWeight:
                                                      FontWeight.normal)),
                                              SizedBox(height: 10,),
                                              userBooking[index].done? Column(
                                                children: [
                                                  RatingBar.builder(
                                                    initialRating: calificacion,
                                                      minRating: 1,
                                                      itemBuilder: (context,_)=>Icon(Icons.star,color:Colors.amber),

                                                      onRatingUpdate: (rating){

                                                      },
                                                      updateOnDrag: true,
                                                      itemSize: 30,
                                                      itemPadding: EdgeInsets.symmetric(horizontal: 4)),
                                                  ElevatedButton(onPressed: (){

                                                    showRating(context,ref,userBooking[index].salonId,userBooking[index].cityBook,userBooking[index].barberName,userBooking[index].docId.toString(),userBooking[index].totalPrice,
                                                        userBooking[index].services,userBooking[index].barberId,userBooking[index].customerId,userBooking[index].customerFoto,userBooking[index].customerName,userBooking[index].done,userBooking[index].salonAddress,userBooking[index].salonName,userBooking[index].slot,
                                                        userBooking[index].time,userBooking[index].customerEmail,userBooking[index].rating,userBooking[index].timeStamp);

                                                  }, child: Text('Calificar',style: GoogleFonts.courgette(
                                                      fontSize: 15,
                                                      fontWeight:
                                                      FontWeight.normal),))

                                                ],
                                              ):
                                              Text('Completa el servicio para calificar',
                                                  style: GoogleFonts.courgette(
                                                      fontSize: 15,
                                                      fontWeight:
                                                      FontWeight.normal))
                                            ]),

                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  GestureDetector(
                                      onTap: (userBooking[index].done ||
                                              isExpired)
                                          ? null
                                          : () {
                                              Alert(
                                                  context: context,
                                                  type: AlertType.none,
                                                  title: 'ELIMINAR RESERVA',
                                                  desc:
                                                      'Esta reserva también será eliminada de tu calendario',
                                                  buttons: [
                                                    DialogButton(
                                                        child: Text(
                                                          'CANCELAR',
                                                          style: GoogleFonts
                                                              .robotoMono(
                                                                  color: Colors
                                                                      .black),
                                                        ),
                                                        onPressed: () =>
                                                            Navigator.of(
                                                                    context)
                                                                .pop(),
                                                        color: Colors.white),
                                                    DialogButton(
                                                        child: Text(
                                                          'ELIMINAR',
                                                          style: GoogleFonts
                                                              .robotoMono(
                                                                  color: Colors
                                                                      .red),
                                                        ),
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                          cancelBooking(
                                                              context,
                                                              userBooking[
                                                                  index],
                                                              ref);
                                                        },
                                                        color: Colors.white)
                                                  ]).show();
                                            },
                                      child: Container(
                                        color: userBooking[index].done?
                                        Colors.green
                                            : Colors.red,

                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 10),
                                              child: Text(
                                                  userBooking[index].done
                                                      ? 'Servicio Completado'
                                                      : isExpired
                                                          ? 'No Realizado'
                                                          : 'Cancelar Reserva',
                                                  style: GoogleFonts.robotoMono(
                                                      color: isExpired
                                                          ? Colors.black
                                                          : Colors.white)),
                                            )
                                          ],
                                        ),
                                      ))
                                ],
                              ),
                            );
                          });
                    }
                  });
            }
          }
        });
  }

  void cancelBooking(
      BuildContext context, BookingModel bookingModel, WidgetRef ref) {
    var batch = FirebaseFirestore.instance.batch();
    var barberBooking = FirebaseFirestore.instance
        .collection('AllBarbershop')
        .doc(bookingModel.cityBook)
        .collection('Branch')
        .doc(bookingModel.salonId)
        .collection('Barber')
        .doc(bookingModel.barberId)
        .collection(DateFormat('dd_MM_yyyy').format(
            DateTime.fromMillisecondsSinceEpoch(bookingModel.timeStamp)))
        .doc(bookingModel.slot.toString());

    var userBooking = bookingModel.documentReference;

    batch.delete(userBooking);
    batch.delete(barberBooking);

    batch.commit().then((value) {
      //Refrecar Informacion
      Navigator.of(context).pop();
      ref.read(deleteFlagRefresh.state).state =
          !ref.read(deleteFlagRefresh.state).state;
    });
  }
 // updateCalification(totalPrice, services, barberId, barberName, cityBook, customerId, customerFoto, customerName, done, salonAddress, salonId, salonName, slot, time, docId, customerEmail, rating, timeStamp, ref)
  void showRating(BuildContext context,WidgetRef ref, String salonId,String cityName, String barberName,String doc,double totalPrice,String services,
      String barberId,String customerId, String customerFoto,String customerName,bool done,String salonAddress,
  String salonName,int slot,String time,String customerEmail,int  rating,int timeStamp
      )=> showDialog(context: context, builder: (context)=>

      AlertDialog(
        backgroundColor: Colors.blueGrey,
    title: Text('Califica este servicio') ,
    content: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        RatingBar.builder(
        initialRating: 1,
        minRating: 1,
        itemBuilder: (context,_)=>Icon(Icons.star,color:Colors.amber),

        onRatingUpdate: (rating){
          if(rating>= 0.0){

            //ref.watch(selectedBarber.state).state.docId == userBooking[index].barberId;
            print('por aqui paso derwin');
            ref.watch(selectedCalificacion.state).state =rating.toInt();
           print(ref.read(selectedCalificacion.state).state);
           // print(userBooking[index].salonId);

          } else{
            print('rating');
           // print(calificacion);
            showDialogSinPalabras(context);
          }


        },
        updateOnDrag: true,
        itemSize: 30,
        itemPadding: EdgeInsets.symmetric(horizontal: 4)),
        SizedBox(height: 20,),
        TextField(
        controller: _controllerComment,
  maxLines: 5,
  textCapitalization: TextCapitalization.sentences,
  decoration: InputDecoration(
    enabled: true,
    labelText: "Ingresa tu comentario",
    alignLabelWithHint: true,
    hintText: "Escribe tu comentario aqui",
    border: const OutlineInputBorder(),
  ),

)

      ],

    ),actions: [
        ElevatedButton(onPressed: (){

          if( _countWords(text:this._controllerComment.text )>0){

          saveComment(FirebaseAuth.instance.currentUser!.photoURL == null
              ? ref.read(userInformation.state).state.name
              : FirebaseAuth.instance.currentUser!.displayName.toString(),FirebaseAuth.instance.currentUser!.photoURL == null
              ? "https://thumbs.dreamstime.com/b/vector-el-icono-del-avatar-del-usuario-para-el-sitio-web-o-el-m%C3%B3vil-45836554.jpg"
              : FirebaseAuth.instance.currentUser!.photoURL.toString(),this._controllerComment.text.toString(),DateTime.now().toString().substring(0,16),barberId,ref.read(selectedCalificacion.state).state);


          updateCalification(totalPrice, services, barberId, barberName, cityName, customerId, customerFoto, customerName, done,
              salonAddress, salonId, salonName, slot, time, doc, customerEmail, ref.read(selectedCalificacion.state).state, timeStamp,ref);

          this._controllerComment.text ='';
          Navigator.pop(context);
          showDialogSinEstrellas(context);

          }else{
            showDialogSinPalabras(context);
          }



      }, child: Text('Comentar')),
      SizedBox(height: 10,),
      ElevatedButton(onPressed: () {

        this._controllerComment.text ='';
        Navigator.pop(context);
        //Navigator.push(context,
                    //MaterialPageRoute(builder: (context) => AnimationsPackageExample( salonId: salonId,cityName: cityName)));
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => TestMe(cityName:cityName,salonId:salonId,usuario:ref.read(userInformation.state).state.name,name: barberName,foto:'',descripcion:'',like: 0,docId:doc)));
      }, child: Text('ver comentarios'))
],
  ));



  void updateCalification(double totalPrice,String services,String barberId,String barberName,String cityBook,String customerId,String customerFoto,
      String customerName,bool done,String salonAddress,String salonId,String  salonName,int slot,String time,String docId
      ,String customerEmail,int rating,int timeStamp,WidgetRef ref) {

    print('vino a guardar la info');

    BookingModel bookingModel = BookingModel(
        totalPrice: totalPrice,
        services: services,
        barberId: barberId,
        barberName: barberName,
        cityBook:cityBook,
        customerId:customerId,
        customerFoto: customerFoto,
        customerName: customerName,
        done: done,
        salonAddress:salonAddress,
        salonId: salonId,
        salonName: salonName,
        slot:slot ,
        time:time, docId: docId, customerEmail: customerEmail, rating: rating.toInt(), timeStamp: timeStamp);

    var batch = FirebaseFirestore.instance.batch();

    DocumentReference userBooking = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection('Booking_${FirebaseAuth.instance.currentUser!.uid}')
        .doc(
        '${barberId}_${time.substring(22,32).replaceAll("/", "_")}');

    batch.update(userBooking,bookingModel.toJson());
    batch.commit();

  }
  void saveComment(String name, String pic, String message, String dateTime,String doc, int rating) {

    CommentModel commentModel = CommentModel(name: name,
        pic:  pic, message:  message,
        date:  dateTime, rating: rating);

    var batch = FirebaseFirestore.instance.batch();

    DocumentReference comment = FirebaseFirestore.instance
        .collection('AllBarbershop')
        .doc('Cusco')
        .collection('Branch')
        .doc('0ODa6FGIz8zCbVzM2Dwz')
        .collection('Barber')
        .doc(doc).collection('comentarios').doc('0ODa6FGIz8zCbVzM2Dwz${DateTime.now()}');

    batch.set(comment, commentModel.toJson());
    batch.commit();

  }
 int _countWords( {required String text}) {
    final trimmedText =text.trim();
    if(trimmedText.isEmpty){
      return 0;
    }else {
      return trimmedText.split(RegExp("\\s+")).length;
    }
 }

  void showDialogSinEstrellas(BuildContext context) => showDialog(context: context, builder: (context)=>

      AlertDialog(
        backgroundColor: Colors.blueGrey,
        title: Text('Gracias por tu calificación') ,
        content: Text('Te aseguro que tu comentario sera recibido de la mejor manera, para mejorar nuestros servicios.'),actions: [

        ElevatedButton(onPressed: () {

          Navigator.pop(context);

        }, child: Text('Aceptar'))
      ],
      ));
  void showDialogSinPalabras(BuildContext context) => showDialog(context: context, builder: (context)=>

      Center(
        child: AlertDialog(
          backgroundColor: Colors.blueGrey,
          title: Text('No dejaste un comentario') ,
          content: Text('Para calificar el servicio del barbero debes escribir un comentario'),actions: [

          ElevatedButton(onPressed: () {

            Navigator.pop(context);

          }, child: Text('Aceptar')),


        ],
        ),
      ));
}
