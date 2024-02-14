import 'package:disaster_safety/shared/loading.dart';
import 'package:disaster_safety/shared/text_styles.dart';
import 'package:flutter/material.dart';

class HelpDesk extends StatelessWidget {
  HelpDesk({super.key});
  List<Map<String, dynamic>> organizationsData = [
    {
      "name": "Community Health Clinic",
      "category": "Medical",
      "phone": "+1 (123) 456-7890",
      "email": "info@communityclinic.org",
      "location": "123 Main Street, Anytown, USA",
      "latitude": 37.123456,
      "longitude": -122.123456,
    },
    {
      "name": "Red Cross Relief Center",
      "category": "Community Support",
      "phone": "+1 (987) 654-3210",
      "email": "contact@redcross.org",
      "location": "456 Elm Avenue, Othertown, USA",
      "latitude": 38.654321,
      "longitude": -123.654321,
    },
    {
      "name": "City Hospital",
      "category": "Medical",
      "phone": "+1 (555) 789-1234",
      "email": "info@cityhospital.org",
      "location": "789 Oak Road, Yourtown, USA",
      "latitude": 39.789123,
      "longitude": -124.789123,
    },
    {
      "name": "Hope Shelter",
      "category": "Community Support",
      "phone": "+1 (234) 567-8901",
      "email": "contact@hopeshelter.org",
      "location": "101 Pine Street, Anothertown, USA",
      "latitude": 40.101010,
      "longitude": -125.101010,
    },
    {
      "name": "Sunrise Clinic",
      "category": "Medical",
      "phone": "+1 (777) 888-9999",
      "email": "info@sunriseclinic.org",
      "location": "222 Beach Boulevard, Beachtown, USA",
      "latitude": 41.222222,
      "longitude": -126.222222,
    },
  ];

  Future<List<Map<String, dynamic>>> getOrgs() async {
    await Future.delayed(const Duration(seconds: 2));
    return organizationsData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Help & Contact"),
      ),
      body: SingleChildScrollView(
          child: SafeArea(
        child: Container(
            child: FutureBuilder(
          future: getOrgs(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    var data = snapshot.data![index];
                    return GestureDetector(
                      onTap: () {
                        //TODO: Show Map on click of this
                      },
                      child: Card(
                        margin:
                            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(children: [
                            Texts.h2(title: data['name']),
                            const SizedBox(
                              height: 4,
                            ),
                            Text(data['location']),
                            const SizedBox(
                              height: 4,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(data['phone']),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(data['email']),
                              ],
                            )
                          ]),
                        ),
                      ),
                    );
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
