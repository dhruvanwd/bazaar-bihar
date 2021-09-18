import 'dart:io';

import 'package:bazaar_bihar/Utils/extensions.dart';
import 'package:bazaar_bihar/components/CustomAvatar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_mask/easy_mask.dart';
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

  updateCtrls() {
    final profile = GlobalController.to.userProfile;
    if (profile != null) {
      _fullName = TextEditingController(text: profile.fullName);
      _mobile = TextEditingController(text: profile.mobile);
      _email = TextEditingController(text: profile.email);
    }
  }

  _MapScreenState() {
    updateCtrls();
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

  onUpdateProfile(BuildContext context) async {
    if (_fullName.text.isEmpty) {
      Get.snackbar(
        "Name can't be empty",
        "Invalid input",
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    } else if (_mobile.text.isEmpty) {
      Get.snackbar(
        "Mobile number can't be empty",
        "Invalid input",
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    } else if (_email.text.isEmpty) {
      Get.snackbar(
        "Email can't be empty",
        "Invalid input",
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }
    await GlobalController.to.updateUserProfile({
      "fullName": _fullName.text,
      "mobile": _mobile.text.removeWhiteSpaces,
      "email": _email.text,
    });
    updateCtrls();
    setState(() {
      _status = true;
      FocusScope.of(context).requestFocus(FocusNode());
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
                                ? CustomAvatar(
                                    child: Image.file(
                                      File(_imageFile.path),
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : CustomAvatar(
                                    child: CachedNetworkImage(
                                      fit: BoxFit.cover,
                                      imageUrl: _.userProfile!.avatar,
                                      errorWidget: (_, url, error) =>
                                          Image.asset('images/as.png'),
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
                        padding:
                            EdgeInsets.only(left: 25.0, right: 25.0, top: 10.0),
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
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.only(
                              left: 25.0, right: 25.0, top: 2.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Flexible(
                                child: TextField(
                                  controller: _mobile,
                                  inputFormatters: [
                                    TextInputMask(
                                        mask: '999 9999 999', reverse: false)
                                  ],
                                  keyboardType: TextInputType.phone,
                                  decoration: const InputDecoration(
                                      prefixText: "+91",
                                      hintText: "Enter Mobile Number"),
                                  enabled: !_status,
                                ),
                              ),
                            ],
                          )),
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
                child: Text(
                  "Save",
                  style: TextStyle(color: Colors.green),
                ),
                onPressed: () {
                  onUpdateProfile(context);
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
                child: Text(
                  "Cancel",
                  style: TextStyle(color: Colors.red),
                ),
                onPressed: () {
                  setState(() {
                    updateCtrls();
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
