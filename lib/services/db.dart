import 'package:cloud_firestore/cloud_firestore.dart';

class DbMethods {
  final CollectionReference incidentRef =
      FirebaseFirestore.instance.collection("incident");
  final CollectionReference userRef =
      FirebaseFirestore.instance.collection("user");
  final CollectionReference alertRef =
      FirebaseFirestore.instance.collection("alerts");

  Future<void> raiseIncident(Map<String, dynamic> data) async {
    try {
      await incidentRef.add(data);
    } catch (e) {
      print("exception occured");
    }
  }

  // sign up
  Future<void> signUP(data) async {
    userRef.doc(data['uid']).set(
      {data},
      SetOptions(merge: true),
    );
  }

  // Future<List<Alerts>> getAlerts(){

  // }
}
