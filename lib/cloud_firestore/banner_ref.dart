

import 'package:barberia/model/image_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/ListCategoria.dart';

Future<List<ImageModel>> getBanners() async {
   List<ImageModel> result = List<ImageModel>.empty(growable:true);
  CollectionReference bannerRef =
      FirebaseFirestore.instance.collection('Banner');
  QuerySnapshot snapshot=await bannerRef.get();
  
  snapshot.docs.forEach((element) {
      result.add(ImageModel.fromJson(element.data() as Map<String, dynamic>));
  });
  return result;
}