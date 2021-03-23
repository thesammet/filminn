import 'package:FilmInn/Widgets/defaultButtons.dart';
import 'package:FilmInn/Widgets/defaultTextfield.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class EditorPublishNew extends StatefulWidget {
  @override
  _EditorPublishNewState createState() => _EditorPublishNewState();
}

class _EditorPublishNewState extends State<EditorPublishNew> {
  TextEditingController author = new TextEditingController();
  TextEditingController date = new TextEditingController();
  TextEditingController imgUrl1 = new TextEditingController();
  TextEditingController imgUrl2 = new TextEditingController();
  TextEditingController newsDetail1 = new TextEditingController();
  TextEditingController newsDetail2 = new TextEditingController();
  TextEditingController title = new TextEditingController();
  final DBRef = FirebaseDatabase.instance.reference();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Film News Publish',
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
                    'New Title',
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
                controller: title,
                hintText: "Ex. Justice League: New Junkie XL...",
                textInputType: TextInputType.multiline,
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: 285.0,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Date',
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
                controller: date,
                hintText: "Ex. 21/02/2021(day/month/year)",
                textInputType: TextInputType.multiline,
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: 285.0,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Author',
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
                controller: author,
                hintText: "Ex. Abdu Samed AKGUL",
                textInputType: TextInputType.multiline,
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: 285.0,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'New Detail 1',
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
              EditorSubTitleTextField(
                  controller: newsDetail1,
                  hintText: "Ex. In filmmaker Emerald Fennell's...",
                  textInputType: TextInputType.multiline),
              SizedBox(
                height: 10,
              ),
              Container(
                width: 285.0,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'New Detail 2',
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
              EditorSubTitleTextField(
                controller: newsDetail2,
                hintText: "Ex. The movie is going to be...",
                textInputType: TextInputType.emailAddress,
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                width: 285.0,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Image URL 1 (topic URL)',
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
                controller: imgUrl1,
                hintText: "Ex. https://encrypted-tbn0.gstati...",
                textInputType: TextInputType.emailAddress,
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
                height: 13,
              ),
              Container(
                width: 285.0,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Image URL 2',
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
                controller: imgUrl2,
                hintText: "Ex. https://encrypted-tbn0.gstati...",
                textInputType: TextInputType.emailAddress,
              ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  print("publish film tıklandı.");
                  author.text.isNotEmpty &&
                          imgUrl1.text.isNotEmpty &&
                          imgUrl2.text.isNotEmpty &&
                          date.text.isNotEmpty &&
                          title.text.isNotEmpty &&
                          newsDetail1.text.isNotEmpty &&
                          newsDetail2.text.isNotEmpty &&
                          date.text.isNotEmpty
                      ? publishNew().then((value) {
                          Navigator.pop(context);
                          Fluttertoast.showToast(
                              msg: "Success. Thanks for your new review.",
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

  Future<void> publishNew() async {
    await DBRef.child("Data").child("news").child(title.text.trim()).set({
      "author": author.text.trim(),
      "date": date.text.trim(),
      "imgUrl1": imgUrl1.text.trim(),
      "imgUrl2": imgUrl2.text.trim(),
      "newsDetail1": newsDetail1.text.trim(),
      "newsDetail2": newsDetail2.text.trim(),
      "title": title.text.trim(),
    });
  }
}
