import 'package:cloud_firestore/cloud_firestore.dart';

class CommentModel{

  late String name,pic,message,date;
  late int rating;



  CommentModel({required this.name,required this.pic,required this.message,required this.date,required this.rating});

  CommentModel.fromJson(Map<String,dynamic> json){

    name= json['name'];
    date=json['date'];
    pic=json['pic'];
    message=json['message'];
    rating = int.parse(json['rating']==null ? '-1':json['rating'].toString());
  }

  Map<String,dynamic> toJson(){
    final Map<String,dynamic> data=new Map<String,dynamic>();


    data['name']=this.name;
    data['date']=this.date;
    data['pic']=this.pic;
    data['message']=this.message;
    data['rating']=this.rating;


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