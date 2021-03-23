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
import 'package:url_launcher/url_launcher.dart';

class ContactUs extends StatefulWidget {
  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  String linkedinUrl =
      'https://www.linkedin.com/in/abd%C3%BC-samed-akg%C3%BCl-383906173/';
  String twitterUrl = "https://twitter.com/film_inn";
  String instagramUrl = "https://www.instagram.com/filminnapp/";

  @override
  Widget build(BuildContext context) {
    final double _screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      /*appBar: AppBar(
        title: Text(
          'Contact Us',
          style: TextStyle(
            fontFamily: 'Gotham',
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
          textAlign: TextAlign.left,
        ),
        backgroundColor: Colors.blue,
      ),*/
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Container(
          child: SingleChildScrollView(
            child: Center(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.arrow_back_ios,
                              size: 28,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Text(
                          "Contact Us",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Gotham',
                            fontSize: 22,
                            color: const Color(0xffffffff),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: () => launch(_emailLaunchUri.toString()),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.blue[400],
                        ),
                        height: 75,
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 20,
                              ),
                              Icon(Icons.mail_outline),
                              SizedBox(
                                width: 20,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Film Inn E-mail",
                                    style: TextStyle(
                                      fontFamily: 'Gotham',
                                      fontSize: 15,
                                      color: const Color(0xffffffff),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    "filminnapp@gmail.com",
                                    style: TextStyle(
                                      fontFamily: 'Gotham',
                                      fontSize: 15,
                                      color: const Color(0xffffffff),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    InkWell(
                      onTap: () => _launchURL(instagramUrl),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.blue[400],
                        ),
                        height: 75,
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 20,
                              ),
                              Icon(Icons.camera),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                "Film Inn Instagram",
                                style: TextStyle(
                                  fontFamily: 'Gotham',
                                  fontSize: 15,
                                  color: const Color(0xffffffff),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    InkWell(
                      onTap: () => _launchURL(twitterUrl),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.blue[400],
                        ),
                        height: 75,
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 20,
                              ),
                              Icon(Icons.tag),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                "Film Inn Twitter",
                                style: TextStyle(
                                  fontFamily: 'Gotham',
                                  fontSize: 15,
                                  color: const Color(0xffffffff),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    InkWell(
                      onTap: () => _launchURL(linkedinUrl),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.blue[400],
                        ),
                        height: 75,
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 20,
                              ),
                              Icon(Icons.developer_board),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                "Developer's Linkedin Account",
                                style: TextStyle(
                                  fontFamily: 'Gotham',
                                  fontSize: 15,
                                  color: const Color(0xffffffff),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _launchURL(String _url) async => await canLaunch(_url)
      ? await launch(_url)
      : throw 'Could not launch $_url';

  final Uri _emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'filminapp@gmail.com',
      queryParameters: {'subject': 'Film Inn Application contact!'});
}
