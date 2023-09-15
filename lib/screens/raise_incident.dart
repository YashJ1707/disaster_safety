import 'package:disaster_safety/shared/dropdown.dart';
import 'package:disaster_safety/shared/text_field.dart';
import 'package:flutter/material.dart';

class RaiseIncidentPage extends StatefulWidget {
  const RaiseIncidentPage({super.key});

  @override
  State<RaiseIncidentPage> createState() => _RaiseIncidentPageState();
}

class _RaiseIncidentPageState extends State<RaiseIncidentPage> {
  TextEditingController _incidentType = TextEditingController();
  TextEditingController _description = TextEditingController();

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
                    controller: _description,
                    hint: "enter additional information",
                    label: "Description"),
                Tinput(
                    controller: _description,
                    hint: "enter additional information",
                    label: "Description"),
              ],
            )),
          ),
        ),
      ),
    );
  }
}
