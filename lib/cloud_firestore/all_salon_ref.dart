

import 'dart:convert';

import 'package:barberia/model/booking_model.dart';
import 'package:barberia/model/comment_model.dart';
import 'package:barberia/model/salon_model.dart';
import 'package:barberia/state/state_management.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../model/barber_model.dart';
import '../model/city_model.dart';


Future<List<CityModel>> getCities() async{

  var cities = new List<CityModel>.empty(growable: true);
  var cityRef = FirebaseFirestore.instance.collection('AllBarbershop');
  var snapshot = await cityRef.get();
  snapshot.docs.forEach((element) {
    cities.add(CityModel.fromJson(element.data() as Map<String, dynamic>));
  });

  return cities;
}

Future<List<SalonModel>> getSalonByCity(String cityName) async{

  var salons = new List<SalonModel>.empty(growable: true);
  var salonRef = FirebaseFirestore.instance.collection('AllBarbershop').doc(cityName.replaceAll(' ', '')).collection('Branch');
  var snapshot = await salonRef.get();
  snapshot.docs.forEach((element) {
    var salon= SalonModel.fromJson(element.data() as Map<String, dynamic>);
    salon.docId = element.id;
    salon.documentReference = element.reference;
    salons.add(salon);
  });

  return salons;
}

Future<List<BarberModel>> getBarbersBySalon(SalonModel salonModel) async{

  var barbers = new List<BarberModel>.empty(growable: true);
  var barbersRef = salonModel.documentReference.collection('Barber');
  var snapshot = await barbersRef.get();
  snapshot.docs.forEach((element) {
    var barber= BarberModel.fromJson(element.data() as Map<String, dynamic>);
    barber.docId = element.id;
    barber.documentReference = element.reference;
    barbers.add(barber);
  });

  return barbers;
}

Future<List<BarberModel>> getBarbersBySalonD(String  salonId,String cityName) async{

  var barbers = new List<BarberModel>.empty(growable: true);
  var barbersRef = FirebaseFirestore.instance
      .collection('AllBarbershop')
      .doc(cityName)
      .collection('Branch')
      .doc(salonId)
      .collection('Barber');

  print(barbersRef);
  var snapshot = await barbersRef.get();
  snapshot.docs.forEach((element) {
    var barber= BarberModel.fromJson(element.data() as Map<String, dynamic>);
    barber.docId = element.id;
    barber.documentReference = element.reference;
    barbers.add(barber);
  });

  return barbers;
}

Future<List<CommentModel>> getComment(String  salonId,String cityName,String doc) async{

  List<CommentModel> result= new List<CommentModel>.empty(growable: true);
  Query<Map<String, dynamic>> bannerRef = FirebaseFirestore.instance
      .collection('AllBarbershop')
      .doc(cityName)
      .collection('Branch')
      .doc(salonId)
      .collection('Barber')
      .doc(doc)
      .collection('comentarios').orderBy('date',descending: true);

  print(bannerRef);
  QuerySnapshot snapshot=await bannerRef.get();

  snapshot.docs.forEach((element) {
    var comentario= CommentModel.fromJson(element.data() as Map<String, dynamic>);
    result.add(comentario);
  });

  return result;
}

Future<List<int>> getTimeSlotOfBarber(BarberModel barberModel,String date) async{

  List<int> result = new List<int>.empty(growable: true);
  var bookinhRef = barberModel.documentReference.collection(date);
  QuerySnapshot snapshot= await bookinhRef.get();
  snapshot.docs.forEach((element) {
    result.add(int.parse(element.id));
  });
  return result;
}

Future<bool> checkStaffOfThisSalon(BuildContext context,WidgetRef ref) async{

  DocumentSnapshot barberSnapshot = await FirebaseFirestore.instance
      .collection('AllBarbershop')
      .doc('${ref.read(selectedCity.state).state.name}')
      .collection('Branch')
      .doc(ref.read(selectedSalon.state).state.docId)
      .collection('Barber')
      .doc(FirebaseAuth.instance.currentUser!.uid).get();
  print(ref.read(selectedCity.state).state.name);
  print(ref.read(selectedSalon.state).state.docId);
  print(FirebaseAuth.instance.currentUser!.uid);
  print(barberSnapshot.exists);
  return barberSnapshot.exists;
}

Future<List<int>>  getBookingSlotOfBarber(BuildContext context,WidgetRef ref,String date) async {
  var barberDocument =  FirebaseFirestore.instance
      .collection('AllBarbershop')
      .doc('${ref.read(selectedCity.state).state.name}')
      .collection('Branch')
      .doc(ref.read(selectedSalon.state).state.docId)
      .collection('Barber')
      .doc(FirebaseAuth.instance.currentUser?.uid);

  List<int> result = new List<int>.empty(growable: true);

  var bookingRef = barberDocument.collection(date);

  QuerySnapshot snapshot= await bookingRef.get();
  snapshot.docs.forEach((element) { 
    result.add(int.parse(element.id));
  });
  return result;
}

Future<BookingModel> getDetailBooking(BuildContext context,int timeSlot,WidgetRef ref) async{
  CollectionReference userRef = FirebaseFirestore.instance
      .collection('AllBarbershop')
      .doc(ref.read(selectedCity.state).state.name)
      .collection('Branch')
      .doc(ref.read(selectedSalon.state).state.docId)
      .collection('Barber')
      .doc(FirebaseAuth.instance.currentUser?.uid)
      .collection(DateFormat('dd_MM_yyyy').format(ref.read(selectedDate.state).state));

  DocumentSnapshot snapshot = await userRef.doc(timeSlot.toString()).get();


  if(snapshot.exists){
    var bookingModel = BookingModel.fromJson(json.decode(json.encode(snapshot.data())));
    bookingModel.docId =snapshot.id;
    bookingModel.documentReference=snapshot.reference;
    ref.read(selectedBooking.state).state = bookingModel;
    return bookingModel;

  }else
    return BookingModel(barberId: '', barberName: '', cityBook: '', customerName: '', customerEmail: '', done: false, salonAddress: '', salonId: '', salonName: '', slot: 0, time: '', timeStamp: 0, customerId: '', services: '', totalPrice: 0, docId: '', customerFoto: '', rating: 0);




}