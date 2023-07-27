import 'package:barberia/model/VideoModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';



Future<List<VideoModel>> getVideos() async{

  List<VideoModel> result = List<VideoModel>.empty(growable:true);
  CollectionReference bannerRef =
  FirebaseFirestore.instance.collection('Videos')
  ;
  QuerySnapshot snapshot=await bannerRef.get();

  snapshot.docs.forEach((element) {
    result.add(VideoModel.fromJson(element.data() as Map<String, dynamic>));
  });
  return result;
}