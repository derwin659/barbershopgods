
import 'package:barberia/model/booking_model.dart';
import 'package:barberia/model/city_model.dart';
import 'package:barberia/model/salon_model.dart';
import 'package:barberia/model/service_model.dart';
import 'package:barberia/model/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/barber_model.dart';

//booking state



final barberHistorySelectedDate = StateProvider((ref) => DateTime.now());
