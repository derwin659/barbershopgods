import 'package:cloud_firestore/cloud_firestore.dart';

class ServiceModel{
  late String name;
  late  String docId;
  late double price;


  ServiceModel(
      {
        required this.name,
        required this.price,
      } );

  ServiceModel.fromJson(Map<String,dynamic> json){
    name= json['name'];
    price=json['price'] ==null? 0 : double.parse(json['price'].toString());
  }

  Map<String,dynamic> toJson(){
    final Map<String,dynamic> data=new Map<String,dynamic>();
    data['name']=this.name;
    data['price']=this.price;
    return data;

  }

}