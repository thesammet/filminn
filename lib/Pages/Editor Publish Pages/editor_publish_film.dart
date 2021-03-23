import 'package:FilmInn/Widgets/defaultButtons.dart';
import 'package:FilmInn/Widgets/defaultTextfield.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class EditorPublishFilm extends StatefulWidget {
  @override
  _EditorPublishFilmState createState() => _EditorPublishFilmState();
}

class _EditorPublishFilmState extends State<EditorPublishFilm> {
  TextEditingController filmName = new TextEditingController();
  TextEditingController category = new TextEditingController();
  TextEditingController date = new TextEditingController();
  TextEditingController subTitle = new TextEditingController();
  TextEditingController imgUrl = new TextEditingController();
  TextEditingController imdb = new TextEditingController();
  TextEditingController year = new TextEditingController();

  final DBRef = FirebaseDatabase.instance.reference();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Film Review Publish',
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
                    'Category',
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
                controller: category,
                hintText: "Ex. Drama | Adventure",
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
                    'Review',
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
                  controller: subTitle,
                  hintText:
                      "Ex. In filmmaker Emerald Fennell's diabolically funny takedown of toxic masculinity, Carey Mulligan gives a dynamite performance that should make her a frontrunner in the Oscar race for Best Actress...",
                  textInputType: TextInputType.multiline),
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
                    'Movie Release Year',
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
                controller: year,
                hintText: "Ex. 2020",
                textInputType: TextInputType.phone,
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: 285.0,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'IMDB',
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
                controller: imdb,
                hintText: "Ex. 7.6",
                textInputType: TextInputType.emailAddress,
              ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  print("publish film tıklandı.");
                  filmName.text.isNotEmpty &&
                          category.text.isNotEmpty &&
                          date.text.isNotEmpty &&
                          imdb.text.isNotEmpty &&
                          imgUrl.text.isNotEmpty &&
                          subTitle.text.isNotEmpty &&
                          year.text.isNotEmpty
                      ? publishFilm().then((value) {
                          Navigator.pop(context);
                          Fluttertoast.showToast(
                              msg: "Success. Thanks for your film review.",
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

  Future<void> publishFilm() async {
    await DBRef.child("Data").child("films").child(filmName.text.trim()).set({
      "category": category.text.trim(),
      "date": date.text.trim(),
      "filmName": filmName.text.trim(),
      "imdb": imdb.text.trim(),
      "imgUrl": imgUrl.text.trim(),
      "subTitle": subTitle.text.trim(),
      "year": year.text.trim(),
    });
  }
}
