import 'package:disaster_safety/models/incident_model.dart';
import 'package:disaster_safety/services/db.dart';
import 'package:disaster_safety/shared/loading.dart';
import 'package:flutter/material.dart';

class UpdatesPage extends StatelessWidget {
  const UpdatesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Updates"),
        leading: const Icon(Icons.update_sharp),
      ),
      body: SingleChildScrollView(
          child: SafeArea(
        child: Container(
            child: FutureBuilder(
          future: DbMethods().getIncidentsForUser(),
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
                          //TODO: Show Map on click of this
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
