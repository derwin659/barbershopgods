import 'package:barberia/model/booking_model.dart';
import 'package:barberia/state/staff_user_history_state.dart';
import 'package:barberia/state/state_management.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../cloud_firestore/user_ref.dart';
import '../state/staff_users_history_state.dart';
import '../utils/utils.dart';


class BarberHistoryScreen extends ConsumerWidget {


  @override
  Widget build(BuildContext context, WidgetRef ref) {

    String notificationMesg="Esperando notificationes";
    var dateWatch = ref
        .watch(barberHistorySelectedDate.state)
        .state;
    var cityWatch = ref
        .watch(selectedCity.state)
        .state;
    var currentStaffStep = ref
        .watch(staffStep.state)
        .state;
    var salonWatch = ref
        .watch(barberHistorySelectedDate.state)
        .state;

    FirebaseMessaging.onMessage.listen((event) {
      notificationMesg= "${event.notification!.title} ${event.notification!.body}  aaaaaaaaaaaaaaaaaaaaaaaaaa";
      print(notificationMesg);
    });
    return SafeArea(
        child: Scaffold(resizeToAvoidBottomInset: true,

          backgroundColor: Color(0x0A0101FF),
          appBar: AppBar(
            title: Text('Historial de Reservas'),
            backgroundColor:Colors.blue,
          ),
          body: Column(children: [
            Container(
              color: Colors.blue,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          children: [
                            Text('${DateFormat.MMMM().format(dateWatch)}',
                                style: GoogleFonts.robotoMono(
                                    color: Colors.white54)),
                            Text(
                              '${dateWatch.day}',
                              style: GoogleFonts.robotoMono(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22),
                            ),
                            Text(
                              '${DateFormat.EEEE().format(dateWatch)}',
                              style: GoogleFonts.robotoMono(
                                  color: Colors.white54),
                            )
                          ],
                        ),
                      )),
                  GestureDetector(
                    onTap: () {
                      DatePicker.showDatePicker(context,
                          showTitleActions: true,
                          onConfirm: (date) =>
                          ref
                              .watch(barberHistorySelectedDate.state)
                              .state = date);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Icon(Icons.calendar_month, color: Colors.white),
                      ),
                    ),
                  )
                ],
              ),
            ),
          Expanded(child:
             FutureBuilder(

              future: getBarberBookingHistory(context, dateWatch, ref),
        builder: (context, snapshot) {
                print(dateWatch);
                print(ref.read(selectedCity.state).state.name);
          print(ref.read(selectedSalon.state).state.documentReference.id);
                print(FirebaseAuth.instance.currentUser!.uid);
          if (snapshot.connectionState == ConnectionState.waiting)
            return const Center(
                child: CircularProgressIndicator()
            );
          else {
            var userBooking = snapshot.data as List<BookingModel>;
            print(userBooking.length);
            if ( userBooking.length==0)
              return const Center(

                child: Text('No tienes reserva para esta fecha '),
              );
            else {
              return FutureBuilder(
                  future: syncTime(),
                  builder: (context,snapshot){
                    if(snapshot.connectionState == ConnectionState.waiting)
                      return const Center(child:CircularProgressIndicator());
                    else{
                      var syncTime = snapshot.data as DateTime;
                      return  ListView.builder(
                          itemCount: userBooking.length,
                          itemBuilder: (context, index) {
                            var isExpired = DateTime.fromMillisecondsSinceEpoch(userBooking[index].timeStamp)
                                .isBefore(syncTime);
                            return Card(
                              color: const Color(0xFF844454),
                              elevation: 8,
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(22))),
                              child: Column(
                                children: [
                                  Padding(padding: const EdgeInsets.all(12),
                                    child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
                                          Column(children: [
                                            Text('Fecha',style: GoogleFonts.robotoMono(),),
                                            Text(DateFormat("dd/MM/yy").format(
                                                DateTime.fromMillisecondsSinceEpoch(userBooking[index].timeStamp)
                                            ),style: GoogleFonts.robotoMono(fontSize: 22,fontWeight:FontWeight.bold ),)
                                          ] ),
                                          Column(children: [
                                            Text('Hora del Servicio',style: GoogleFonts.robotoMono(),),
                                            Text(TIME_SLOT.elementAt(userBooking[index].slot),style: GoogleFonts.robotoMono(fontSize: 22,fontWeight:FontWeight.bold ),)
                                          ] )
                                        ],),
                                        const Divider(thickness: 1,),
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  '${userBooking[index].salonName}',
                                                  style: GoogleFonts.robotoMono(
                                                      fontSize: 20,
                                                      fontWeight: FontWeight.bold
                                                  ),
                                                ),
                                                Text(
                                                  '${userBooking[index].customerName}',
                                                  style: GoogleFonts.robotoMono(),
                                                )
                                              ],
                                            ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                '${userBooking[index].salonAddress}',
                                                style: GoogleFonts.robotoMono(),
                                              ),
                                              Text(
                                                '${userBooking[index].done==true?"Servicio Completado":"Servicio por finalizar"}',
                                                style: GoogleFonts.robotoMono(),
                                              )
                                            ],
                                          ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  '${userBooking[index].services}',
                                                  style: GoogleFonts.robotoMono(fontSize: 12),
                                                ),
                                              ],
                                            )
                                          ],
                                        )
                                      ],),),
                                ],
                              ),
                            );
                          });
                    }
                  });
            }
          }
        }))

          ],),
        ));
  }

  Future<List<BookingModel>> getBarberBookingHistory(BuildContext context, DateTime dateTime, WidgetRef ref) async {
    var listBooking = List<BookingModel>.empty(growable: true);
    var barberDocument =FirebaseFirestore.instance.collection('AllBarbershop')
        .doc('${ref.read(selectedCity.state).state.name}')
        .collection('Branch')
        .doc('${ref.read(selectedSalon.state).state.docId}')
        .collection('Barber')
        .doc('${FirebaseAuth.instance.currentUser?.uid}')
        .collection(DateFormat('dd_MM_yyyy').format(dateTime));
    print('barberDocument');

    var snapshot = await barberDocument.get();
    print(snapshot);
    snapshot.docs.forEach((element) {
      var barberBooking = BookingModel.fromJson(element.data());
      barberBooking.docId = element.id;
      barberBooking.documentReference = element.reference;
      listBooking.add(barberBooking);
    });
    return listBooking;

  }

}