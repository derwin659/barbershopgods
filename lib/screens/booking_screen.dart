import 'package:barberia/fcm/notification_send.dart';
import 'package:barberia/model/booking_model.dart';
import 'package:barberia/model/city_model.dart';
import 'package:barberia/model/notifiction_payload_model.dart';
import 'package:barberia/model/salon_model.dart';
import 'package:barberia/screens/user_history_screen.dart';
import 'package:barberia/screens/videos_barberia.dart';
import 'package:barberia/state/state_management.dart';
import 'package:barberia/utils/utils.dart';
import 'package:barberia/widgets/my_loading_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:im_stepper/stepper.dart';
import 'package:intl/intl.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:like_button/like_button.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:url_launcher/url_launcher.dart';
import '../cloud_firestore/all_salon_ref.dart';
import '../cloud_firestore/user_ref.dart';
import '../model/barber_model.dart';
import '../model/user_model.dart';
import 'TrabajosRealizados.dart';
import 'home_screen.dart';
import 'loading_screens.dart';

class BookingScren extends ConsumerWidget {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  bool isLiked = false;
  bool meGusta = false;
  int likeCount = 0;
  bool hasBackrground = false;
  final animationDuration = Duration(milliseconds: 1000);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var step = ref.watch(currentStep.state).state;
    var cityWatch = ref.watch(selectedCity.state).state;

    var salonWatch = ref.watch(selectedSalon.state).state;

    var barberWatch = ref.watch(selectedBarber.state).state;

    var dateWatch = ref.watch(selectedDate.state).state;

    var timWatch = ref.watch(selectedTime.state).state;
    var timeSlotWatch = ref.watch(selectedTimeSlot.state).state;

    var isLoadingWatch = ref.watch(isLoading.state).state;

    return SafeArea(
        child: Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              title: Text(step == 1
                  ? 'Seleccione Ciudad'
                  : step == 2
                      ? 'Seleccione Barbería'
                      : step == 3
                          ? 'Selecciona tu barbero favorito'
                          : step == 4
                              ? 'Selecciona fecha del corte'
                              : 'Confirma tu reserva'),
              backgroundColor: Colors.blue,
            ),
            resizeToAvoidBottomInset: true,
            backgroundColor:  Colors.white,
            body: Column(
              children: [
                //Step
                NumberStepper(
                  activeStep: step - 1,
                  direction: Axis.horizontal,
                  enableNextPreviousButtons: true,
                  enableStepTapping: false,
                  numbers: const [1, 2, 3, 4, 5],
                  stepColor: const Color(0XFF130F0F),
                  activeStepColor: const Color(0xFFDCE0E1),
                  numberStyle: const TextStyle(color: Colors.white),
                ),
                //Screen
                Expanded(
                    flex: 10,
                    child: step == 1
                        ? displayCityList(ref)
                        : step == 2
                            ? displaySalon(cityWatch.name, ref)
                            : step == 3
                                ? displayBarber(
                                    salonWatch, ref, cityWatch, barberWatch)
                                : step == 4
                                    ? displayTimeSlot(context, barberWatch, ref)
                                    : step == 5
                                        ? isLoadingWatch
                                            ? MyLoadingWidget(
                                                text:
                                                    'Estamos configurando tu reserva!')
                                            : displayConfirm(context, ref)
                                        : Container()),
                //Button
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
                                onPressed: step == 1
                                    ? null
                                    : () => ref.read(currentStep.state).state--,
                                child: Text('Anterior'),
                              )),
                              const SizedBox(
                                width: 30,
                              ),
                              Expanded(
                                  child: ElevatedButton(
                                onPressed: (step == 1 &&
                                            ref
                                                .read(selectedCity.state)
                                                .state
                                                .name
                                                .isEmpty) ||
                                        (step == 2 &&
                                            ref
                                                    .read(selectedSalon.state)
                                                    .state
                                                    .docId ==
                                                null) ||
                                        (step == 3 &&
                                            ref
                                                    .read(selectedBarber.state)
                                                    .state
                                                    .docId ==
                                                null) ||
                                        (step == 4 &&
                                            ref
                                                    .read(
                                                        selectedTimeSlot.state)
                                                    .state ==
                                                -1)
                                    ? null
                                    : step == 5
                                        ? null
                                        : () =>
                                            ref.read(currentStep.state).state++,
                                child: Text('Siguiente'),
                              )),
                            ],
                          ),
                        )))
              ],
            )));
  }

  displayCityList(WidgetRef ref) {
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
              return ListView.builder(
                  itemCount: cities.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                        onTap: () =>
                            ref.read(selectedCity.state).state = cities[index],
                        child: Container(
                          alignment: Alignment.center,
                          child: Column(
                            children: [
                              Card(
                                color: const Color(0xFF130F0F),
                                child: ListTile(
                                    leading: Icon(Icons.home_work,
                                        color: Colors.white),
                                    trailing: ref
                                                .read(selectedCity.state)
                                                .state
                                                .name ==
                                            cities[index].name
                                        ? Icon(Icons.check)
                                        : null,
                                    title: Text('${cities[index].name}',
                                        style: GoogleFonts.courgette(
                                            fontSize: 25,
                                            fontWeight:
                                            FontWeight.normal))),
                              ),
                            ],
                          ),
                        ));
                  });
            }
          }
        });
  }

  displaySalon(String cityName, WidgetRef ref) {
    return FutureBuilder(
        future: getSalonByCity(cityName),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return Center(
              child: CircularProgressIndicator(),
            );
          else {
            var salons = snapshot.data as List<SalonModel>;
            if (salons.length == 0)
              return Center(
                child: Text('No puede cargar lista de barberías',style: GoogleFonts.courgette(
                    fontSize: 25,
                    fontWeight:
                    FontWeight.normal),),
              );
            else {
              return ListView.builder(
                  itemCount: salons.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                        onTap: () =>
                            ref.read(selectedSalon.state).state = salons[index],
                        child: Column(
                          children: [
                            Card(
                              color: const Color(0xFF130F0F),
                              child: ListTile(
                                leading: Icon(Icons.home_outlined,
                                    color: Colors.white),
                                trailing:
                                    ref.read(selectedSalon.state).state.docId ==
                                            salons[index].docId
                                        ? Icon(Icons.check)
                                        : null,
                                title: Text('${salons[index].name}',
                                    style: GoogleFonts.courgette(
                                        fontSize: 25,
                                        fontWeight:
                                        FontWeight.bold)),
                                subtitle: Text('${salons[index].address}',
                                    style: GoogleFonts.courgette(
                                        fontSize: 20,
                                        fontWeight:
                                        FontWeight.normal)),
                              ),
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(salons[index].foto),
                            ),
                          ],
                        ));
                  });
            }
          }
        });
  }

  displayBarber(SalonModel salonModel, WidgetRef ref, CityModel cityModel,
      BarberModel barberModel) {
    return FutureBuilder(
        future: getBarbersBySalon(salonModel),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return Center(
              child: CircularProgressIndicator(),
            );
          else {
            var barbers = snapshot.data as List<BarberModel>;
            if (barbers.length == 0)
              return Center(
                child: Text('Lista de barberos se encuentra vació'),
              );
            else {
              return ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: barbers.length,
                  itemBuilder: (context, index) {
                    return Column(children: [
                      GestureDetector(
                          onTap: () => ref.read(selectedBarber.state).state =
                              barbers[index],
                          child: Column(
                            children: [
                              Card(
                                  color: Colors.blueGrey,
                                  child: ListTile(
                                    leading: GestureDetector(
                                      onTap: ()=>_showSecondPage(context,barbers[index].foto),
                                      child:  Hero(
                                        tag: 'my-kero-animation-tag',
                                        child: CircleAvatar(
                                          backgroundImage: NetworkImage("${barbers[index].foto}"),
                                        ),
                                      ),
                                    ),
                                    trailing: ref
                                                .read(selectedBarber.state)
                                                .state
                                                .docId ==
                                            barbers[index].docId
                                        ? Icon(Icons.check)
                                        : null,
                                    title: Text('${barbers[index].name}',
                                        style: GoogleFonts.courgette(
                                            fontSize: 25,
                                            fontWeight:
                                            FontWeight.normal)),
                                    subtitle: RatingBar.builder(
                                      itemSize: 20,
                                      allowHalfRating: true,
                                      initialRating: barbers[index].rating,
                                      ignoreGestures: true,
                                      direction: Axis.horizontal,
                                      itemCount: 5,
                                      itemBuilder: (context, _) =>
                                          Icon(Icons.star, color: Colors.amber),
                                      itemPadding: const EdgeInsets.all(4),
                                      onRatingUpdate: (value) {},
                                    ),
                                  )),
                              Container(
                                margin: EdgeInsets.all(12),
                                child: Text(barbers[index].descripcion,
                                    style: GoogleFonts.courgette(
                                        fontSize: 18,
                                        fontWeight:
                                        FontWeight.normal,color: Colors.black),
                                    textAlign: TextAlign.justify),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                            ],
                          )),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () {  },
                            child: LikeButton(
                                animationDuration: animationDuration,
                                onTap: onLikeButtonTapped,
                                size: 30,
                                likeBuilder: (isLiked) {
                                  print('derwin');
                                  print(isLiked);
                                  if (isLiked) {
                                    saveLiked(
                                        isLiked,
                                        cityModel,
                                        salonModel,
                                        barberModel,
                                        ref,
                                        barbers[index].like,
                                        barbers[index].docId.toString());
                                  } else {
                                    saveLiked(
                                        isLiked,
                                        cityModel,
                                        salonModel,
                                        barberModel,
                                        ref,
                                        barbers[index].like - 1,
                                        barbers[index].docId.toString());
                                  }
                                  return Icon(
                                    Icons.thumb_up,
                                    size: 30,
                                  );
                                },
                                likeCountPadding: const EdgeInsets.all(8.0),
                                likeCount: barbers[index].like,
                                isLiked: isLiked,
                                countBuilder: (likeCount, isLiked, text) {
                                  if (likeCount == 0) {
                                    return Text('like');
                                  } else {
                                    return Text(
                                      likeCount! >= 1000
                                          ? '${(likeCount / 1000.0).toStringAsFixed(1)}k'
                                          : text,
                                    );
                                  }
                                }),
                          ),
                          SizedBox(
                            width: 40,
                          ),
                          ElevatedButton(
                            onPressed: () {  },
                            child: LikeButton(
                                animationDuration: animationDuration,
                                size: 30,
                                likeCount: barbers[index].meGusta,
                                isLiked: false,
                                likeBuilder: (meGusta) {
                                  print('derwin');
                                  print(meGusta);
                                  if (meGusta) {
                                    saveLikedMeGusta(
                                        meGusta,
                                        cityModel,
                                        salonModel,
                                        barberModel,
                                        ref,
                                        barbers[index].meGusta,
                                        barbers[index].docId.toString());
                                  } else {
                                    saveLikedMeGusta(
                                        meGusta,
                                        cityModel,
                                        salonModel,
                                        barberModel,
                                        ref,
                                        barbers[index].meGusta - 1,
                                        barbers[index].docId.toString());
                                  }
                                },
                                countBuilder: (likeCount, isLiked, text) {
                                  if (likeCount == 0) {
                                    return Text('Me Gusta');
                                  } else {
                                    return Text(
                                      likeCount! >= 1000
                                          ? '${(likeCount / 1000.0).toStringAsFixed(1)}k'
                                          : text,
                                    );
                                  }
                                }),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: Stack(
                          children: <Widget>[
                            Positioned.fill(
                              child: Container(
                                decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: <Color>[
                                      Color(0xFF0D47A1),
                                      Color(0xFF1976D2),
                                      Color(0xFF42A5F5),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            TextButton(
                              style: TextButton.styleFrom(
                                foregroundColor: Colors.white.withBlue(4),
                                padding: const EdgeInsets.all(8.0),
                                textStyle: const TextStyle(fontSize: 20),
                              ),
                              onPressed: () {
                                ref.watch(selectedBarber.state).state.docId = barbers[index].docId.toString();
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>TrabajosRealizadosPage()));
                              },
                              child: const Text('MIS TRABAJOS REALIZADOS'),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                    ]);
                  });
            }
          }
        });
  }

  displayTimeSlot(
      BuildContext context, BarberModel barberModel, WidgetRef ref) {
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
                        style: GoogleFonts.robotoMono(
                            color:Colors.white)),
                    Text(
                      '${now.day}',
                      style: GoogleFonts.robotoMono(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 22),
                    ),
                    Text(
                      '${DateFormat.EEEE().format(now)}',
                      style: GoogleFonts.robotoMono(
                          color: Colors.white),
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
                    child: Icon(Icons.calendar_month,
                        color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        ),
        Expanded(
            child: FutureBuilder(
                future:
                    getMaxAvailableTimeSlot(ref.read(selectedDate.state).state),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting)
                    return Center(child: CircularProgressIndicator());
                  else {
                    var maxTimeSlot = snapshot.data as int;
                    return FutureBuilder(
                        future: getTimeSlotOfBarber(
                            barberModel,
                            DateFormat('dd_MM_yyyy')
                                .format(ref.read(selectedDate.state).state)),
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
                                      onTap: maxTimeSlot > index ||
                                              listTimeSlot.contains(index)
                                          ? null
                                          : () {
                                              ref
                                                      .read(selectedTime.state)
                                                      .state =
                                                  TIME_SLOT.elementAt(index);
                                              ref
                                                  .read(selectedTimeSlot.state)
                                                  .state = index;
                                            },
                                      child: Card(
                                        color: listTimeSlot.contains(index)
                                            ? Colors.red
                                            : maxTimeSlot > index
                                                ? Colors.white60
                                                : ref
                                                            .read(selectedTime
                                                                .state)
                                                            .state ==
                                                        TIME_SLOT
                                                            .elementAt(index)
                                                    ? Colors.blue
                                                    : Colors.green,
                                        child: GridTile(
                                          child: Center(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                    '${TIME_SLOT.elementAt(index)}',
                                                    style:
                                                    GoogleFonts.courgette(
                                                        fontSize: 13,
                                                        fontWeight:
                                                        FontWeight.bold)),
                                                Text(
                                                    listTimeSlot.contains(index)
                                                        ? 'Reservado'
                                                        : maxTimeSlot > index
                                                            ? 'No Disponible'
                                                            : 'Disponible',
                                                    style:
                                                    GoogleFonts.courgette(
                                                        fontSize: 18,
                                                        fontWeight:
                                                        FontWeight.normal))
                                              ],
                                            ),
                                          ),
                                          header: ref
                                                      .read(selectedTime.state)
                                                      .state ==
                                                  TIME_SLOT.elementAt(index)
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

  confirmBooking(BuildContext context, WidgetRef ref) {
    var hour = int.parse(
        ref.read(selectedTime.state).state.split(':')[0].substring(0, 2));
    var min = int.parse(
        ref.read(selectedTime.state).state.split(':')[1].substring(0, 2));

    print(hour);
    print(min);

    var timeStamp = DateTime(
      ref.read(selectedDate.state).state.year,
      ref.read(selectedDate.state).state.month,
      ref.read(selectedDate.state).state.day,
      int.parse(
        ref.read(selectedTime.state).state.split(':')[0].substring(0, 2),
      ), //Hora
      int.parse(
        ref.read(selectedTime.state).state.split(':')[1].substring(0, 2),
      ), //min
    ).millisecondsSinceEpoch;

    //Crear model de reservas

    var bookingModel = BookingModel(
        totalPrice: 0,
        services: '',
        barberId: ref.read(selectedBarber.state).state.docId.toString(),
        barberName: ref.read(selectedBarber.state).state.name,
        cityBook: ref.read(selectedCity.state).state.name,
        customerId: FirebaseAuth.instance.currentUser!.uid,
        customerFoto: FirebaseAuth.instance.currentUser!.photoURL == null
            ? "https://thumbs.dreamstime.com/b/vector-el-icono-del-avatar-del-usuario-para-el-sitio-web-o-el-m%C3%B3vil-45836554.jpg"
            : FirebaseAuth.instance.currentUser!.photoURL.toString(),
        customerName: FirebaseAuth.instance.currentUser!.photoURL == null
            ? ref.read(userInformation.state).state.name
            : FirebaseAuth.instance.currentUser!.displayName.toString(),
        customerEmail: FirebaseAuth.instance.currentUser!.photoURL == null
            ? ref.read(userInformation.state).state.email
            : FirebaseAuth.instance.currentUser!.email.toString(),
        done: false,
        salonAddress: ref.read(selectedSalon.state).state.address,
        salonId: ref.read(selectedSalon.state).state.docId.toString(),
        salonName: ref.read(selectedSalon.state).state.name,
        slot: ref.read(selectedTimeSlot.state).state,
        time:
            '${ref.read(selectedTime.state).state}  -  ${DateFormat('dd/MM/yyyy').format(ref.read(selectedDate.state).state)}',
        timeStamp: timeStamp,
        docId: ref.read(selectedBarber.state).state.docId, rating: 0);

    var batch = FirebaseFirestore.instance.batch();

    DocumentReference barberBooking = ref
        .read(selectedBarber.state)
        .state
        .documentReference
        .collection(
            '${DateFormat('dd_MM_yyyy').format(ref.read(selectedDate.state).state)}')
        .doc(ref.read(selectedTimeSlot.state).state.toString());

    DocumentReference userBooking = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection('Booking_${FirebaseAuth.instance.currentUser!.uid}')
        .doc(
            '${ref.read(selectedBarber.state).state.docId}_${DateFormat('dd_MM_yyyy').format(ref.read(selectedDate.state).state)}');

    //Seteo batch

    batch.set(barberBooking, bookingModel.toJson());
    batch.set(userBooking, bookingModel.toJson());
    batch.commit().then((value) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.orange,
        content: Text('Reserva Completada con Éxito'),
      ));
      ref.read(isLoading.state).state = true;
      print('/topics/${ref.read(selectedBarber.state).state.docId!}');
      //print('${FirebaseMessaging.instance.getToken().subscribeToTopic(ref.read(selectedBarber.state).state.docId!)}');
      var notificationPayload = NotificationPayloadModel(
          to: '/topics/${ref.read(selectedBarber.state).state.docId!}',
          notification: NotificationContent(
              title:
                  'Tienes una Nueva Reserva ${ref.read(selectedBarber.state).state.name}',
              body:
                  'La reserva fue realizada por  ${FirebaseAuth.instance.currentUser!.photoURL == null ? ref.read(userInformation.state).state.name : FirebaseAuth.instance.currentUser!.displayName.toString()}'));

      sendNotification(notificationPayload).then((value) {
        ref.read(isLoading.state).state = false;
        Navigator.of(context).pop();

//Crear evento del calendario
        final event = Event(
            timeZone: 'Zona horaria de Lima (GMT-5)',
            title: 'Reserva de Cortes en Barbershop gods',
            description:
                'Reserva de Cortes en Barbershop gods ${ref.read(selectedDate.state).state.toString()} -'
                '${DateFormat('dd/MM/yyyy').format(ref.read(selectedDate.state).state).toString()}',
            location:
                '${ref.read(selectedSalon.state).state.address.toString()}',
            allDay: false,
            startDate: DateTime(
              ref.read(selectedDate.state).state.year,
              ref.read(selectedDate.state).state.month,
              ref.read(selectedDate.state).state.day,
              hour,
              min,
            ),
            endDate: DateTime(
              ref.read(selectedDate.state).state.year,
              ref.read(selectedDate.state).state.month,
              ref.read(selectedDate.state).state.day,
              hour,
              min + 30,
            ),
            iosParams: IOSParams(reminder: Duration(minutes: 30)),
            androidParams: AndroidParams(emailInvites: []));
        Add2Calendar.addEvent2Cal(event).then((value) {});
        //Reset Value
        ref.read(selectedDate.state).state = DateTime.now();
        ref.read(selectedBarber.state).state = BarberModel(
            name: '',
            rating: 0,
            ratingTimes: 0,
            foto: '',
            descripcion: '',
            like: 0,
            meGusta: 0);
        ref.read(selectedCity.state).state = CityModel(name: '');
        ref.read(selectedSalon.state).state =
            SalonModel(name: '', address: '', foto: '');
        ref.read(currentStep.state).state = 1;

        ref.read(selectedTimeSlot.state).state = -1;
      });
    });

    launchWhasapt(
        number:"+51958062847",
        message: "¡Hola he realizado una reserva con ${ref.read(selectedBarber.state).state.name}, "
            "y tengo una consulta!");
  }

  displayConfirm(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Image.asset('assets/images/logog.png'),
            )),
        Expanded(
            flex: 3,
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Card(
                color: const Color(0xFF0E6BAC),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Text(
                          'Felicidades!!!!',
                          style: GoogleFonts.courgette(
                              fontSize: 25,
                              fontWeight:
                              FontWeight.bold),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Ahora solo debes confirmar la reserva!!',
                          style: GoogleFonts.courgette(
                              fontSize: 18,
                              fontWeight:
                              FontWeight.normal),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Recuerda asistir a tu reserva 10 minutos antes para no perder la reserva, y aprovechar de nuestros cortes',
                          style: GoogleFonts.courgette(
                              fontSize: 18,
                              fontWeight:
                              FontWeight.normal),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Información de la reserva',
                          style: GoogleFonts.courgette(
                              fontSize: 25,
                              fontWeight:
                              FontWeight.normal)),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Icon(Icons.calendar_today),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                                '${ref.read(selectedTime.state).state}   -  ${DateFormat('dd/MM/yyyy').format(ref.read(selectedDate.state).state)}')
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Icon(Icons.person),
                            SizedBox(
                              width: 20,
                            ),
                            Flexible(
                                child: Text(
                              'Barbero favorito: ${ref.read(selectedBarber.state).state.name}'
                                  ,
                              style: GoogleFonts.courgette(
                                  fontSize: 18,
                                  fontWeight:
                                  FontWeight.normal),
                            ))
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Divider(
                          thickness: 1,
                        ),
                        Row(
                          children: [
                            Icon(Icons.home,color: Colors.white,),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              '${ref.read(selectedSalon.state).state.name}'
                                 ,
                              style:GoogleFonts.courgette(
                                  fontSize: 18,
                                  fontWeight:
                                  FontWeight.normal),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Icon(Icons.location_on),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              '${ref.read(selectedSalon.state).state.address}'
                                  ,
                              style: GoogleFonts.courgette(
                                  fontSize: 18,
                                  fontWeight:
                                  FontWeight.normal),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        ElevatedButton(
                          onPressed: () => confirmBooking(context, ref),
                          child: Text(
                            'Confirmar',
                            style: GoogleFonts.robotoMono(
                                fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.red)),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ))
      ],
    );
  }

  saveLiked(
    bool isLiked,
    CityModel cityModel,
    SalonModel salonModel,
    BarberModel barberModel,
    WidgetRef ref,
    int like,
    String docId,
  ) {
    var batch = FirebaseFirestore.instance.batch();

    print('isLiked');
    print(isLiked);

    var barberModelUpdate = BarbeModelUpdate(like: like + 1);
    var barberRef = FirebaseFirestore.instance
        .collection('AllBarbershop')
        .doc(cityModel.name)
        .collection('Branch')
        .doc(salonModel.docId)
        .collection('Barber')
        .doc(docId);
    print(barberRef.toString());

    batch.update(barberRef, barberModelUpdate.toJson());
    batch.commit();
  }

  saveLikedMeGusta(
    bool isLiked,
    CityModel cityModel,
    SalonModel salonModel,
    BarberModel barberModel,
    WidgetRef ref,
    int meGusta,
    String docId,
  ) {
    var batch = FirebaseFirestore.instance.batch();

    print('meGusta');
    print(meGusta);

    var barberModelUpdate = BarbeModelUpdateMegusta(meGusta: meGusta + 1);
    var barberRef = FirebaseFirestore.instance
        .collection('AllBarbershop')
        .doc(cityModel.name)
        .collection('Branch')
        .doc(salonModel.docId)
        .collection('Barber')
        .doc(docId);
    print(barberRef.toString());

    batch.update(barberRef, barberModelUpdate.toJson());
    batch.commit();
  }

  Future<bool> onLikeButtonTapped(bool isLiked) async {
    /// send your request here
    // final bool success= await sendRequest();

    /// if failed, you can do nothing
    // return success? !isLiked:isLiked;

    return !isLiked;
  }



  void launchWhasapt( {@required number,@required message}) async {
    String uri="whatsapp://send?phone=$number&text=$message";

    await canLaunch(uri) ? launch(uri) : print("No puede abrir whasapt");
  }

  _showSecondPage(BuildContext context,String foto) {
    MaterialPageRoute(
      builder: (ctx)=>Scaffold(
        appBar: AppBar(title: Text('Foto'),),
        body: Center(
          child: Hero(
            tag: 'my-kero-animation-tag',
            child: Image.network(foto),
          ),
        ),
      )
    );
  }


}
