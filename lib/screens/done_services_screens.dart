import 'package:barberia/model/booking_model.dart';
import 'package:barberia/state/state_management.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:chips_choice/chips_choice.dart';
import 'package:intl/intl.dart';
import '../cloud_firestore/all_salon_ref.dart';
import '../cloud_firestore/services_ref.dart';
import '../model/service_model.dart';
import '../utils/utils.dart';

class DoneService extends ConsumerWidget {
  GlobalKey<ScaffoldState> scaffoldkey = GlobalKey();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //Cuando refresca , limpiar los servicios seleccionados, porque eleccion no esta en etado hold

    return SafeArea(
        child: Scaffold(
          key: scaffoldkey,
            resizeToAvoidBottomInset: true,
            backgroundColor: Colors.black,
            appBar: AppBar(
              title: const Text('Servicios Realizados'),
              backgroundColor: Colors.blue,
            ),
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: FutureBuilder(
                    future: getDetailBooking(
                        context, ref.read(selectedTimeSlot.state).state, ref),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting)
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      else {
                        var bookingModel = snapshot.data as BookingModel;
                        return Card(
                          color: Colors.blue,
                            elevation: 8,
                            child: Padding(
                                padding: const EdgeInsets.all(8),
                                child: Column(
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                          CircleAvatar(
                                          maxRadius: 25,
                                          child:  ClipOval(
                                              child:  Image.network(bookingModel.customerFoto,fit: BoxFit.fill)
                                          ),

                                        ),
                                        const SizedBox(
                                          width: 30,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '${bookingModel.customerName}',
                                              style: GoogleFonts.robotoMono(
                                                  fontSize: 22,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              '',
                                              style: GoogleFonts.robotoMono(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                    const Divider(
                                      thickness: 2,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Consumer(builder: (context, ref, _) {
                                          var servicesSelected =
                                              ref
                                                  .watch(selectedServices.state)
                                                  .state;
                                          print(servicesSelected);
                                          var totalPrice = servicesSelected
                                              .map((item) => item.price)
                                              .fold(
                                                  0,
                                                  (value, element) =>
                                                      value.toInt()+ element.toInt());
                                          print('Aqui');
                                          print(totalPrice);
                                          return Text(
                                            'Precio \S/ ${ref.read(selectedBooking.state).state.totalPrice == 0 ? totalPrice : ref.read(selectedBooking.state).state.totalPrice } ',
                                            style: GoogleFonts.robotoMono(
                                                fontSize: 22),
                                          );
                                        }),
                                        ref.read(selectedBooking.state).state.done ? Chip(label: Text('Finalizado')) : Container()
                                      ],
                                    ),


                                  ],
                                )));
                      }
                    },
                  ),
                ),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: FutureBuilder(
                    future: getServices(context,ref),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting)
                        return const Center(child: CircularProgressIndicator());
                      else {

                        var options = snapshot.data as List<ServiceModel>;
                        print('son los servicios');

                        print(options.length);
                        print(options);
                        return Consumer(
                          builder: (context, watch, _) {
                            var servicesWatch =
                                ref.watch(selectedServices.state).state;

                            return SingleChildScrollView(
                              child: Column(children: [
                                ChipsChoice<ServiceModel>.multiple(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  wrapped: true,
                                  value: servicesWatch,
                                  onChanged: (val) =>  ref.watch(selectedServices.state).state = val,
                                  choiceActiveStyle: C2ChoiceStyle(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                  ),
                                  choiceStyle:  const C2ChoiceStyle(
                                      elevation: 8,
                                      showCheckmark: true,
                                      borderRadius: BorderRadius.all(Radius.circular(15))),
                                  choiceItems: C2Choice.listFrom<ServiceModel,
                                      ServiceModel>(
                                      source: options,
                                      value: (index, value) => value,
                                      label: (index, value) =>
                                      '${value.name} (\S/ ${value.price})'),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width,

                                  child: ElevatedButton(
                                    onPressed: servicesWatch.length>0?()=>clearService(context,ref):null,
                                    child: Text('LIMPIAR SERVICIOS',style: GoogleFonts.robotoMono(),),
                                  ),
                                ),  Container(
                                  width: MediaQuery.of(context).size.width,

                                  child: ElevatedButton(
                                    onPressed: ref.read(selectedBooking.state).state.done? null : servicesWatch.length>0
                                        ?() => finishService(context,ref): null,
                                    child: Text('FINALIZAR',style: GoogleFonts.robotoMono(),),
                                  ),
                                )
                              ],)
                            );
                          },
                        );
                      }
                    },
                  ),
                ))
              ],
            )));
  }

  finishService(BuildContext context, WidgetRef ref) {
    //Im
    var batch = FirebaseFirestore.instance.batch();
    var barberBook = ref.read(selectedBooking.state).state;
    var userBook = FirebaseFirestore.instance
    .collection('users')
    .doc('${barberBook.customerId}')
    .collection('Booking_${barberBook.customerId}')
    .doc('${barberBook.barberId}_${DateFormat('dd_MM_yyyy').format(DateTime.fromMillisecondsSinceEpoch(barberBook.timeStamp))}');

    Map<String,dynamic> updateDone = new Map();
    updateDone['done']=true;
    updateDone['services'] = convertServices(ref.read(selectedServices.state).state);
    updateDone['totalPrice']=ref.read(selectedServices.state).state
    .map((e) => e.price).fold(0, (previousValue, element) => previousValue.toInt()+element.toInt());

    batch.update(userBook, updateDone);
    batch.update(barberBook.documentReference, updateDone);
    
    batch.commit().then((value) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Servicio completado Exitosamente'))).closed
      .then((value) => Navigator.of(context).pop());
    });
  }

  clearService(BuildContext context, WidgetRef ref) {
    ref.read(selectedServices.state).state.clear();
  }
}
