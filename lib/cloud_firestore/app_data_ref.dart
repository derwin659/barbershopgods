
import 'package:cloud_firestore/cloud_firestore.dart';

Future<String> getServerKey() async{
  DocumentSnapshot snapshot= await FirebaseFirestore.instance.collection('AppData')
      .doc('serverKey').get();
print('vino a buscar el key');
  if(snapshot.exists){
    var key = (snapshot.data() as Map)['key'];
    return key;
  }else return 'NONE';
}