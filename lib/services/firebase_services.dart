import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseServices {
  CollectionReference boys = FirebaseFirestore.instance.collection('Boy');
  Future<DocumentSnapshot> validateUser(id) async {
    DocumentSnapshot result = await boys.doc(id).get();
    return result;
  }
}
