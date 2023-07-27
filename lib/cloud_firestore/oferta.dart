

import 'package:barberia/model/image_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/ListCategoria.dart';
import '../model/ofertaModel.dart';

Future<List<OfertaModel>> getOferta() async {
  List<OfertaModel> result = List<OfertaModel>.empty(growable:true);
  CollectionReference bannerRef =
  FirebaseFirestore.instance.collection('Oferta');
  QuerySnapshot snapshot=await bannerRef.get();

  snapshot.docs.forEach((element) {
    result.add(OfertaModel.fromJson(element.data() as Map<String, dynamic>));
  });
  return result;
}