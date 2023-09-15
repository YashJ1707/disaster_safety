import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:disaster_safety/models/incident_model.dart';
import 'package:disaster_safety/models/user_model.dart';
import 'package:disaster_safety/services/secure_storage.dart';
import 'package:flutter/material.dart';

class DbMethods {
  final CollectionReference incidentRef =
      FirebaseFirestore.instance.collection("incident");
  final CollectionReference userRef =
      FirebaseFirestore.instance.collection("users");
  final CollectionReference alertRef =
      FirebaseFirestore.instance.collection("alerts");

  Future<void> raiseIncident(Incident incident) async {
    try {
      await incidentRef.add(incident.toJson());
    } catch (e) {
      print("exception occured");
    }
  }

  static Future<List<Incident>> getIncidents() async {
    CollectionReference db = FirebaseFirestore.instance.collection("incident");
    QuerySnapshot<Object?> snapshot = await db.get();
    List<Incident> incidents = [];
    // print(snapshot.docs[0].data());
    if (snapshot.docs.isNotEmpty) {
      for (var element in snapshot.docs) {
        Map<String, dynamic> d = {};
        d = element.data() as Map<String, dynamic>;
        incidents.add(Incident.fromJson(d));
      }
      return incidents;
    } else {
      return [];
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

  // load users data
  Future<UserModel?> loadUserData() async {
    String? userEmail = await SecureStorage().getUsername();
    print(userEmail);
    if (userEmail != null) {
      // QuerySnapshot<Object?> res =
      //     await userRef.where('useremail', isEqualTo: userEmail).get();
      // print(res.docs);
      // // return res;
      var res = await userRef.where('useremail', isEqualTo: userEmail).get();

      // print(res.docs[0].data());
      // UserModel.fromJson();

      // return null;
    } else {
      return null;
    }
  }


  Future<String?> getRole(uid) async {
    String? role;

    try {
      QuerySnapshot qr = await userRef.where("uid", isEqualTo: uid).get();
      if (qr.docs.length > 0) {
        Map<String, dynamic> response =
            qr.docs[0].data() as Map<String, dynamic>;
        role = response['role'];
      } else {
        print("error");
      }
    } catch (e) {
      print(e);
    }

    return role;
  }

  // Future<List<Alerts>> getAlerts(){

  // }
}
