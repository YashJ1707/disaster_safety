import 'dart:math';

import 'package:disaster_safety/shared/themes.dart';
import 'package:flutter/material.dart';

class CustomDropdown extends StatefulWidget {
  final List<String> options;
  final String selectedValue;
  final ValueChanged<String?> onChanged;

  CustomDropdown({
    required this.options,
    required this.selectedValue,
    required this.onChanged,
  });

  @override
  _CustomDropdownState createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 10),
      width: min(300, MediaQuery.of(context).size.width * 0.8),
      decoration: BoxDecoration(
        border: Border.all(color: Consts.kdark),
        borderRadius: BorderRadius.circular(Consts.kborderRadius),
      ),
      child: DropdownButton<String>(
        value: widget.selectedValue,
        onChanged: widget.onChanged,
        items: widget.options.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }
}
