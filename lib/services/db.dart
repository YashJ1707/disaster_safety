// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:disaster_safety/models/incident_model.dart';
// import 'package:disaster_safety/models/user_model.dart';

// class DbService {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   Future<void> addIncident() async {
//     try {
//       IncidentModel incidentModel = IncidentModel(
//           lat: 18.520430,
//           long: 73.856743,
//           time: DateTime.now(),
//           priority: IncidentPriority.low,
//           incidentType: IncidentType.accident,
//           userId: '1');
//       _firestore.collection('incidents').add(incidentModel);
//     } catch (e) {
//       print(e);
//     }
//   }
// }
