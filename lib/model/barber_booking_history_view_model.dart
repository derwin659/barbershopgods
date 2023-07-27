import 'package:barberia/state/state_management.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import 'booking_model.dart';

class BarberBooking {
  Future<List<BookingModel>> getBarberBookingHistory(
      BuildContext context, DateTime dateTime, WidgetRef ref) async {
    var listBooking = List<BookingModel>.empty(growable: true);

    var barberDocument =FirebaseFirestore.instance.collection('AllBarbershop')
        .doc('${ref.read(selectedCity.state).state.name}')
        .collection('Branch')
        .doc('${ref.read(selectedSalon.state).state.docId}')
        .collection('Barber')
        .doc('${FirebaseAuth.instance.currentUser!.uid}')
        .collection(DateFormat('dd_MM_yyyy').format(dateTime));

    var snapshot = await barberDocument.get();

    snapshot.docs.forEach((element) {
      var barberBooking = BookingModel.fromJson(element.data());
      barberBooking.docId = element.id;
      barberBooking.documentReference = element.reference;
      listBooking.add(barberBooking);
    });
    return listBooking;
  }
}
