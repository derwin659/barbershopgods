

import 'package:barberia/model/image_model.dart';
import 'package:barberia/state/state_management.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/ListCategoria.dart';
import '../model/ListTrabajosRealizados.dart';
import '../model/populares_model.dart';

Future<List<ImageModel>> getLookbook() async {
   List<ImageModel> result = List<ImageModel>.empty(growable:true);
  CollectionReference bannerRef =
      FirebaseFirestore.instance.collection('Lookbook');
  QuerySnapshot snapshot=await bannerRef.get();
  
  snapshot.docs.forEach((element) {
      result.add(ImageModel.fromJson(element.data() as Map<String, dynamic>));
  });
  return result;
}



Future<List<dynamic>> getModelosCategorias(String nombreCategoria) async {
  List<ListCategorias> result = List<ListCategorias>.empty(growable:true);
  CollectionReference bannerRef =
  FirebaseFirestore.instance.collection('Lookbook')
  .doc(nombreCategoria)
  .collection('Modelos');

  QuerySnapshot snapshot=await bannerRef.get();

  snapshot.docs.forEach((element) {
    result.add(ListCategorias.fromJson(element.data() as Map<String, dynamic>));
  });
  return result;
}

Future<List<dynamic>> getModelosPorBarberos(WidgetRef ref) async {
  List<ListTrabajosRealizados> result = List<ListTrabajosRealizados>.empty(growable:true);


  CollectionReference bannerRef = FirebaseFirestore.instance
      .collection('AllBarbershop')
      .doc('${ref.read(selectedCity.state).state.name}')
      .collection('Branch')
      .doc(ref.read(selectedSalon.state).state.docId)
      .collection('Barber')
      .doc(ref.read(selectedBarber.state).state.docId)
      .collection('cortes');

  print(bannerRef);

  QuerySnapshot snapshot=await bannerRef.get();

  snapshot.docs.forEach((element) {
    result.add(ListTrabajosRealizados.fromJson(element.data() as Map<String, dynamic>));
  });
  return result;
}



Future<List<ListCategorias>> getGridList() async {
  List<ListCategorias> result = List<ListCategorias>.empty(growable:true);
  CollectionReference bannerRef =
  FirebaseFirestore.instance.collection('Lookbook')
  ;
  QuerySnapshot snapshot=await bannerRef.get();

  snapshot.docs.forEach((element) {
    result.add(ListCategorias.fromJson(element.data() as Map<String, dynamic>));
  });
  return result;
}

Future<List<PopularesModel>> getPopulares() async {
  List<PopularesModel> result = List<PopularesModel>.empty(growable:true);
  CollectionReference bannerRef =
  FirebaseFirestore.instance.collection('Populares')
  ;
  QuerySnapshot snapshot=await bannerRef.get();

  snapshot.docs.forEach((element) {
    result.add(PopularesModel.fromJson(element.data() as Map<String, dynamic>));
  });
  return result;
}