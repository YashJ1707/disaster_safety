import 'package:disaster_safety/models/incident_model.dart';
import 'package:disaster_safety/services/db.dart';
import 'package:disaster_safety/services/maps/single_marker_map.dart';
import 'package:disaster_safety/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ActiveIncidents extends StatelessWidget {
  const ActiveIncidents({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("All Incidets"),
        leading: const Icon(Icons.settings),
      ),
      body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SafeArea(
            child: Container(
                child: FutureBuilder(
              future: DbMethods().getIncidents(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        // var data = snapshot.data![index];
                        Incident incident = snapshot.data![index];
                        return GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return CustomDialog(
                                    incident: incident,
                                  );
                                },
                              );
                            },
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor: const Color(0xff764abc),
                                child: Text(
                                  index.toString(),
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                              title: Text(incident.incidentType
                                      .substring(0, 1)
                                      .toUpperCase() +
                                  incident.incidentType.substring(1)),
                              subtitle: Text(incident.isApproved
                                  ? incident.isOpen
                                      ? "Open"
                                      : "Closed"
                                  : "Not Approved"),
                              trailing: const Icon(Icons.more_vert),
                            ));
                      },
                    );
                  }
                }
                return Loadings.staticLoader();
              },
            )),
          )),
    );
  }
}

class CustomDialog extends StatelessWidget {
  final Incident incident;

  const CustomDialog({super.key, required this.incident});
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.all(20),
      title: const Text('Alert Notification'),
      content: SizedBox(
        height: 300,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${incident.incidentType.substring(0, 1).toUpperCase()}${incident.incidentType.substring(1)} Disaster",
              style: const TextStyle(fontSize: 18),
            ),
            Text(
              "Priority: ${incident.incidentPriority}",
              style: const TextStyle(fontSize: 18),
            ),
            Text(incident.description),
            SizedBox(
              height: 200,
              child: SingleMarkerMap(
                  location: LatLng(incident.latitude, incident.longitude)),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        ElevatedButton(
          onPressed: () async {
            await DbMethods().closeIncident(incident: incident);
            Navigator.of(context).pop(); // Close the dialog
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
          ),
          child: const Text('Close Incident', style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }
}
