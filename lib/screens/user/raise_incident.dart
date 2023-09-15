import 'package:disaster_safety/models/incident_model.dart';
import 'package:disaster_safety/router.dart';
import 'package:disaster_safety/services/db.dart';
import 'package:disaster_safety/services/secure_storage.dart';
import 'package:disaster_safety/shared/buttons.dart';
import 'package:disaster_safety/shared/dropdown.dart';
import 'package:disaster_safety/shared/text_field.dart';
import 'package:disaster_safety/shared/themes.dart';
import 'package:flutter/material.dart';

class RaiseIncidentPage extends StatefulWidget {
  const RaiseIncidentPage(
      {super.key, required this.latitude, required this.longitude});

  final double latitude;
  final double longitude;

  @override
  State<RaiseIncidentPage> createState() => _RaiseIncidentPageState();
}

class _RaiseIncidentPageState extends State<RaiseIncidentPage> {
  TextEditingController _incidentType = TextEditingController();
  TextEditingController _description = TextEditingController();
  TextEditingController _location = TextEditingController();

  String selectedIncident = "flood"; // Initial selected value
  String selectedAuthority =
      "Local Government Authority"; // Initial selected value
  String selectedPriority = "Low";
  bool showOtherField = false;
  List<String> incidentTypes = [
    "flood",
    "landslide",
    "earthquake",
    "accident",
    "other"
  ];
  List<String> govAuthorities = [
    "Local Government Authority",
    "Police",
    "Health Department",
    "other"
  ];
  List<String> priority = ["High", "Medium", "Low"];

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(title: Text("Raise Incident")),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 18),
            child: Form(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Select Incident Type:',
                  textAlign: TextAlign.start,
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 20),
                CustomDropdown(
                  options: incidentTypes,
                  selectedValue: selectedIncident,
                  onChanged: (String? newValue) {
                    print(newValue);
                    setState(
                      () {
                        selectedIncident = newValue!;
                        if (selectedIncident == "other") {
                          showOtherField = true;
                        } else {
                          showOtherField = false;
                        }
                      },
                    );
                  },
                ),
                showOtherField
                    ? Tinput(
                        controller: _incidentType,
                        hint: "Enter incident type",
                        label: "Incident Type",
                      )
                    : Container(),
                const SizedBox(height: 20),
                const Text(
                  'Select Responsible department:',
                  textAlign: TextAlign.start,
                  style: TextStyle(fontSize: 16),
                ),
                CustomDropdown(
                  options: govAuthorities,
                  selectedValue: selectedAuthority,
                  onChanged: (String? newValue) {
                    setState(
                      () {
                        selectedAuthority = newValue!;
                      },
                    );
                  },
                ),
                const SizedBox(height: 20),
                const Text(
                  'Select Priority of incident:',
                  textAlign: TextAlign.start,
                  style: TextStyle(fontSize: 16),
                ),
                CustomDropdown(
                  options: priority,
                  selectedValue: selectedPriority,
                  onChanged: (String? newValue) {
                    setState(
                      () {
                        selectedPriority = newValue!;
                      },
                    );
                  },
                ),
                Tinput(
                    controller: _location,
                    hint: "select Location",
                    label: "select location by gps or enter manually"),
                Tinput(
                  controller: _description,
                  hint: "enter additional information",
                  label: "Description",
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    BtnPrimary(
                      title: "cancel",
                      onpress: () {
                        Routes.pop(context);
                      },
                      bgColor: Consts.klight,
                      txtColor: Consts.kblack,
                      width: width * 0.33,
                    ),
                    BtnPrimary(
                      title: "Save",
                      width: width * 0.33,
                      txtColor: Consts.kwhite,
                      bgColor: Consts.kprimary,
                      onpress: () async {
                        String? uid = await SecureStorage().getUserId();
                        Incident incident = Incident(null,
                            id: "",
                            incidentType: selectedIncident,
                            incidentPriority: selectedPriority,
                            reportedDate: DateTime.now().toUtc(),
                            longitude: widget.longitude,
                            latitude: widget.latitude,
                            description: _description.text,
                            reportedBy: "reportedBy",
                            isApproved: false,
                            isOpen: true);
                        try {
                          await DbMethods().raiseIncident(incident);
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                  "Incident Raised and pending for approval" +
                                      widget.latitude.toString() +
                                      " " +
                                      widget.longitude.toString())));
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Failed to register")));
                        }
                      },
                    ),
                  ],
                )
              ],
            )),
          ),
        ),
      ),
    );
  }
}
