import 'dart:io';

import 'package:disaster_safety/models/incident_model.dart';
import 'package:disaster_safety/core/router.dart';
import 'package:disaster_safety/screens/user/homepage.dart';
import 'package:disaster_safety/services/db.dart';
import 'package:disaster_safety/services/secure_storage.dart';
import 'package:disaster_safety/shared/buttons.dart';
import 'package:disaster_safety/shared/dropdown.dart';
import 'package:disaster_safety/shared/loading.dart';
import 'package:disaster_safety/shared/text_field.dart';
import 'package:disaster_safety/shared/themes.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart' as path;

class RaiseIncidentPage extends StatefulWidget {
  const RaiseIncidentPage(
      {super.key, required this.latitude, required this.longitude});

  final double latitude;
  final double longitude;

  @override
  State<RaiseIncidentPage> createState() => _RaiseIncidentPageState();
}

class _RaiseIncidentPageState extends State<RaiseIncidentPage> {
  final TextEditingController _incidentType = TextEditingController();
  final TextEditingController _description = TextEditingController();
  final GlobalKey<State> _keyLoader = GlobalKey<State>();

  String selectedIncident = "Flood"; // Initial selected value
  String selectedAuthority =
      "Local Government Authority"; // Initial selected value
  String selectedPriority = "Low";
  bool showOtherField = false;
  List<String> incidentTypes = [
    "Flood",
    "Landslide",
    "Earthquake",
    "Wildfire",
    "Tsunami",
  ];
  List<String> priority = ["Critical", "High", "Medium", "Low"];

  // picking image
  final ImagePicker _picker = ImagePicker();
  XFile? _image;

  // Future<void> _getImage(ImageSource source) async {
  //   final pickedFile = await _picker.pickImage(source: source);

  //   setState(() {
  //     _image = pickedFile;
  //   });
  // }

  Future<void> _getImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);

    if (pickedFile != null) {
      final File imageFile = File(pickedFile.path);

      // Resize and compress the selected image
      final resizedAndCompressedImage = await resizeAndCompressImage(imageFile);

      setState(() {
        _image = XFile(resizedAndCompressedImage.path);
      });
    }
  }

  Future<String?> uploadImageToFirebaseStorage() async {
    try {
      final fileName = path.basename(_image!.path); // Extract the file name.
      final storageRef = firebase_storage.FirebaseStorage.instance
          .ref()
          .child('images/$fileName'); // Define the storage reference.

      final uploadTask =
          await storageRef.putFile(File(_image!.path)); // Upload the file.

      if (uploadTask.state == firebase_storage.TaskState.success) {
        final downloadURL = await storageRef.getDownloadURL();
        return downloadURL; // Return the download URL.
      } else {
        return null; // Handle the error as needed.
      }
    } catch (e) {
      print('Error uploading image: $e');
      return null; // Handle the error as needed.
    }
  }

  Future<File> resizeAndCompressImage(File imageFile) async {
    final originalImage = img.decodeImage(imageFile.readAsBytesSync());

    // Resize the image to the desired resolution (1000x600)
    final resizedImage =
        img.copyResize(originalImage!, width: 1000, height: 600);

    // Compress the image to reduce file size (adjust the quality as needed)
    final compressedImage =
        img.encodeJpg(resizedImage, quality: 90); // Adjust quality as needed

    final resizedAndCompressedFile = File(imageFile.path)
      ..writeAsBytesSync(compressedImage);

    return resizedAndCompressedFile;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
          title: const Text(
        "Raise Incident",
        style: TextStyle(fontWeight: FontWeight.bold),
      )),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
            child: Form(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Row(
                  children: [
                    SizedBox(width: 20),
                    Text(
                      'Select Incident Type:',
                      textAlign: TextAlign.start,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                CustomDropdown(
                  options: incidentTypes,
                  selectedValue: selectedIncident,
                  onChanged: (String? newValue) {
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
                const Row(
                  children: [
                    SizedBox(width: 20),
                    Text(
                      'Select Priority of Incident:',
                      textAlign: TextAlign.start,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
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
                const SizedBox(
                  height: 20,
                ),
                Tinput(
                  controller: _description,
                  hint: "enter additional information",
                  label: "Description",
                ),
                const SizedBox(
                  height: 30,
                ),
                BtnPrimary(
                    title: "Choose Image",
                    bgColor: Consts.kdark,
                    onpress: () {
                      _openBottomSheet(context);
                    }),
                _image != null
                    ? SizedBox(
                        width: width * 0.8,
                        child: ListTile(
                          title: Text("Selected Image: ${_image!.name}"),
                          leading: Image.file(
                            File(_image!.path),
                            width: 50, // Customize the width as needed
                            height: 50, // Customize the height as needed
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              //
                              setState(() {
                                _image = null;
                              });
                            },
                          ),
                        ),
                      )
                    : Container(),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    BtnPrimary(
                      title: "cancel",
                      onpress: () {
                        Routes.pop(context);
                      },
                      bgColor: Consts.klight2,
                      txtColor: Consts.kblack,
                      width: width * 0.33,
                    ),
                    BtnPrimary(
                      title: "Save",
                      width: width * 0.33,
                      txtColor: Consts.kwhite,
                      bgColor: Consts.kprimary,
                      onpress: () async {
                        // TODO: Other Incident Type
                        // TODO: UI Fix
                        // TODO: Location proper routing
                        //upload image to firebase
                        Loadings.showLoadingDialog(context, _keyLoader,
                            msg: "Please wait..");

                        String? imgPath = await uploadImageToFirebaseStorage();
                        if (imgPath != null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content:
                                      Text("Uploaded Image successfully")));
                          String? uid = await SecureStorage().getUserId();
                          Incident incident = Incident(null,
                              id: "",
                              incidentType: selectedIncident.toLowerCase(),
                              incidentPriority: selectedPriority,
                              reportedDate: DateTime.now().toUtc(),
                              longitude: widget.longitude,
                              latitude: widget.latitude,
                              description: _description.text,
                              reportedBy: uid!,
                              imgpath: imgPath,
                              isApproved: false,
                              isOpen: true);
                          try {
                            await DbMethods().raiseIncident(incident);
                            Navigator.of(_keyLoader.currentContext!,
                                    rootNavigator: true)
                                .pop();
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(
                                    "Incident Raised and pending for approval${widget.latitude} ${widget.longitude}")));
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const HomePage()));
                          } catch (e) {
                            Navigator.of(_keyLoader.currentContext!,
                                    rootNavigator: true)
                                .pop();
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text("Failed to register")));
                          }
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

  void _openBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext builderContext) {
        return Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(vertical: 28),
            height: 120,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    _getImage(ImageSource.camera);
                    Navigator.pop(context);
                    print(_image);
                  },
                  child: const Column(
                    children: [
                      Icon(
                        Icons.camera_alt_outlined,
                        size: 36,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text("camera"),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    _getImage(ImageSource.gallery);
                    Navigator.pop(context);
                    print(_image);
                  },
                  child: const Column(
                    children: [
                      Icon(Icons.photo, size: 36),
                      SizedBox(
                        height: 5,
                      ),
                      Text("Gallery"),
                    ],
                  ),
                ),
              ],
            ));
      },
    );
  }
}
