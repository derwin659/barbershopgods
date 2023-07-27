import 'package:ntp/ntp.dart';

import '../model/service_model.dart';

enum LOGIN_STATE { LOGGED, NOT_LOGIN }

const TIME_SLOT = {
  '09:00 AM-09:30 AM',
  '09:30 AM-10:00 AM',
  '10:00 AM-10:30 AM',
  '10:30 AM-11:00 AM',
  '11:30 AM-12:00 PM',
  '12:00 PM-12:30 PM',
  '12:30 PM-13:00 PM',
  '13:00 PM-13:30 PM',
  '13:30 PM-14:00 PM',
  '14:00 PM-14:30 PM',
  '14:30 PM-15:00 PM',
  '15:00 PM-15:30 PM',
  '15:30 PM-16:00 PM',
  '16:30 PM-17:00 PM',
  '17:00 PM-17:30 PM',
  '17:30 PM-18:00 PM',
  '18:00 PM-18:30 PM',
  '18:30 PM-19:00 PM',
  '19:00 PM-19:30 PM',
  '19:30 PM-20:00 PM',
  '20:00 PM-20:30 PM',
  '20:30 PM-21:00 PM',
  '21:00 PM-21:30 PM',
  '21:30 PM-22:00 PM',
};

Future<int> getMaxAvailableTimeSlot(DateTime dt) async {
  DateTime now = dt.toLocal();
  int offset = await NTP.getNtpOffset(
      localTime: now); //Syncroniza la hora con el servidor
  DateTime syncTime = now.add(Duration(milliseconds: offset));
  print(offset);
print(syncTime);
  //compara synctime local time para habilitar time slot
  if (syncTime.isBefore(DateTime(now.year, now.month, now.day, 9, 30)))
    return 0;
  else if (syncTime.isAfter(DateTime(now.year, now.month, now.day, 9, 0)) &&
      syncTime.isBefore(DateTime(now.year, now.month, now.day, 9, 30)))
    return 1; // retorna el slot siguiente disponible

  else if (syncTime.isAfter(DateTime(now.year, now.month, now.day, 9, 30)) &&
      syncTime.isBefore(DateTime(now.year, now.month, now.day, 10, 0)))
    return 2;
  else if (syncTime.isAfter(DateTime(now.year, now.month, now.day, 10, 0)) &&
      syncTime.isBefore(DateTime(now.year, now.month, now.day, 10, 30)))
    return 3;
  else if (syncTime.isAfter(DateTime(now.year, now.month, now.day, 10, 30)) &&
      syncTime.isBefore(DateTime(now.year, now.month, now.day, 11, 0)))
    return 4;
  else if (syncTime.isAfter(DateTime(now.year, now.month, now.day, 11, 0)) &&
      syncTime.isBefore(DateTime(now.year, now.month, now.day, 11, 30)))
    return 5;
  else if (syncTime.isAfter(DateTime(now.year, now.month, now.day, 11, 30)) &&
      syncTime.isBefore(DateTime(now.year, now.month, now.day, 12, 0)))
    return 6;
  else if (syncTime.isAfter(DateTime(now.year, now.month, now.day, 12, 0)) &&
      syncTime.isBefore(DateTime(now.year, now.month, now.day, 12, 30)))
    return 7;
  else if (syncTime.isAfter(DateTime(now.year, now.month, now.day, 12, 30)) &&
      syncTime.isBefore(DateTime(now.year, now.month, now.day, 13, 0)))
    return 8;
  else if (syncTime.isAfter(DateTime(now.year, now.month, now.day, 13, 0)) &&
      syncTime.isBefore(DateTime(now.year, now.month, now.day, 13, 30)))
    return 9;
  else if (syncTime.isAfter(DateTime(now.year, now.month, now.day, 13, 30)) &&
      syncTime.isBefore(DateTime(now.year, now.month, now.day, 14, 0)))
    return 10;
  else if (syncTime.isAfter(DateTime(now.year, now.month, now.day, 14, 0)) &&
      syncTime.isBefore(DateTime(now.year, now.month, now.day, 14, 30)))
    return 11;
  else if (syncTime.isAfter(DateTime(now.year, now.month, now.day, 14, 30)) &&
      syncTime.isBefore(DateTime(now.year, now.month, now.day, 15, 0)))
    return 12;
  else if (syncTime.isAfter(DateTime(now.year, now.month, now.day, 15, 0)) &&
      syncTime.isBefore(DateTime(now.year, now.month, now.day, 15, 30)))
    return 13;
  else if (syncTime.isAfter(DateTime(now.year, now.month, now.day, 15, 30)) &&
      syncTime.isBefore(DateTime(now.year, now.month, now.day, 16, 00)))
    return 14;
  else if (syncTime.isAfter(DateTime(now.year, now.month, now.day, 16, 00)) &&
      syncTime.isBefore(DateTime(now.year, now.month, now.day, 16, 30)))
    return 15;
  else if (syncTime.isAfter(DateTime(now.year, now.month, now.day, 16, 30)) &&
      syncTime.isBefore(DateTime(now.year, now.month, now.day, 17, 0)))
    return 16;
  else if (syncTime.isAfter(DateTime(now.year, now.month, now.day, 17, 0)) &&
      syncTime.isBefore(DateTime(now.year, now.month, now.day, 17, 30)))
    return 17;
  else if (syncTime.isAfter(DateTime(now.year, now.month, now.day, 17, 30)) &&
      syncTime.isBefore(DateTime(now.year, now.month, now.day, 18, 0)))
    return 18;
  else if (syncTime.isAfter(DateTime(now.year, now.month, now.day, 18, 0)) &&
      syncTime.isBefore(DateTime(now.year, now.month, now.day, 18, 30)))
    return 19;
  else if (syncTime.isAfter(DateTime(now.year, now.month, now.day, 18, 30)) &&
      syncTime.isBefore(DateTime(now.year, now.month, now.day, 19, 0)))
    return 20;
  else if (syncTime.isAfter(DateTime(now.year, now.month, now.day, 19, 0)) &&
      syncTime.isBefore(DateTime(now.year, now.month, now.day, 19, 30)))
    return 21;
  else if (syncTime.isAfter(DateTime(now.year, now.month, now.day, 19, 30)) &&
      syncTime.isBefore(DateTime(now.year, now.month, now.day, 20, 00)))
    return 22;
  else if (syncTime.isAfter(DateTime(now.year, now.month, now.day, 20, 00)) &&
      syncTime.isBefore(DateTime(now.year, now.month, now.day, 20, 30)))
    return 23;
  else if (syncTime.isAfter(DateTime(now.year, now.month, now.day, 20, 30)) &&
      syncTime.isBefore(DateTime(now.year, now.month, now.day, 21, 00)))
    return 24;
  else if (syncTime.isAfter(DateTime(now.year, now.month, now.day, 21, 00)) &&
      syncTime.isBefore(DateTime(now.year, now.month, now.day, 21, 30)))
    return 25;
  else if (syncTime.isAfter(DateTime(now.year, now.month, now.day, 21, 30)) &&
      syncTime.isBefore(DateTime(now.year, now.month, now.day, 22, 00)))
    return 26;
  else
    return 27;
}
Future<DateTime> syncTime() async{
  var now=DateTime.now();
  var offset=await NTP.getNtpOffset(localTime: now);
  return now.add(Duration(milliseconds: offset));
}

String convertServices(List<ServiceModel> services){
  String result= '';
if(services != null && services.length>0){
  services.forEach((element) {
result+='${element.name}, ';
  });
}
return result.substring(0,result.length-2);
}
