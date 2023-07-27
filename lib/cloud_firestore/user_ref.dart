import 'package:barberia/model/booking_model.dart';
import 'package:barberia/state/state_management.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/image_model.dart';
import '../model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<UserModel> getUserProfiles(String uid) async {
  CollectionReference userRef = FirebaseFirestore.instance.collection('users');
  print('derwin nieves referencia');
  print(userRef);
  DocumentSnapshot snapshot = await userRef.doc(uid).get();


  if (snapshot.exists) {
    var userModel = UserModel.fromJson(snapshot.data() as Map<String, dynamic>);
    return userModel;
  } else
    return UserModel(name: '', email: '', imgUrl: '', isStaff: false); //
}



Future<List<BookingModel>> getUserHistory() async{

  print('se vino al modelo');
  var listBooking = List<BookingModel>.empty(growable: true);
  var userRef=FirebaseFirestore.instance.collection('users')
  .doc(FirebaseAuth.instance.currentUser?.uid)
  .collection('Booking_${FirebaseAuth.instance.currentUser?.uid}');
    print(userRef);

  var snapshot = await userRef.orderBy('timeStamp',descending: true).get();
  //print(snapshot);
  snapshot.docs.forEach((element) {
    var booking = BookingModel.fromJson(element.data() );
    print('document');
    print(booking.docId);
    booking.docId=element.id;
    booking.documentReference=element.reference;
   listBooking.add(booking);

  });
  print(listBooking);

    return listBooking;


}
