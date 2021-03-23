import 'dart:async';
import 'dart:io';

import 'package:FilmInn/Config/config.dart';
import 'package:FilmInn/Pages/Authentication%20Pages/register.dart';
import 'package:FilmInn/Widgets/defaultButtons.dart';
import 'package:FilmInn/Widgets/defaultTextfield.dart';
import 'package:FilmInn/Widgets/dialogWidgets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String userImageUrl = "";
  File _imageFile;
  TextEditingController usernameController = new TextEditingController();
  final CollectionReference updateCollection =
      FirebaseFirestore.instance.collection("users");

  Future updateUserData(String username, String imgURL) async {
    await FilmInn.sharedPreferences.setString(FilmInn.userName, username);
    return await updateCollection
        .doc(FilmInn.sharedPreferences.getString("uid"))
        .set({
      "email": FilmInn.sharedPreferences.getString(FilmInn.userEmail),
      "username": username,
      "url": imgURL,
      "uid": FilmInn.sharedPreferences.getString("uid"),
    });
  }

  @override
  Widget build(BuildContext context) {
    final double _screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(
          'Settings',
          style: TextStyle(
            fontFamily: 'Gotham',
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
          textAlign: TextAlign.left,
        ),
        backgroundColor: Colors.blue,
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: _selectAndPickImage,
                child: Container(
                  child: CircleAvatar(
                    radius: _screenWidth * 0.22,
                    backgroundColor: Colors.black,
                    backgroundImage: _imageFile == null
                        ? NetworkImage(
                            FilmInn.sharedPreferences.getString("url"))
                        : FileImage(_imageFile),
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(85.0)),
                      border: Border.all(
                        style: BorderStyle.solid,
                        width: 5,
                        color: Colors.blue,
                      )),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                width: 285.0,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Username',
                    style: TextStyle(
                      fontFamily: 'Gotham',
                      fontSize: 15,
                      color: const Color(0xffffffff),
                      letterSpacing: 0.8400000000000001,
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              DefaultTextfield(
                  controller: usernameController,
                  hintText:
                      FilmInn.sharedPreferences.getString(FilmInn.userName),
                  textInputType: TextInputType.multiline),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  uploadAndSaveImage();
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(9.0),
                    gradient: LinearGradient(
                      begin: Alignment(0.0, -1.0),
                      end: Alignment(0.0, 1.0),
                      colors: [Colors.blue, const Color(0xff242780)],
                      stops: [0.0, 1.0],
                    ),
                  ),
                  width: 150.0,
                  height: 60.0,
                  child: Center(
                    child: Text(
                      "Update Profile",
                      style: TextStyle(
                        fontFamily: 'Gotham',
                        fontSize: 17,
                        color: const Color(0xffffffff),
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _selectAndPickImage() async {
    _imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      //_imageFile = _imageFile;
    });
  }

  Future<void> uploadAndSaveImage() async {
    if (_imageFile == null) {
      updateUserData(usernameController.text.trim(),
          FilmInn.sharedPreferences.get(FilmInn.userAvatarUrl));
    } else {
      uploadToStorage();
    }
  }

  displayDialog(String msg) {
    showDialog(
        context: context,
        builder: (c) {
          return ErrorAlertDialog(
            errorMessage: msg,
          );
        });
  }

  Future<void> uploadToStorage() async {
    String imageFileName = DateTime.now().millisecondsSinceEpoch.toString();

    Reference stroageReference =
        FirebaseStorage.instance.ref().child(imageFileName);

    UploadTask storageUploadTask =
        stroageReference.putFile(await compressFile(_imageFile));

    TaskSnapshot taskSnapshot = await storageUploadTask;

    await taskSnapshot.ref.getDownloadURL().then((urlImage) {
      userImageUrl = urlImage;
    });

    await FilmInn.sharedPreferences
        .setString(FilmInn.userAvatarUrl, userImageUrl);
    if (usernameController.text.trim() == "") {
      updateUserData(FilmInn.sharedPreferences.getString(FilmInn.userName),
        FilmInn.sharedPreferences.get(FilmInn.userAvatarUrl));
    } else {
      updateUserData(usernameController.text.trim(),
          FilmInn.sharedPreferences.get(FilmInn.userAvatarUrl));
    }

    Fluttertoast.showToast(
        msg: "Upload is successfull.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: const Color(0xff484dff),
        textColor: Colors.white,
        fontSize: 16.0);
    Timer(Duration(milliseconds: 100), () {
      setState(() {});
    });
  }
}
