import 'package:barberia/model/service_model.dart';
import 'package:barberia/state/state_management.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart';

Future<List<ServiceModel>> getServices(BuildContext context,WidgetRef ref) async{
  var services = List<ServiceModel>.empty(growable: true);
  CollectionReference serviceRef=FirebaseFirestore.instance.collection('Services');

  QuerySnapshot snapshot=await serviceRef.where(
      ref.read(selectedSalon.state).state.docId.toString(),
      isEqualTo:true).get();
  print('snapshot');
print(snapshot);
  snapshot.docs.forEach((element) {
    var serviceModel = ServiceModel.fromJson(element.data() as Map<String, dynamic>);
    serviceModel.docId=element.id;
    services.add(serviceModel);


  });
    return services;
}