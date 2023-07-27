import 'package:barberia/model/image_model.dart';
import 'package:barberia/model/user_model.dart';
import 'package:barberia/screens/barber_booking_history_screen.dart';
import 'package:barberia/screens/done_services_screens.dart';
import 'package:barberia/screens/home.dart';
import 'package:barberia/screens/signin_screen.dart';
import 'package:barberia/screens/user_history_screen.dart';
import 'package:barberia/state/state_management.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../cloud_firestore/all_salon_ref.dart';
import '../model/city_model.dart';
import '../model/salon_model.dart';
import '../utils/utils.dart';
import 'booking_screen.dart';
import 'home_screen.dart';


class StaffHome extends ConsumerWidget {

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    var currentStaffSted = ref.watch(staffStep.state).state;
    var cityWatch = ref.watch(selectedCity.state).state;
    var salonWatch = ref.watch(selectedSalon.state).state;
    var dateWatch = ref.watch(selectedDate.state).state;
    return SafeArea(

        child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text(currentStaffSted==1?'Seleccione Ciudad':currentStaffSted ==2 ? 'Seleccione Barbería':currentStaffSted==3? 'Tus Reservas':'Inicio del Barbero'),
            backgroundColor:const Color(0xFF0E6BAC),
          actions: [
           currentStaffSted == 3 ?InkWell(child: Icon(Icons.history,color: const Color(0xFFEBBEA7),),onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>BarberHistoryScreen())),):Container()
          ],
          ),
          body: Column(children: [
            Expanded(child: currentStaffSted == 1 ?
            displayCity(ref):currentStaffSted == 2 ?
            displaySalon(cityWatch.name,ref ):
        currentStaffSted == 3 ? displayAppoinment(context,ref)
            :Container(),
              flex: 10,),
            Expanded(
                child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                              child: ElevatedButton(
                                onPressed: currentStaffSted == 1
                                    ? null
                                    : () => ref.read(staffStep.state).state--,
                                child: Text('Anterior'),
                              )),
                          const SizedBox(
                            width: 30,
                          ),
                          Expanded(
                              child: ElevatedButton(
                                onPressed: (currentStaffSted == 1 &&
                                    ref
                                        .read(selectedCity.state)
                                        .state
                                        .name.isEmpty) ||
                                    (currentStaffSted == 2 &&
                                        ref
                                            .read(selectedSalon.state)
                                            .state
                                            .docId ==
                                            null) ||
                                    currentStaffSted == 3
                                    ? null
                                    : () =>ref.read(staffStep.state).state++,
                                child: Text('Siguiente'),
                              )),
                        ],
                      ),
                    )))
          ],)
        ));
  }

  displayCity(WidgetRef ref) {
    return FutureBuilder(
        future: getCities(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return Center(
              child: CircularProgressIndicator(),
            );
          else {
            var cities = snapshot.data as List<CityModel>;
            if (cities.length == 0)
              return const Center(
                child: Text('No puede cargar lista de ciudades'),
              );
            else {
              return GridView.builder(
                  itemCount: cities.length,
                  gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2), itemBuilder: (context,index){
                    return GestureDetector(
                      onTap: () => ref.read(selectedCity.state).state = cities[index],
                      child: Padding(padding: const EdgeInsets.all(8) ,
                      child: Card(
                        shape: ref.read(selectedCity.state).state.name==cities[index].name ?
                        RoundedRectangleBorder(side: BorderSide(color:Colors.green,width: 4),
                        borderRadius: BorderRadius.circular(5)):null,
                        child: Center(child:Text('${cities[index].name}') ,),
                      ),
                      )
                    );
              });
            }
          }
        });
  }

  displaySalon(String name, WidgetRef ref) {
    return FutureBuilder(
        future: getSalonByCity(name),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return Center(
              child: CircularProgressIndicator(),
            );
          else {
            var salons = snapshot.data as List<SalonModel>;
            if (salons.length == 0)
              return Center(
                child: Text('No puede cargar lista de barberías'),
              );
            else {
              return ListView.builder(
                  itemCount: salons.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                        onTap: () =>
                        ref.read(selectedSalon.state).state = salons[index],
                        child: Card(
                          color: const Color(0xFF130F0F),
                          child: ListTile(
                            shape: ref.read(selectedSalon.state).state.name==salons[index].name ?
                            RoundedRectangleBorder(side: BorderSide(color:Colors.green,width: 4),
                                borderRadius: BorderRadius.circular(5)):null,
                            leading:
                            Icon(Icons.home_outlined, color: const Color(0xFFEBBEA7)),
                            trailing:
                            ref.read(selectedSalon.state).state.docId ==
                                salons[index].docId
                                ? Icon(Icons.check)
                                : null,
                            title: Text('${salons[index].name}',
                                style: GoogleFonts.robotoMono()),
                            subtitle: Text('${salons[index].address}',
                                style: GoogleFonts.robotoMono(
                                    fontStyle: FontStyle.italic)),
                          ),
                        ));
                  });
            }
          }
        });
  }

  displayAppoinment(BuildContext context, WidgetRef ref) {
    //primero, necesitamos chequear si el usuario es un staff en la barberiia
    return FutureBuilder(
        future:checkStaffOfThisSalon(context,ref),
        builder:(context,snapshot){
          if(snapshot.connectionState == ConnectionState.waiting)
            return Center(child: CircularProgressIndicator(),);
          else {
            var result = snapshot.data as bool;
            print(result);
            if(result) return displaySlot(context,ref);
            else return Text(result ? 'Bienvenido Barbero' : ' Tú no eres un barbero de esta barbería');
          }


        });
    
  }

  displaySlot(BuildContext context, WidgetRef ref) {
    var now = ref.read(selectedDate.state).state;
    return Column(
      children: [
        Container(
          color: const Color(0xFF0E6BAC),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      children: [
                        Text('${DateFormat.MMMM().format(now)}',
                            style: GoogleFonts.robotoMono(color: Colors.white54)),
                        Text(
                          '${now.day}',
                          style: GoogleFonts.robotoMono(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 22),
                        ),
                        Text(
                          '${DateFormat.EEEE().format(now)}',
                          style: GoogleFonts.robotoMono(color: Colors.white54),
                        )
                      ],
                    ),
                  )),
              GestureDetector(
                onTap: () {
                  DatePicker.showDatePicker(context,
                      showTitleActions: true,
                      minTime: DateTime.now(),
                      maxTime: now.add(Duration(days: 31)),
                      onConfirm: (date) =>
                      ref.watch(selectedDate.state).state = date);
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
        Expanded(
            child: FutureBuilder(
                future: getMaxAvailableTimeSlot(ref.read(selectedDate.state).state),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting)
                    return Center(child: CircularProgressIndicator());
                  else {
                    var maxTimeSlot = snapshot.data as int;
                    return FutureBuilder(
                        future: getBookingSlotOfBarber(
                          context,ref,
                            DateFormat('dd_MM_yyyy').format(
                                ref.read(selectedDate.state).state)),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting)
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          else {
                            var listTimeSlot = snapshot.data as List<int>;
                            return GridView.builder(
                                itemCount: TIME_SLOT.length,
                                gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3),
                                itemBuilder: (context, index) =>
                                    GestureDetector(
                                      onTap:
                                          !listTimeSlot.contains(index)
                                          ? null
                                          : () => processDoneServices(context,ref,index),
                                      child: Card(
                                        color: listTimeSlot
                                            .contains(index)
                                            ? Colors.red
                                            : maxTimeSlot > index
                                            ? Colors.white60
                                            : ref
                                            .read(
                                            selectedTime
                                                .state)
                                            .state ==
                                            TIME_SLOT
                                                .elementAt(
                                                index)
                                            ? Colors.blue
                                            : Colors.green,
                                        child: GridTile(
                                          child: Center(
                                            child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment
                                                  .center,
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .center,
                                              children: [
                                                Text(
                                                    '${TIME_SLOT.elementAt(index)}', style: GoogleFonts
                                                    .robotoMono(
                                                    fontSize: 11,
                                                    color: Colors.white,
                                                    fontWeight: FontWeight
                                                        .normal)),
                                                Text(
                                                    listTimeSlot.contains(index)
                                                    ? 'Reservado'
                                                    : maxTimeSlot > index
                                                    ? 'No Disponible'
                                                    : 'Disponible', style: GoogleFonts
                                                    .robotoMono(
                                                    fontSize: 15,
                                                    color: Colors.white,
                                                    fontWeight: FontWeight
                                                        .normal))
                                              ],
                                            ),
                                          ),
                                          header: ref
                                              .read(selectedTime
                                              .state)
                                              .state ==
                                              TIME_SLOT
                                                  .elementAt(index)
                                              ? Icon(Icons.check)
                                              : null,
                                        ),
                                      ),
                                    ));
                          }
                        });

                  }
                }))
      ],
    );

  }

  processDoneServices(BuildContext context, WidgetRef ref, int index) {
    ref
        .read(selectedTimeSlot
        .state)
        .state =
       index;
    
    Navigator.push(context, MaterialPageRoute(builder:(context)=> DoneService()));
  }


}
