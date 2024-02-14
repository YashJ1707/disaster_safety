import 'package:disaster_safety/shared/themes.dart';
import 'package:flutter/material.dart';

class BtnPrimary extends StatelessWidget {
  final double width;
  final double height;
  final String title;
  final Color bgColor;
  final Color txtColor;
  final Function() onpress;

  const BtnPrimary(
      {super.key,
      this.width = 300,
      this.height = 50,
      this.bgColor = Consts.kprimary,
      this.txtColor = Consts.kwhite,
      required this.title,
      required this.onpress});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(bgColor),
          padding: MaterialStateProperty.all(EdgeInsets.zero),
        ),
        onPressed: onpress,
        child: Container(
          width: width,
          height: height,
          alignment: Alignment.center,
          child: Text(
            title,
            style: TextStyle(
              fontSize: 18,
              color: txtColor,
            ),
          ),
        ));
  }
}

class BtnElevated extends StatelessWidget {
  final String title;
  final Color bgColor;
  final Color txtColor;
  final Function() onpress;

  const BtnElevated(
      {super.key,
      this.bgColor = Consts.kprimary,
      this.txtColor = Consts.kwhite,
      required this.title,
      required this.onpress});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(bgColor),
          padding: MaterialStateProperty.all(EdgeInsets.zero),
        ),
        onPressed: onpress,
        child: Container(
          alignment: Alignment.center,
          child: Text(
            title,
            style: TextStyle(
              fontSize: 18,
              color: txtColor,
            ),
          ),
        ));
  }
}

class BtnText extends StatelessWidget {
  final String title;
  final Function() onpress;

  const BtnText({super.key, required this.title, required this.onpress});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: TextButton(
        onPressed: onpress,
        child: Text(
          title,
          style: const TextStyle(color: Consts.kblack, fontSize: 18),
        ),
      ),
    );
  }
}

class PageBtn extends StatelessWidget {
  final String title;
  final int index;
  // final String path;
  final IconData icon;
  final Function() onpress;

  const PageBtn(
      {super.key, required this.title,
      required this.icon,
      required this.onpress,
      required this.index});

  // List<LinearGradient> gradients = [
  //   LinearGradient(
  //     colors: [
  //       Color.fromARGB(255, 0, 241, 129),
  //       Color.fromARGB(255, 68, 255, 168),
  //     ],
  //   ),
  //   LinearGradient(colors: [
  //     Color.fromARGB(255, 255, 117, 4),
  //     Color.fromARGB(255, 255, 161, 84),
  //   ]),
  //   LinearGradient(
  //     colors: [
  //       Color.fromARGB(255, 179, 0, 255),
  //       Color.fromARGB(255, 255, 78, 255),
  //     ],
  //   ),
  //   LinearGradient(
  //     colors: [
  //       Color.fromARGB(255, 0, 205, 241),
  //       Color.fromARGB(255, 127, 236, 255),
  //     ],
  //   ),
  //   LinearGradient(
  //     colors: [
  //       Color.fromARGB(255, 255, 255, 0),
  //       Color.fromARGB(255, 255, 255, 80),
  //     ],
  //   ),
  //   LinearGradient(
  //     colors: [
  //       Color.fromARGB(255, 255, 0, 34),
  //       Color.fromARGB(255, 255, 77, 101),
  //     ],
  //   ),
  //   LinearGradient(
  //     colors: [
  //       Color.fromARGB(255, 255, 0, 221),
  //       Color.fromARGB(255, 255, 92, 233),
  //     ],
  //   ),
  // ];

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        width: width * 0.42,
        height: height * 0.2,
        decoration: BoxDecoration(
            // color: Color.fromARGB(255, 197, 248, 255),
            color: Colors.white,
            // gradient: gradients[index % gradients.length],
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                offset: const Offset(2, 2),
                spreadRadius: 2,
                blurRadius: 2,
                color: Colors.grey.shade300,
              ),
            ]),
        child: TextButton(
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all(Colors.black),
          ),
          onPressed: onpress,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Center(
              //   child: Image(
              //     image: AssetImage(path),
              //     width: 70,
              //     height: 70,
              //   ),
              // ),
              Center(
                child: Icon(
                  icon,
                  size: 48,
                  color: Consts.kprimary,
                ),
              ),
              const SizedBox(height: 10.0),
              Center(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
