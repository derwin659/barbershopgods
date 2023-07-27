import 'package:cloud_firestore/cloud_firestore.dart';

class PopularesModel{

  late String imagen;
  late String titulo;
  late String descripcion;
  late int time;

  PopularesModel({required this.imagen,required this.time,required this.titulo,required this.descripcion});

  PopularesModel.fromJson(Map<String,dynamic> json){


    imagen= json['imagen'];
    titulo= json['titulo'];
    descripcion=json['descripcion'];
    time=int.parse(json['time']==null ? '0':json['time'].toString());
  }

  Map<String,dynamic> toJson(){
    final Map<String,dynamic> data=new Map<String,dynamic>();



    data['imagen']=this.imagen;
    data['titulo']=this.titulo;
    data['descripcion']=this.descripcion;
    data['time']=this.time;

    return data;

  }



}