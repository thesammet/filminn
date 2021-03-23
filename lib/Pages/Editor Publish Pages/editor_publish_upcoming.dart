import 'package:FilmInn/Widgets/defaultButtons.dart';
import 'package:FilmInn/Widgets/defaultTextfield.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class EditorPublishUpcoming extends StatefulWidget {
  @override
  _EditorPublishUpcomingState createState() => _EditorPublishUpcomingState();
}

class _EditorPublishUpcomingState extends State<EditorPublishUpcoming> {
  TextEditingController filmName = new TextEditingController();
  TextEditingController imgUrl = new TextEditingController();
  final DBRef = FirebaseDatabase.instance.reference();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Upcoming Film Publish',
          style: TextStyle(
            fontFamily: 'Gotham',
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
          textAlign: TextAlign.left,
        ),
        backgroundColor: const Color(0xff484dff),
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 20,
              ),
              Container(
                width: 285.0,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Film Name',
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
                controller: filmName,
                hintText: "Ex. Promising Young Woman",
                textInputType: TextInputType.emailAddress,
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: 285.0,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Image URL',
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
                controller: imgUrl,
                hintText: "Ex. https://encrypted-tbn0.gstati...",
                textInputType: TextInputType.emailAddress,
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                width: 280.0,
                child: Text(
                  '*You can pick a image from Google, Imdb etc. When you find the image long press image and choose open picture in new tab and copy the url address',
                  style: TextStyle(
                    fontFamily: 'Gotham',
                    fontSize: 9,
                    color: const Color(0xffffffff),
                    letterSpacing: 0.8400000000000001,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              Container(
                width: 280.0,
                child: Text(
                  '*Please select high pixel(quality) and vertical image',
                  style: TextStyle(
                    fontFamily: 'Gotham',
                    fontSize: 9,
                    color: const Color(0xffffffff),
                    letterSpacing: 0.8400000000000001,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  print("publish upcoming tıklandı.");
                  filmName.text.isNotEmpty && imgUrl.text.isNotEmpty
                      ? publishUpcoming().then((value) {
                          Navigator.pop(context);
                          Fluttertoast.showToast(
                              msg:
                                  "Success. Thanks for your upcoming review.\nWaiting your review.",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: const Color(0xff484dff),
                              textColor: Colors.white,
                              fontSize: 16.0);
                        })
                      : Fluttertoast.showToast(
                          msg: "You must fill the all blanks.",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: const Color(0xff484dff),
                          textColor: Colors.white,
                          fontSize: 16.0);
                },
                child: DefaultButton(
                  text: "Publish",
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> publishUpcoming() async {
    await DBRef.child("Data")
        .child("upcoming")
        .child(filmName.text.trim())
        .set({
      "name": filmName.text.trim(),
      "imgUrl": imgUrl.text.trim(),
    });
  }
}
