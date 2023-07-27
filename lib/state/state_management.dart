
import 'package:barberia/model/booking_model.dart';
import 'package:barberia/model/city_model.dart';
import 'package:barberia/model/salon_model.dart';
import 'package:barberia/model/service_model.dart';
import 'package:barberia/model/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/barber_model.dart';

//booking state

final _key =StateProvider((ref) => 1);
final currentStep = StateProvider((ref) => 1);
final selectedCity = StateProvider((ref) =>CityModel(name: ''));
final selectedSalon = StateProvider((ref) =>SalonModel(name: '', address: '', foto: ''));
final selectedBarber = StateProvider((ref) =>BarberModel(name: '', rating: 0,ratingTimes: 0,foto:'', descripcion: '', like: 0, meGusta: 0));
final selectedDate = StateProvider((ref) => DateTime.now());
final selectedTimeSlot= StateProvider((ref) => -1);
final selectedCalificacion= StateProvider((ref) => 1);
final selectedTime = StateProvider((ref) => '');
final userInformation =StateProvider((ref) => UserModel(name:'', email: '', imgUrl: '', isStaff: false));
final selectedBooking=StateProvider((ref) => BookingModel(barberId: '', barberName: '', cityBook: '', customerName: '',  done: false, salonAddress: '', salonId: '', salonName: '', slot: 0, time: '', timeStamp: 0, customerEmail: '', customerId: '', services: '', totalPrice: 0, docId: '', customerFoto: '', rating: 0));

//Eliminar BookingModel

final deleteFlagRefresh = StateProvider((ref) => false);


//staff

final staffStep = StateProvider((ref) => 1);
final selectedServices = StateProvider((ref) => List<ServiceModel>.empty(growable: true));

//Loading

final isLoading = StateProvider((ref) => false);


final check = StateProvider((ref) => false);