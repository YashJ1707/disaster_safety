import 'package:disaster_safety/shared/themes.dart';
import 'package:flutter/material.dart';

class Texts {
  static Widget h1({
    required String title,
    Color? txtcolor,
  }) {
    return Text(
      title,
      style: TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 24,
        color: txtcolor ?? Consts.kblack,
      ),
    );
  }

  static Widget h2(
      {required String title, Color? txtcolor, FontWeight? fontWeight}) {
    return Text(
      title,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontWeight: fontWeight ?? FontWeight.w700,
        fontSize: 22,
        color: txtcolor ?? Consts.kblack,
      ),
      maxLines: 2,
    );
  }

  static Widget h3(
      {required String title, Color? txtcolor, FontWeight? fontWeight}) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 20,
        color: txtcolor ?? Consts.kblack,
        fontWeight: fontWeight ?? FontWeight.w700,
      ),
    );
  }

  static Widget h4({
    required String title,
    Color? txtcolor,
  }) {
    return Text(
      title,
      style: TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 18,
        color: txtcolor ?? Consts.kblack,
      ),
    );
  }

  static Widget h5({
    required String title,
    Color? txtcolor,
  }) {
    return Text(
      title,
      style: TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 16,
        color: txtcolor ?? Consts.kblack,
      ),
    );
  }

  static Widget span(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        color: Consts.kblack,
      ),
    );
  }
}
