import 'package:disaster_safety/models/alert_model.dart';
import 'package:disaster_safety/services/db.dart';
import 'package:disaster_safety/shared/loading.dart';
import 'package:flutter/material.dart';

class AlertPage extends StatelessWidget {
  const AlertPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Alerts "),
        leading: Icon(Icons.warning),
      ),
      body: SingleChildScrollView(
          child: SafeArea(
        child: Container(
            child: FutureBuilder(
          future: DbMethods().getAlerts(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    // var data = snapshot.data![index];
                    Alert alert = snapshot.data![index];
                    return GestureDetector(
                        onTap: () {},
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: const Color(0xff764abc),
                            child: Text(
                              index.toString(),
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                          title: Text(
                              alert.title.substring(0, 1).toUpperCase() +
                                  alert.title.substring(1)),
                          subtitle: Text(alert.subtitle),
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
