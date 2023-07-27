import 'package:cloud_firestore/cloud_firestore.dart';

class BarberModel{

  late String name,foto;
  String? docId;
  late double rating;
  late int ratingTimes;
  late String descripcion;
  late int like;
  late int meGusta;



  late DocumentReference documentReference;
  @override
  void initState() {
    docId = null;

  }

  BarberModel({required this.meGusta,required this.like,required this.descripcion,required this.name,required this.rating,required this.ratingTimes,required this.foto});

  BarberModel.fromJson(Map<String,dynamic> json){


    rating=double.parse(json['rating']==null ? '0':json['rating'].toString());
    name= json['name'];
    ratingTimes=int.parse(json['ratingTimes']==null ? '0':json['ratingTimes'].toString());
    like=int.parse(json['like']==null ? '0':json['like'].toString());
    meGusta=int.parse(json['meGusta']==null ? '0':json['meGusta'].toString());
    foto=json['foto'];
    descripcion=json['descripcion'];
  }

  Map<String,dynamic> toJson(){
    final Map<String,dynamic> data=new Map<String,dynamic>();


    data['descripcion']=this.descripcion;
    data['foto']=this.foto;
    data['name']=this.name;
    data['rating']=this.rating;
    data['like']=this.like;
    data['meGusta']=this.meGusta;
    data['ratingTimes']=this.ratingTimes;

    return data;

  }

}

class BarbeModelUpdate{


  late int like;




  BarbeModelUpdate({required this.like});

  BarbeModelUpdate.fromJson(Map<String,dynamic> json){



    like=int.parse(json['like']==null ? '0':json['like'].toString());

  }

  Map<String,dynamic> toJson(){
    final Map<String,dynamic> data=new Map<String,dynamic>();


    data['like']=this.like;


    return data;

  }



}

class BarbeModelUpdateMegusta{


  late int meGusta;


  BarbeModelUpdateMegusta({required this.meGusta});

  BarbeModelUpdateMegusta.fromJson(Map<String,dynamic> json){



    meGusta=int.parse(json['meGusta']==null ? '0':json['meGusta'].toString());

  }

  Map<String,dynamic> toJson(){
    final Map<String,dynamic> data=new Map<String,dynamic>();


    data['meGusta']=this.meGusta;


    return data;

  }



}

class BarbeModelUpdateRating{


  late int rating;


  BarbeModelUpdateRating({required this.rating});

  BarbeModelUpdateRating.fromJson(Map<String,dynamic> json){



    rating=int.parse(json['rating']==null ? '0':json['rating'].toString());

  }

  Map<String,dynamic> toJson(){
    final Map<String,dynamic> data=new Map<String,dynamic>();


    data['rating']=this.rating;


    return data;

  }



}