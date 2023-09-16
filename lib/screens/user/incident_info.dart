import 'package:disaster_safety/models/incident_model.dart';
import 'package:disaster_safety/shared/text_styles.dart';
import 'package:flutter/material.dart';

class IncidentInfo extends StatelessWidget {
  final Incident incident;
  const IncidentInfo({super.key, required this.incident});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Incident Information")),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: SingleChildScrollView(
            child: Column(
          children: [
            profile_row("Incident Type", incident.incidentType),
            profile_row("Priority", incident.incidentPriority),
            profile_row("Reported by", incident.reportedBy),
            profile_row("Description", incident.description),
            Container(
              child: Image(
                image: incident.imgpath != null
                    ? NetworkImage(incident.imgpath!)
                    : NetworkImage(
                        "https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/495px-No-Image-Placeholder.svg.png?20200912122019"),
                width: 100,
                height: 100,
              ),
            ),
            // profile_row("Incident Type", incident.),
          ],
        )),
      ),
    );
  }

  Widget profile_row(String label1, String label2) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Texts.h2(title: label1 + " : "),
        Texts.h2(title: label2),
      ],
    );
  }
}
