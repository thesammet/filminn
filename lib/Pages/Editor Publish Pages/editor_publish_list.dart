import 'package:FilmInn/Widgets/defaultButtons.dart';
import 'package:FilmInn/Widgets/defaultTextfield.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class EditorPublishList extends StatefulWidget {
  @override
  _EditorPublishListState createState() => _EditorPublishListState();
}

class _EditorPublishListState extends State<EditorPublishList> {
  TextEditingController date = new TextEditingController();
  TextEditingController imgUrl1 = new TextEditingController();
  TextEditingController imgUrl2 = new TextEditingController();
  TextEditingController imgUrl3 = new TextEditingController();
  TextEditingController subTitle1 = new TextEditingController();
  TextEditingController subTitle2 = new TextEditingController();
  TextEditingController subTitle3 = new TextEditingController();
  TextEditingController title = new TextEditingController();

  final DBRef = FirebaseDatabase.instance.reference();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Film List Publish',
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
                hintText: "Ex. 21/02/2021 (day/month/year)",
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
                    'Title',
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
                hintText: "Ex. Three perfect dramas.",
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
                    'Review 1',
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
                controller: subTitle1,
                hintText: "Ex. Arrival: Denis Villeneuve's empathic...",
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
                    'Review 2',
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
                  controller: subTitle2,
                  hintText: "Good Will Hunting: Remember when young actor...",
                  textInputType: TextInputType.multiline),
              SizedBox(
                height: 10,
              ),
              Container(
                width: 285.0,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Review 3',
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
                controller: subTitle3,
                hintText: "Ex. Lost In Translation: Sofia Coppola\'s...",
                textInputType: TextInputType.emailAddress,
              ),
              Container(
                width: 285.0,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Image Url 1(Topic Image)',
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
              Container(
                width: 280.0,
                child: Text(
                  '*You can pick a image from Google, Imdb etc. When you find the image long press image and choose open picture in new tab and copy the url address.',
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
                  '*Please select high pixel(quality) and ***horizontal*** image.',
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
              DefaultTextfield(
                controller: imgUrl1,
                hintText: "Ex. https://img-s1.onedio.com/1...",
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
                    'Image Url 2',
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
              DefaultTextfield(
                controller: imgUrl2,
                hintText: "Ex. https://img-s1.onedio.com/2...",
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
                    'Image Url 3',
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
              DefaultTextfield(
                controller: imgUrl3,
                hintText: "Ex. https://img-s1.onedio.com/3...",
                textInputType: TextInputType.emailAddress,
              ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  print("publish list tıklandı.");
                  title.text.isNotEmpty &&
                          date.text.isNotEmpty &&
                          subTitle1.text.isNotEmpty &&
                          subTitle2.text.isNotEmpty &&
                          subTitle3.text.isNotEmpty &&
                          imgUrl1.text.isNotEmpty &&
                          imgUrl2.text.isNotEmpty &&
                          imgUrl3.text.isNotEmpty
                      ? publishList().then((value) {
                          Navigator.pop(context);
                          Fluttertoast.showToast(
                              msg: "Success. Thanks for your list review.",
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

  Future<void> publishList() async {
    await DBRef.child("Data").child("lists").child(title.text.trim()).set({
      "date": date.text.trim(),
      "imgUrl1": imgUrl1.text.trim(),
      "imgUrl2": imgUrl2.text.trim(),
      "imgUrl3": imgUrl3.text.trim(),
      "subTitle1": subTitle1.text.trim(),
      "subTitle2": subTitle2.text.trim(),
      "subTitle3": subTitle3.text.trim(),
      "title": title.text.trim()
    });
  }
}
