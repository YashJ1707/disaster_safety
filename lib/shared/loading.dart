import 'package:disaster_safety/shared/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loadings {
  static Future<void> showLoadingDialog(BuildContext context, GlobalKey key,
      {String msg = "Please Wait..."}) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: SimpleDialog(
            key: key,
            backgroundColor: Colors.white,
            children: <Widget>[
              Center(
                child: Column(children: [
                  const SpinKitThreeBounce(
                    color: Consts.kprimary,
                    size: 50.0,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    msg,
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ]),
              )
            ],
          ),
        );
      },
    );
  }

  static Widget staticLoader() {
    return const SpinKitThreeBounce(
      color: Consts.kprimary,
      size: 50.0,
    );
  }
}


//How To show loading
//1. declare the key 
//key to define
  // final GlobalKey<State> _keyLoader = new GlobalKey<State>();

//2.  call the function to show loading
//  Loadings.showLoadingDialog(context, _keyLoader);
//3. to close the loading
// Navigator.of(_keyLoader.currentContext!,rootNavigator: true).pop();




//to close the delete screen 
//  Navigator.of(_deleteWindow.currentContext,rootNavigator: true).pop();

//key for deletebox dialog
// final GlobalKey<State> _deleteWindow = new GlobalKey<State>();
