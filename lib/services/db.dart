import 'package:cloud_firestore/cloud_firestore.dart';

class DbMethods {
  final CollectionReference incidentRef =
      FirebaseFirestore.instance.collection("incident");
  final CollectionReference userRef =
      FirebaseFirestore.instance.collection("users");
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
  Future<void> signIn(data) async {
    userRef.doc(data['uid']).set(
      {data},
      SetOptions(merge: true),
    );
  }

  Future<void> signUp(Map<String, dynamic> data) async {
    await userRef.add(data);
  }

  // Future<List<Alerts>> getAlerts(){

  // }
}
