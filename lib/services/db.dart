import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:disaster_safety/models/incident_model.dart';
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

  // Future<List<Alerts>> getAlerts(){

  // }
}
