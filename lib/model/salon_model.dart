
import 'package:cloud_firestore/cloud_firestore.dart';

class SalonModel{

  late String name,address;
  String? docId;
  late DocumentReference documentReference;
  late String foto;

  SalonModel( {required this.foto,required this.name,required this.address});

  @override
  void initState() {
    docId = null;

  }
  SalonModel.fromJson(Map<String,dynamic> json){

    name= json['name'];
    address= json['address'];
    foto= json['foto'];
  }

  Map<String,dynamic> toJson(){
    final Map<String,dynamic> data=new Map<String,dynamic>();

    data['foto']=this.foto;
    data['name']=this.name;
    data['address']=this.address;
    return data;

  }



}