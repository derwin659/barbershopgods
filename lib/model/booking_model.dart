/*var submitData = {
  'barberId': ref.read(selectedBarber.state).state.docId,
  'barberName': ref.read(selectedBarber.state).state.name,
  'cityBook': ref.read(selectedCity.state).state.name,
  'customerName': ref.read(userInformation.state).state.name,
  // 'customerEmail' : FirebaseAuth.instance.currentUser.uid.toString(),
  'done': false,
  'salonId': ref.read(selectedSalon.state).state.docId,
  'salonName': ref.read(selectedSalon.state).state.name,
  'slot': ref.read(selectedTimeSlot.state).state,
  'timeStamp': timeStamp,
  'time':
  '${ref.read(selectedTime.state).state} - ${DateFormat('dd/MM/yyyy').format(ref.read(selectedDate.state).state)}',
};*/

import 'package:cloud_firestore/cloud_firestore.dart';

class BookingModel{
  late String barberId,barberName,cityBook,customerName,customerEmail,salonAddress,salonId,salonName,time;
  late bool done;
  late String? docId;
  late String customerId;
  late String services;
  late int slot, timeStamp,rating;
  late double totalPrice;
  late String customerFoto;

  late DocumentReference documentReference;
  @override
  void initState() {
    docId = null;

  }


  BookingModel(
  {    this.docId,
      required this.barberId,
      required this.barberName,
      required this.services,
      required this.totalPrice,
      required this.cityBook,
      required this.customerId,
      required this.customerName,
      required this.customerEmail,
      required this.done,
      required this.salonAddress,
      required this.salonId,
      required this.salonName,
      required this.slot,
      required this.rating,
      required this.time,
      required this.timeStamp,
      required this.customerFoto
  } );


  BookingModel.fromJson(Map<String,dynamic> json){
    docId=json['docId'];
    barberId=json['barberId'];
    barberName= json['barberName'];
    customerFoto= json['customerFoto'];
    services= json['services'];
    slot=int.parse(json['slot']==null ? '-1':json['slot'].toString());
    rating=int.parse(json['rating']==null ? '-1':json['rating'].toString());
    totalPrice=double.parse(json['totalPrice']==null ? '0':json['totalPrice'].toString());
    timeStamp=int.parse(json['timeStamp']==null ? '0':json['timeStamp'].toString());
    cityBook=json['cityBook'];
    customerId=json['customerId'];
    customerName=json['customerName'];
    customerEmail=json['customerEmail'];
    done=json['done'] as bool;
    salonAddress=json['salonAddress'];
    salonId=json['salonId'];
    salonName=json['salonName'];
    time=json['time'];

  }


  Map<String,dynamic> toJson(){
    final Map<String,dynamic> data=new Map<String,dynamic>();

    data['docId']=this.docId;
    data['barberId']=this.barberId;
    data['barberName']=this.barberName;
    data['services']=this.services;
    data['slot']=this.slot;
    data['rating']=this.rating;
    data['timeStamp']=this.timeStamp;
    data['totalPrice']=this.totalPrice;
    data['cityBook']=this.cityBook;
    data['customerFoto']=this.customerFoto;
    data['customerId']=this.customerId;
    data['customerName']=this.customerName;
    data['customerEmail']=this.customerEmail;
    data['done']=this.done;
    data['salonAddress']=this.salonAddress;
    data['salonId']=this.salonId;
    data['salonName']=this.salonName;
    data['time']=this.time;

    return data;

  }
}