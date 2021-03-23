import 'package:FilmInn/Config/config.dart';
import 'package:FilmInn/Pages/Authentication%20Pages/login.dart';
import 'package:FilmInn/Pages/Authentication%20Pages/register.dart';
import 'package:FilmInn/Widgets/defaultButtons.dart';
import 'package:FilmInn/Widgets/defaultTextfield.dart';
import 'package:FilmInn/Widgets/dialogWidgets.dart';
import 'package:FilmInn/Widgets/logo.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../Editor Publish Pages/editor_page.dart';
import '../Main Pages/home.dart';
import 'package:adobe_xd/pinned.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EditorLogin extends StatefulWidget {
  EditorLogin({Key key}) : super(key: key);

  @override
  _EditorLoginState createState() => _EditorLoginState();
}

class _EditorLoginState extends State<EditorLogin> {
  final TextEditingController _adminIDController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String editorName;
  IconData passwordIconData = Icons.visibility;
  bool _obscureText = true;
  String _password;
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.black,
              image: DecorationImage(
                  fit: BoxFit.scaleDown,
                  colorFilter: new ColorFilter.mode(
                      Colors.black.withOpacity(0.5), BlendMode.dstATop),
                  alignment: FractionalOffset.topCenter,
                  image: AssetImage("lib/assets/images/background.PNG")),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 50,
                ),
                Column(
                  children: [
                    Logo(),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'EDITOR LOGIN',
                      style: TextStyle(
                        fontFamily: 'Gotham',
                        fontSize: 24,
                        color: const Color(0xffffffff),
                        letterSpacing: 0.8400000000000001,
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
                SizedBox(
                  height: 50,
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40.0, vertical: 5),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'EDITOR ID',
                                  style: TextStyle(
                                    fontFamily: 'Gotham',
                                    fontSize: 15,
                                    color: const Color(0xffffffff),
                                    letterSpacing: 0.8400000000000001,
                                    fontWeight: FontWeight.w700,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                DefaultTextfield(
                                  controller: _adminIDController,
                                  hintText: "Ex. filminn1907",
                                  textInputType: TextInputType.emailAddress,
                                ),
                              ],
                            ),
                            SizedBox(height: 7),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'PASSWORD',
                                  style: TextStyle(
                                    fontFamily: 'Gotham',
                                    fontSize: 15,
                                    color: const Color(0xffffffff),
                                    letterSpacing: 0.8400000000000001,
                                    fontWeight: FontWeight.w700,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                                Container(
                                  width: 285.0,
                                  height: 50.0,
                                  decoration: BoxDecoration(
                                    color: const Color(0xff707070),
                                    borderRadius:
                                        new BorderRadius.circular(9.0),
                                  ),
                                  child: TextFormField(
                                    cursorColor: Colors.white,
                                    controller: _passwordController,
                                    decoration: new InputDecoration(
                                      suffixIcon: IconButton(
                                          color: Colors.white,
                                          onPressed: () {
                                            _toggle();
                                            _obscureText
                                                ? passwordIconData =
                                                    Icons.visibility
                                                : passwordIconData =
                                                    Icons.visibility_off;
                                          },
                                          icon: Icon(passwordIconData)),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(9.0),
                                        borderSide: BorderSide(
                                          color: Colors.black,
                                        ),
                                      ),
                                      hintText: "********",
                                      hintStyle: TextStyle(
                                        fontFamily: 'Gotham',
                                        fontSize: 17,
                                        color: const Color(0xffCBC9C9),
                                        fontWeight: FontWeight.w300,
                                      ),
                                      border: new OutlineInputBorder(
                                        borderRadius:
                                            new BorderRadius.circular(9.0),
                                      ),
                                    ),
                                    validator: (val) => val.length < 6
                                        ? 'Password too short.'
                                        : null,
                                    onSaved: (val) => _password = val,
                                    obscureText: _obscureText,
                                    style: TextStyle(
                                      fontFamily: 'Gotham',
                                      fontSize: 17,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        print("login tıklandı.");
                        _adminIDController.text.isNotEmpty &&
                                _passwordController.text.isNotEmpty
                            ? loginEditor()
                            : showDialog(
                                context: context,
                                builder: (c) {
                                  return ErrorAlertDialog(
                                    errorMessage:
                                        "Please write email and password",
                                  );
                                });
                      },
                      child: DefaultButton(
                        text: "Login",
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) => Login()));
                  },
                  child: Text(
                    'I\'m not an Film Inn Editor',
                    style: TextStyle(
                      fontFamily: 'Gotham',
                      fontSize: 14,
                      color: const Color(0xffffffff),
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  loginEditor() {
    FirebaseFirestore.instance.collection("editors").get().then((snapshot) {
      snapshot.docs.forEach((result) {
        if (result.data()['id'] != _adminIDController.text.trim()) {
          Fluttertoast.showToast(
              msg: "Editor ID is not correct",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: const Color(0xff484dff),
              textColor: Colors.white,
              fontSize: 16.0);
        } else if (result.data()['password'] !=
            _passwordController.text.trim()) {
          Fluttertoast.showToast(
              msg: "Editor password is not correct",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: const Color(0xff484dff),
              textColor: Colors.white,
              fontSize: 16.0);
        } else {
          setState(() {
            editorName = result.data()["name"];
          });
          Fluttertoast.showToast(
              msg: "Welcome Login Success",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: const Color(0xff484dff),
              textColor: Colors.white,
              fontSize: 16.0);

          setState(() {
            _adminIDController.text = "";
            _passwordController.text = "";
          });
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => EditorUploadPage(
                        editorName: editorName,
                      )));
        }
      });
    });
  }
}
