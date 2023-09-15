import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:disaster_safety/models/alert_model.dart';
import 'package:disaster_safety/models/incident_model.dart';
import 'package:disaster_safety/models/resources_model.dart';
import 'package:disaster_safety/models/user_model.dart';
import 'package:disaster_safety/services/secure_storage.dart';

class DbMethods {
  final CollectionReference incidentRef =
      FirebaseFirestore.instance.collection("incident");
  final CollectionReference userRef =
      FirebaseFirestore.instance.collection("users");
  final CollectionReference alertRef =
      FirebaseFirestore.instance.collection("alerts");
  final CollectionReference resourceRef =
      FirebaseFirestore.instance.collection("resources");

  final SecureStorage storage = SecureStorage();

// -------------- incident -------------------

  Future<List<Incident>> getIncidents() async {
    QuerySnapshot<Object?> snapshot = await incidentRef.get();
    List<Incident> incidents = [];
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

  Future<void> raiseIncident(Incident incident) async {
    try {
      await incidentRef.add(incident.toJson()).then((value) => {
            incidentRef.doc(value.id).update({'id': value.id})
          });
    } catch (e) {
      print(e);
    }
  }

  Future<void> approveIncident({required Incident incident}) async {
    try {
      String? userId = await storage.getUserId();
      await incidentRef
          .doc(incident.id)
          .update({'isApproved': true, 'approvedBy': userId});
    } catch (e) {
      print(e);
    }
  }

  Future<void> closeIncident({required Incident incident}) async {
    try {
      await incidentRef.doc(incident.id).update({'isOpen': false});
    } catch (e) {
      print(e);
    }
  }

// -------------- resource -------------------

  Future<void> createResource({required Resource resource}) async {
    try {
      await resourceRef.add(resource.toJson()).then((value) => {
            resourceRef.doc(value.id).update({'id': value.id}),
          });
    } catch (e) {
      print(e);
    }
  }

  Future<void> deleteResource({required Resource resource}) async {
    try {
      await resourceRef.doc(resource.id).delete();
    } catch (e) {
      print(e);
    }
  }

  Future<List<Resource>> getResources() async {
    QuerySnapshot<Object?> snapshot = await resourceRef.get();
    List<Resource> resources = [];
    if (snapshot.docs.isNotEmpty) {
      for (var element in snapshot.docs) {
        Map<String, dynamic> d = {};
        d = element.data() as Map<String, dynamic>;
        resources.add(Resource.fromJson(d));
      }
      return resources;
    } else {
      return [];
    }
  }

  //----------------- auth ----------------------
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
    UserModel? user;
    String? userEmail = await SecureStorage().getUsername();
    print(userEmail);
    if (userEmail != null) {
      QuerySnapshot<Object?> snapshot =
          await userRef.where('useremail', isEqualTo: userEmail).get();
      print(snapshot.docs.length);
      if (snapshot.docs.isNotEmpty) {
        for (var element in snapshot.docs) {
          Map<String, dynamic> d = {};
          d = element.data() as Map<String, dynamic>;
          user = UserModel.fromJson(d);
        }
        print(user);
        return user;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  Future<String?> getRole(uid) async {
    String? role;

    try {
      QuerySnapshot qr = await userRef.where("uid", isEqualTo: uid).get();
      if (qr.docs.isNotEmpty) {
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
  //---------------- alert --------------------

  Future<void> createAlert(Alert alert) async {
    try {
      await alertRef.add(alert.toJson()).then((value) async => {
            await alertRef.doc(value.id).update({'id': value.id}),
          });
    } catch (e) {
      print(e);
    }
  }

  Future<void> deleteAlert(Alert alert) async {
    try {
      await alertRef.doc(alert.id).delete();
    } catch (e) {
      print(e);
    }
  }

  Future<List<Alert>> getAlerts() async {
    QuerySnapshot<Object?> snapshot = await resourceRef.get();
    List<Alert> alerts = [];
    if (snapshot.docs.isNotEmpty) {
      for (var element in snapshot.docs) {
        Map<String, dynamic> d = {};
        d = element.data() as Map<String, dynamic>;
        alerts.add(Alert.fromJson(d));
      }
      return alerts;
    } else {
      return [];
    }
  }
}
