import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AuthTexts {
  Text title(String title) {
    return Text(
      title,
      style: TextStyle(
          color: Colors.white, fontWeight: FontWeight.bold, fontSize: 34.sp),
    );
  }

  Text subtitle(String subtitle) {
    return Text(
      subtitle,
      style: TextStyle(color: Colors.white, fontSize: 28.sp),
    );
  }
}
