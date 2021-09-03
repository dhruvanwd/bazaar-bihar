import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:bazaar_bihar/GetxControllers/GlobalController.dart';
import 'package:image_picker/image_picker.dart';

typedef void OnPickImageCallback(
    double? maxWidth, double? maxHeight, int? quality);

class ProfilePage extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<ProfilePage>
    with SingleTickerProviderStateMixin {
  bool _status = true;
  final FocusNode myFocusNode = FocusNode();
  late TextEditingController _fullName;
  late TextEditingController _mobile;
  late TextEditingController _email;
  dynamic _pickImageError;
  _MapScreenState() {
    final profile = GlobalController.to.userProfile;
    _fullName = TextEditingController(text: profile.fullName);
    _mobile = TextEditingController(text: profile.mobile);
    _email = TextEditingController(text: profile.email);
  }

  final ImagePicker _picker = ImagePicker();
  var _imageFile;

  selectImage(BuildContext context) async {
    try {
      final pickedFile = await _picker.pickImage(
        source: ImageSource.camera,
        maxWidth: 200,
        maxHeight: 200,
      );
      setState(() {
        _imageFile = pickedFile!;
      });
    } catch (e) {
      setState(() {
        _pickImageError = e;
      });

      print(e);
    }
  }

  onUpdateProfile() {
    GlobalController.to.updateUserProfile({
      "fullName": _fullName.text,
      "mobile": _mobile.text,
      "email": _email.text,
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GlobalController>(builder: (_) {
      return SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Column(
            children: <Widget>[
              Container(
                color: Colors.white,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(
                        top: 20.0,
                        bottom: 10,
                      ),
                      child: Stack(fit: StackFit.loose, children: <Widget>[
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            _imageFile != null
                                ? SizedBox(
                                    width: 140.0,
                                    height: 140.0,
                                    child: Card(
                                      clipBehavior: Clip.hardEdge,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                      ),
                                      child: Image.file(
                                        File(_imageFile.path),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  )
                                : Container(
                                    width: 140.0,
                                    height: 140.0,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        image: ExactAssetImage('images/as.png'),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                          ],
                        ),
                        Padding(
                            padding: EdgeInsets.only(top: 90.0, right: 100.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                CircleAvatar(
                                  backgroundColor: Colors.red,
                                  radius: 25.0,
                                  child: IconButton(
                                    onPressed: () {
                                      selectImage(context);
                                    },
                                    icon: Icon(
                                      Icons.camera_alt,
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                              ],
                            )),
                      ]),
                    )
                  ],
                ),
              ),
              Container(
                color: Color(0xffFFFFFF),
                child: Padding(
                  padding: EdgeInsets.only(bottom: 25.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                          padding: EdgeInsets.only(
                              left: 25.0, right: 25.0, top: 25.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Text(
                                    'Parsonal Information',
                                    style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  _status ? _getEditIcon() : Container(),
                                ],
                              )
                            ],
                          )),
                      Padding(
                          padding: EdgeInsets.only(
                              left: 25.0, right: 25.0, top: 25.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Text(
                                    'Name',
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          )),
                      Padding(
                          padding: EdgeInsets.only(
                              left: 25.0, right: 25.0, top: 2.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Flexible(
                                child: TextField(
                                  controller: _fullName,
                                  decoration: const InputDecoration(
                                    hintText: "Enter Your Name",
                                  ),
                                  enabled: !_status,
                                  autofocus: !_status,
                                ),
                              ),
                            ],
                          )),
                      Padding(
                          padding: EdgeInsets.only(
                              left: 25.0, right: 25.0, top: 25.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Text(
                                    'Email ID',
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          )),
                      Padding(
                          padding: EdgeInsets.only(
                              left: 25.0, right: 25.0, top: 2.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Flexible(
                                child: TextField(
                                  controller: _email,
                                  decoration: const InputDecoration(
                                      hintText: "Enter Email ID"),
                                  enabled: !_status,
                                ),
                              ),
                            ],
                          )),
                      Padding(
                          padding: EdgeInsets.only(
                              left: 25.0, right: 25.0, top: 10.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Text(
                                    'Mobile',
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          )),
                      Padding(
                          padding: EdgeInsets.only(
                              left: 25.0, right: 25.0, top: 2.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Flexible(
                                child: TextField(
                                  controller: _mobile,
                                  decoration: const InputDecoration(
                                      prefixText: "+91",
                                      hintText: "Enter Mobile Number"),
                                  enabled: !_status,
                                ),
                              ),
                            ],
                          )),
                      // Padding(
                      //     padding: EdgeInsets.only(
                      //         left: 25.0, right: 25.0, top: 10.0),
                      //     child: Row(
                      //       mainAxisSize: MainAxisSize.max,
                      //       mainAxisAlignment: MainAxisAlignment.start,
                      //       children: <Widget>[
                      //         Expanded(
                      //           child: Container(
                      //             child: Text(
                      //               'City',
                      //               style: TextStyle(
                      //                   fontSize: 16.0,
                      //                   fontWeight: FontWeight.bold),
                      //             ),
                      //           ),
                      //           flex: 2,
                      //         ),
                      //         Expanded(
                      //           child: Container(
                      //             child: Text(
                      //               'State',
                      //               style: TextStyle(
                      //                   fontSize: 16.0,
                      //                   fontWeight: FontWeight.bold),
                      //             ),
                      //           ),
                      //           flex: 2,
                      //         ),
                      //       ],
                      //     )),
                      // Padding(
                      //     padding: EdgeInsets.only(
                      //         left: 25.0, right: 25.0, top: 2.0),
                      //     child: Row(
                      //       mainAxisSize: MainAxisSize.max,
                      //       mainAxisAlignment: MainAxisAlignment.start,
                      //       children: <Widget>[
                      //         Flexible(
                      //           child: Padding(
                      //             padding: EdgeInsets.only(right: 10.0),
                      //             child: TextField(
                      //               controller: _city,
                      //               decoration:
                      //                   const InputDecoration(hintText: "City"),
                      //               enabled: !_status,
                      //             ),
                      //           ),
                      //           flex: 2,
                      //         ),
                      //         Flexible(
                      //           child: TextField(
                      //             controller: _state,
                      //             decoration: const InputDecoration(
                      //                 hintText: "Enter State"),
                      //             enabled: !_status,
                      //           ),
                      //           flex: 2,
                      //         ),
                      //       ],
                      //     )),
                      !_status ? _getActionButtons() : Container(),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      );
    });
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    myFocusNode.dispose();
    super.dispose();
  }

  Widget _getActionButtons() {
    return Padding(
      padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 45.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: OutlinedButton(
                child: Text("Save"),
                onPressed: () {
                  setState(() {
                    _status = true;
                    FocusScope.of(context).requestFocus(FocusNode());
                    onUpdateProfile();
                  });
                },
                // shape:  RoundedRectangleBorder(
                //     borderRadius:  BorderRadius.circular(20.0)),
              ),
            ),
            flex: 2,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: OutlinedButton(
                child: Text("Cancel"),
                onPressed: () {
                  setState(() {
                    _status = true;
                    FocusScope.of(context).requestFocus(FocusNode());
                  });
                },
              ),
            ),
            flex: 2,
          ),
        ],
      ),
    );
  }

  Widget _getEditIcon() {
    return GestureDetector(
      child: CircleAvatar(
        backgroundColor: Get.theme.primaryColor,
        radius: 14.0,
        child: Icon(
          Icons.edit,
          color: Colors.white,
          size: 16.0,
        ),
      ),
      onTap: () {
        setState(() {
          _status = false;
        });
      },
    );
  }
}
