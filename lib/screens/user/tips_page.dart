import 'package:disaster_safety/shared/text_styles.dart';
import 'package:disaster_safety/shared/themes.dart';
import 'package:flutter/material.dart';

class TipsPage extends StatelessWidget {
  TipsPage({super.key});

  final List<Disaster> disasters = [
    Disaster(
      'Earthquake',
      [
        'Drop, Cover, and Hold On: Drop to the ground, take cover under a sturdy piece of furniture, and hold on until the shaking stops.',
        'Stay Indoors: If you\'re indoors, stay there. Do not run outside, as falling debris can be extremely dangerous.',
        'Stay Away from Windows and Heavy Objects: Move away from windows, mirrors, glass, and anything that could shatter. Stay clear of heavy objects that might fall.',
      ],
    ),
    Disaster(
      'Hurricane',
      [
        'Evacuate if Necessary: If authorities recommend evacuation, follow their instructions promptly.',
        'Secure Your Home: Board up windows, secure outdoor objects, and reinforce your home to withstand strong winds.',
        'Stay Informed: Keep a battery-powered weather radio or stay updated with local news for storm updates.',
      ],
    ),
    // Add more disasters and tips here
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tips"),
        leading: const Icon(Icons.tips_and_updates),
      ),
      body: ListView.builder(
        itemCount: disasters.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            leading: const Icon(
              Icons.ac_unit_outlined,
              color: Consts.kprimary,
            ),
            title: Texts.h1(title: disasters[index].name),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:
                  disasters[index].tips.map((tip) => Text('• $tip')).toList(),
            ),
          );
        },
      ),
    );
  }
}

class Disaster {
  final String name;
  final List<String> tips;

  Disaster(this.name, this.tips);
}
