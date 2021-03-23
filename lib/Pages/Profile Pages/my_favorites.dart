import 'dart:async';

import 'package:FilmInn/Config/config.dart';
import 'package:FilmInn/Pages/Main%20Pages/film_crit_detail.dart';
import 'package:FilmInn/Pages/Main%20Pages/home.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../../Data.dart';

class FavoirtesPage extends StatefulWidget {
  @override
  _FavoirtesPageState createState() => _FavoirtesPageState();
}

class _FavoirtesPageState extends State<FavoirtesPage> {
  List<FilmData> filmdataList = [];

  List<bool> favList = [];
  @override
  void initState() {
    super.initState();
    DatabaseReference referenceData =
        FirebaseDatabase.instance.reference().child("Data").child("films");
    referenceData.once().then((DataSnapshot dataSnapshot) {
      filmdataList.clear();
      var keys = dataSnapshot.value.keys;
      var values = dataSnapshot.value;
      for (var key in keys) {
        FilmData dataFilms = new FilmData(
            values[key]['filmName'],
            values[key]['imgUrl'],
            values[key]['subTitle'],
            values[key]['date'],
            values[key]['imdb'],
            values[key]['category'],
            //uploadid
            key,
            values[key]['year'],);
        print(values[key]['category']);

        DatabaseReference reference = FirebaseDatabase.instance
            .reference()
            .child("Data")
            .child("films")
            .child(key)
            .child("Favorite")
            .child(FilmInn.sharedPreferences.getString("uid"))
            .child("state");
        reference.once().then((DataSnapshot snapShot) {
          if (snapShot.value != null) {
            if (snapShot.value == "true") {
              setState(() {
                filmdataList.add(dataFilms);
              });
            }
          }
        });
      }
    });
    Timer(Duration(milliseconds: 100), () {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Favorites"),
      ),
      body: Container(
        color: Colors.black,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: GridView.builder(
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 150,
              childAspectRatio: 1 / 1.5,
            ),
            itemCount: filmdataList.length,
            itemBuilder: (_, index) {
              return FilmDetailCardUIs(
                filmdataList[index].filmName,
                filmdataList[index].imgUrl,
                filmdataList[index].subTitle,
                filmdataList[index].date,
                filmdataList[index].imdb,
                filmdataList[index].category,
                filmdataList[index].uploadid,
                filmdataList[index].year,
              );
            }),
      ),
      /*Container(
        color: Colors.black,
        child: ListView.builder(
            itemCount: filmdataList.length,
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemBuilder: (_, index) {
              return FilmDetailCardUI(
                  filmName: filmdataList[index].filmName,
                  imgUrl: filmdataList[index].imgUrl,
                  subTitle: filmdataList[index].subTitle,
                  date: filmdataList[index].date,
                  imdb: filmdataList[index].imdb,
                  category: filmdataList[index].category,
                  uploadid: filmdataList[index].uploadid,
                  index: index,
                  favList: favList,
                  filmdataList: filmdataList);
            }),
      ),*/
    );
  }

  Widget FilmDetailCardUIs(
    String filmName,
    String imgUrl,
    String subTitle,
    String date,
    String imdb,
    String category,
    String uploadid,
    String year,
  ) {
    {
      return Card(
        color: Colors.black,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        child: InkWell(
          onDoubleTap: () {},
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => FilmCritDetail(
                          filmName: filmName,
                          imgUrl: imgUrl,
                          subTitle: subTitle,
                          date: date,
                          imdb: imdb,
                          category: category,
                        )));
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CachedNetworkImage(
                    width: 120,
                    height: 172,
                    imageUrl: imgUrl,
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(2.0)),
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                          colorFilter: ColorFilter.mode(
                              Colors.blue[150], BlendMode.colorBurn),
                        ),
                      ),
                    ),
                    placeholder: (context, url) => Center(
                        child: CircularProgressIndicator(
                      backgroundColor: Colors.white,
                    )),
                    errorWidget: (context, url, error) => Icon(
                      Icons.error,
                      color: Colors.white,
                    ),
                  ),
                  IconButton(
                      icon: Icon(
                        Icons.favorite,
                        color: Colors.red,
                      ),
                      onPressed: () {
                        DatabaseReference favRef = FirebaseDatabase.instance
                            .reference()
                            .child("Data")
                            .child("films")
                            .child(uploadid)
                            .child("Favorite")
                            .child(FilmInn.sharedPreferences.getString("uid"))
                            .child("state");

                        favRef.set("false");
                        setState(() {
                          FavoriteFunc();
                        });
                      })
                ],
              ),
            ],
          ),
        ),
      );
    }
  }

  void FavoriteFunc() {
    DatabaseReference referenceData =
        FirebaseDatabase.instance.reference().child("Data").child("films");
    referenceData.once().then((DataSnapshot dataSnapshot) {
      filmdataList.clear();
      var keys = dataSnapshot.value.keys;
      var values = dataSnapshot.value;
      for (var key in keys) {
        FilmData dataFilms = new FilmData(
            values[key]['filmName'],
            values[key]['imgUrl'],
            values[key]['subTitle'],
            values[key]['date'],
            values[key]['imdb'],
            values[key]['category'],
            //uploadid
            key,
            values[key]['year'],);
        print(values[key]['category']);

        DatabaseReference reference = FirebaseDatabase.instance
            .reference()
            .child("Data")
            .child("films")
            .child(key)
            .child("Favorite")
            .child(FilmInn.sharedPreferences.getString("uid"))
            .child("state");
        reference.once().then((DataSnapshot snapShot) {
          if (snapShot.value != null) {
            if (snapShot.value == "true") {
              filmdataList.add(dataFilms);
            }
          }
        });
      }
    });
    Timer(Duration(seconds: 1), () {
      setState(() {});
    });
  }
}
