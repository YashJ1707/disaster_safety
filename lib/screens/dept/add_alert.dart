import 'package:disaster_safety/models/alert_model.dart';
import 'package:disaster_safety/router.dart';
import 'package:disaster_safety/services/db.dart';
import 'package:disaster_safety/services/push_notification.dart';
import 'package:disaster_safety/services/secure_storage.dart';
import 'package:disaster_safety/shared/buttons.dart';
import 'package:disaster_safety/shared/dropdown.dart';
import 'package:disaster_safety/shared/loading.dart';
import 'package:disaster_safety/shared/text_field.dart';
import 'package:disaster_safety/shared/themes.dart';
import 'package:flutter/material.dart';

class AddAlerts extends StatefulWidget {
  AddAlerts({super.key});

  @override
  State<AddAlerts> createState() => _AddAlertsState();
}

class _AddAlertsState extends State<AddAlerts> {
  final PushNotificationService _notificationService =
      PushNotificationService();
  final TextEditingController _alertTitle = TextEditingController();

  final TextEditingController _description = TextEditingController();

  String selectedTag = "General";

  List<String> tagOptions = ["Awareness", "Emergency", "Important", "General"];
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();

  @override
  Widget build(BuildContext context) {
      _notificationService.initialize();
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Alert "),
        leading: const Icon(Icons.warning_amber),
      ),
      body: SingleChildScrollView(
          child: SafeArea(
        child: Container(
          width: width,
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Tinput(
                controller: _alertTitle, hint: "Enter title", label: "Title"),
            Tinput(
              controller: _description,
              hint: "Enter description",
              label: "description",
            ),
            Container(
              // alignment: Alignment.centerLeft,
              child: Text(
                "Choose alert Tag",
              ),
            ),
            CustomDropdown(
                options: tagOptions,
                selectedValue: selectedTag,
                onChanged: (value) {
                  setState(() {
                    selectedTag = value!;
                  });
                }),
            const SizedBox(
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
                    Alert alert = Alert(
                        id: uid,
                        title: _alertTitle.text,
                        subtitle: _description.text,
                        tag: selectedTag);

                    // Incident incidentt = Incident(null,
                    //     incidentType: selectedIncident,
                    //     incidentPriority: selectedPriority,
                    //     reportedDate: DateTime.now().toUtc(),
                    //     longitude: widget.longitude,
                    //     latitude: widget.latitude,
                    //     description: _description.text,
                    //     reportedBy: "reportedBy",
                    //     isApproved: false);
                    try {
                      Loadings.showLoadingDialog(context, _keyLoader);

                      await DbMethods().createAlert(alert);
                      Navigator.of(_keyLoader.currentContext!,
                              rootNavigator: true)
                          .pop();

                      // await DbMethods().raiseIncident(incident);
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Alert Added Successfully")));
                      //         "Incident Raised and pending for approval" +
                      //             widget.latitude.toString() +
                      //             " " +
                      //             widget.longitude.toString())));
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("Failed to create alert")));
                    }
                  },
                ),
              ],
            )
          ]),
        ),
      )),
    );
  }
}
