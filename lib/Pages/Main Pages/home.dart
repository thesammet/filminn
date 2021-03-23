import 'dart:async';

import 'package:FilmInn/Config/config.dart';
import 'package:FilmInn/Pages/Authentication%20Pages/login.dart';
import 'package:FilmInn/Pages/Main%20Pages/new_detail.dart';
import 'package:FilmInn/Pages/Authentication%20Pages/register.dart';
import 'package:FilmInn/Pages/Profile%20Pages/contact.dart';
import 'package:FilmInn/Pages/Profile%20Pages/my_favorites.dart';
import 'package:FilmInn/Pages/Profile%20Pages/settings.dart';
import 'package:FilmInn/Widgets/logo.dart';
import 'package:admob_flutter/admob_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:FilmInn/services/advert_service.dart';
import '../../Data.dart';
import 'all_films.dart';
import 'all_lists.dart';
import 'film_crit_detail.dart';
import 'film_list_detail.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<FilmData> filmdataList = [];
  List<ListData> filmGroupList = [];
  List<UpcomingData> upcomingDataList = [];
  List<NewData> newDataList = [];
  GlobalKey<FormState> key = new GlobalKey<FormState>();
  GlobalKey<FormState> key2 = new GlobalKey<FormState>();
  GlobalKey<FormState> key3 = new GlobalKey<FormState>();
  TextEditingController searchText = new TextEditingController();
  bool searchState = false;
  int _selectedItemIndex = 0;
  FocusNode inputNodeMain = FocusNode();
  List<bool> favList = [];
  final tabs = [];

  //ADMOB
  final _advertService = AdvertService();

  @override
  void initState() {
    print(FilmInn.sharedPreferences.getString("uid"));
    filmData();
    upcomingData();
    newData();
    listData();
    print(FilmInn.sharedPreferences.getString("uid"));
  }

  Future<void> filmData() {
    if (FilmInn.sharedPreferences.getString("uid") == null) {
      DatabaseReference referenceData =
          FirebaseDatabase.instance.reference().child("Data").child("films");
      referenceData.once().then((DataSnapshot dataSnapshot) {
        filmdataList.clear();
        favList.clear();
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
            values[key]['year'],
          );

          setState(() {
            filmdataList.add(dataFilms);
          });
        }

        Timer(Duration(seconds: 1), () {
          setState(() {});
        });
      });
    } else {
      DatabaseReference referenceData =
          FirebaseDatabase.instance.reference().child("Data").child("films");
      referenceData.once().then((DataSnapshot dataSnapshot) {
        filmdataList.clear();
        favList.clear();
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
            values[key]['year'],
          );

          setState(() {
            filmdataList.add(dataFilms);
          });
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
                favList.add(true);
              } else {
                favList.add(false);
              }
            } else {
              favList.add(false);
            }
          });
          print(values[key]['filmName']);
        }

        Timer(Duration(seconds: 1), () {
          setState(() {});
        });
      });
    }
  }

  void listData() {
    DatabaseReference referenceData =
        FirebaseDatabase.instance.reference().child("Data").child("lists");
    referenceData.once().then((DataSnapshot dataSnapshot) {
      filmGroupList.clear();

      var keys = dataSnapshot.value.keys;
      var values = dataSnapshot.value;
      for (var key in keys) {
        ListData dataGroupFilms = new ListData(
          values[key]['date'],
          values[key]['imgUrl1'],
          values[key]['imgUrl2'],
          values[key]['imgUrl3'],
          values[key]['subTitle1'],
          values[key]['subTitle2'],
          values[key]['subTitle3'],
          values[key]['title'],
        );
        print(values[key]['title']);
        setState(() {
          filmGroupList.add(dataGroupFilms);
        });
      }
    });
  }

  void upcomingData() {
    DatabaseReference referenceData =
        FirebaseDatabase.instance.reference().child("Data").child("upcoming");
    referenceData.once().then((DataSnapshot dataSnapshot) {
      upcomingDataList.clear();

      var keys = dataSnapshot.value.keys;
      var values = dataSnapshot.value;
      for (var key in keys) {
        UpcomingData dataUpcomings = new UpcomingData(
          values[key]['imgUrl'],
          values[key]['name'],
        );
        print(values[key]['name']);
        print(values[key]['imgUrl']);
        setState(() {
          upcomingDataList.add(dataUpcomings);
        });
      }
    });
  }

  void newData() {
    DatabaseReference referenceData =
        FirebaseDatabase.instance.reference().child("Data").child("news");
    referenceData.once().then((DataSnapshot dataSnapshot) {
      newDataList.clear();

      var keys = dataSnapshot.value.keys;
      var values = dataSnapshot.value;
      for (var key in keys) {
        NewData dataNews = new NewData(
          values[key]['author'],
          values[key]['date'],
          values[key]['imgUrl1'],
          values[key]['imgUrl2'],
          values[key]['newsDetail1'],
          values[key]['newsDetail2'],
          values[key]['title'],
        );
        print(values[key]['title']);
        setState(() {
          newDataList.add(dataNews);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final tabs = [
      GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(color: Colors.black),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Logo(),
                        Text(
                          'Movies',
                          style: TextStyle(
                              fontFamily: 'Poppins-SemiBold',
                              fontSize: 32,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          color: const Color(0xffffffff),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0x1a000000),
                              offset: Offset(0, 3),
                              blurRadius: 5,
                            ),
                          ],
                        ),
                        child: TextField(
                          controller: searchText,
                          autofocus: false,
                          focusNode: inputNodeMain,
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(10.0),
                              hintText: "Search movie...",
                              hintStyle: TextStyle(
                                fontFamily: 'Nunito Sans',
                                fontSize: 17,
                                color: Colors.black26,
                              ),
                              suffixIcon: !searchState
                                  ? Icon(Icons.search,
                                      color: const Color(0xff8B8C8B), size: 32)
                                  : IconButton(
                                      icon: Icon(Icons.cancel,
                                          color: const Color(0xff8B8C8B),
                                          size: 32),
                                      onPressed: () {
                                        FocusScope.of(context)
                                            .requestFocus(new FocusNode());
                                        searchText.text = "";
                                        SearchMethod("");
                                        setState(() {
                                          searchState = false;
                                        });
                                      })),
                          onEditingComplete: () {
                            FocusScope.of(context)
                                .requestFocus(new FocusNode());
                            setState(() {
                              searchState = true;
                            });
                          },
                          onChanged: (text) {
                            searchState = true;
                            SearchMethod(text.toLowerCase());
                          },
                        )),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AllFilms(
                                    filmdataList: filmdataList,
                                  )));
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(top: 15.0, right: 20.0),
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: Text(
                          'VIEW ALL',
                          style: TextStyle(
                            fontFamily: 'Poppins-SemiBold',
                            fontSize: 17,
                            color: const Color(0xff3d4cff),
                          ),
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 20, left: 20, bottom: 10),
                    height: 250,
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
                            year: filmdataList[index].year,
                          );
                        }),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Film List',
                            style: TextStyle(
                              fontFamily: 'Poppins-SemiBold',
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xffffffff),
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AllLists(
                                        filmGroupList2: filmGroupList,
                                      )));
                        },
                        child: Padding(
                          padding:
                              const EdgeInsets.only(top: 15.0, right: 20.0),
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: Text(
                              'VIEW ALL',
                              style: TextStyle(
                                fontFamily: 'Poppins-SemiBold',
                                fontSize: 17,
                                color: const Color(0xff3d4cff),
                              ),
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      right: 20,
                      left: 20,
                    ),
                    height: 230,
                    child: ListView.builder(
                        itemCount: filmGroupList.length,
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemBuilder: (_, index) {
                          return FilmListCardUI(
                            date: filmGroupList[index].date,
                            imgUrl1: filmGroupList[index].imgUrl1,
                            imgUrl2: filmGroupList[index].imgUrl2,
                            imgUrl3: filmGroupList[index].imgUrl3,
                            subTitle1: filmGroupList[index].subTitle1,
                            subTitle2: filmGroupList[index].subTitle2,
                            subTitle3: filmGroupList[index].subTitle3,
                            title: filmGroupList[index].title,
                          );
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Upcoming',
                        style: TextStyle(
                          fontFamily: 'Poppins-SemiBold',
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xffffffff),
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      right: 20,
                      left: 20,
                      top: 10,
                    ),
                    height: 250,
                    child: ListView.builder(
                        itemCount: upcomingDataList.length,
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemBuilder: (_, index) {
                          return UpcomingCardUI(
                            name: upcomingDataList[index].name,
                            imgUrl: upcomingDataList[index].imgUrl,
                          );
                        }),
                  ),
                ],
              ),
            ),
          ),
          /*child: dataList.length == 0
                                      ? Center(
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              CircularProgressIndicator(),
                                              SizedBox(
                                                height: 7,
                                              ),
                                              Text("Films are loading...")
                                            ],
                                          ),
                                        )
                                      : Container(
                                          child: ListView.builder(
                                              itemCount: dataList.length,
                                              itemBuilder: (_, index) {
                                                return FilmDetailCardUI(
                                                  filmName: dataList[index].filmName,
                                                  imgUrl: dataList[index].imgUrl,
                                                  title: dataList[index].title,
                                                  subTitle: dataList[index].subTitle,
                                                  date: dataList[index].date,
                                                  like: dataList[index].like,
                                                  comments: dataList[index].comments,
                                                );
                                              }),
                                        ),*/
        ),
      ),
      SafeArea(
        child: SingleChildScrollView(
          key: key3,
          child: Container(
            decoration: BoxDecoration(color: Colors.black),
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(right: 20.0, left: 20.0, top: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                          onTap: () {
                            print("logo tıklandı.");
                            setState(() {
                              _selectedItemIndex = 0;
                            });
                          },
                          child: Logo()),
                      Text(
                        'News',
                        style: TextStyle(
                            fontFamily: 'Poppins-SemiBold',
                            fontSize: 32,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                ),
                Container(
                  color: Colors.black,
                  margin: EdgeInsets.only(
                    right: 20,
                    left: 20,
                    top: 10,
                    bottom: 20,
                  ),
                  height: MediaQuery.of(context).size.height - 150,
                  width: double.infinity,
                  child: ListView.builder(
                      itemCount: newDataList.length,
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemBuilder: (_, index) {
                        return NewCardUI(
                          author: newDataList[index].author,
                          date: newDataList[index].date,
                          imgUrl1: newDataList[index].imgUrl1,
                          imgUrl2: newDataList[index].imgUrl2,
                          newsDetail1: newDataList[index].newsDetail1,
                          newsDetail2: newDataList[index].newsDetail2,
                          title: newDataList[index].title,
                        );
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
      SingleChildScrollView(
        child: SafeArea(
          child: Container(
            //decoration: BoxDecoration(color: Colors.black),
            width: double.infinity,
            color: Colors.black,
            //height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Container(
                    height: 160,
                    width: 160,
                    child: CachedNetworkImage(
                      imageUrl: FilmInn.sharedPreferences
                                  .getString(FilmInn.userAvatarUrl) !=
                              null
                          ? FilmInn.sharedPreferences
                              .getString(FilmInn.userAvatarUrl)
                          : "https://www.pembepanjur.com/blog/wp-content/uploads/2018/08/profilfotografi-800x655.jpg",
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            style: BorderStyle.solid,
                            width: 5,
                            color: Colors.blue,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(80.0)),
                          image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                              colorFilter: ColorFilter.mode(
                                  Colors.blue[50], BlendMode.colorBurn)),
                        ),
                      ),
                      placeholder: (context, url) =>
                          CircularProgressIndicator(),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    )),
                SizedBox(
                  height: 20,
                ),
                Text(
                  FilmInn.sharedPreferences.getString("uid") != null
                      ? FilmInn.sharedPreferences.getString(FilmInn.userName) ==
                              null
                          ? ""
                          : FilmInn.sharedPreferences
                              .getString(FilmInn.userName)
                      : "Login for User Profile",
                  style: TextStyle(
                    fontFamily: 'Gotham',
                    fontSize: 27,
                    color: const Color(0xffffffff),
                    fontWeight: FontWeight.w500,
                    height: 1.3703703703703705,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 30,
                ),
                InkWell(
                  onTap: () {
                    if (FilmInn.sharedPreferences.getString("uid") == null) {
                      Route route = MaterialPageRoute(builder: (c) => Login());
                      Navigator.pushReplacement(context, route);
                    } else {
                      print("settings tıklandı.");
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return SettingsPage();
                          },
                        ),
                      );
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 50.0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.settings,
                          color: Colors.white,
                          size: 24,
                        ),
                        SizedBox(
                          width: 40,
                        ),
                        Text(
                          'Settings',
                          style: TextStyle(
                            fontFamily: 'Gotham',
                            fontSize: 15,
                            color: const Color(0xffffffff),
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 40),
                  child: Divider(
                    color: Colors.white.withOpacity(0.4),
                  ),
                ),
                InkWell(
                  onTap: () {
                    if (FilmInn.sharedPreferences.getString("uid") == null) {
                      Route route = MaterialPageRoute(builder: (c) => Login());
                      Navigator.pushReplacement(context, route);
                    } else {
                      print("favorite tıklandı.");
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return FavoirtesPage();
                          },
                        ),
                      );
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 50.0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.favorite_border,
                          color: Colors.white,
                          size: 24,
                        ),
                        SizedBox(
                          width: 40,
                        ),
                        Text(
                          'Favorite Movies',
                          style: TextStyle(
                            fontFamily: 'Gotham',
                            fontSize: 15,
                            color: const Color(0xffffffff),
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 40),
                  child: Divider(
                    color: Colors.white.withOpacity(0.4),
                  ),
                ),
                InkWell(
                  onTap: () {
                    print("contact us tıklandı.");
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return ContactUs();
                        },
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 50.0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.contacts,
                          color: Colors.white,
                          size: 24,
                        ),
                        SizedBox(
                          width: 40,
                        ),
                        Text(
                          'Contact Us',
                          style: TextStyle(
                            fontFamily: 'Gotham',
                            fontSize: 15,
                            color: const Color(0xffffffff),
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 40),
                  child: Divider(
                    color: Colors.white.withOpacity(0.4),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    if (FilmInn.sharedPreferences.getString("uid") == null) {
                      Route route = MaterialPageRoute(builder: (c) => Login());
                      Navigator.pushReplacement(context, route);
                    } else {
                      //signOutGoogle();
                      await FilmInn.sharedPreferences.setString("uid", null);
                      await FilmInn.sharedPreferences
                          .setString(FilmInn.userEmail, null);
                      await FilmInn.sharedPreferences
                          .setString(FilmInn.userName, null);
                      await FilmInn.sharedPreferences
                          .setString(FilmInn.userAvatarUrl, null);
                      FilmInn.auth.signOut().then((c) {
                        Route route =
                            MaterialPageRoute(builder: (c) => Login());
                        Navigator.pushReplacement(context, route);
                      });
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 50.0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.logout,
                          color: Colors.white,
                          size: 24,
                        ),
                        SizedBox(
                          width: 40,
                        ),
                        Text(
                          FilmInn.sharedPreferences.getString("uid") == null
                              ? 'Register or Login'
                              : 'Logout',
                          style: TextStyle(
                            fontFamily: 'Gotham',
                            fontSize: 15,
                            color: const Color(0xffffffff),
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 40),
                  child: Divider(
                    color: Colors.white.withOpacity(0.4),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 40),
                  child: Text(
                    "You can send any questions and comments to filminnapp@gmail.com.",
                    style: TextStyle(
                      fontFamily: 'Gotham',
                      fontSize: 15,
                      color: const Color(0xffffffff),
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ),
      ),
    ];
    return Scaffold(
      bottomNavigationBar: Container(
        //padding: EdgeInsets.symmetric(horizontal: 5.0),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 7,
              blurRadius: 10,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
          color: Colors.black,
          border: Border(
            top: BorderSide(
              style: BorderStyle.solid,
              color: Colors.grey,
              width: 1.5,
            ),
          ),
        ),
        child: new BottomNavigationBar(
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white.withOpacity(0.5),
          unselectedLabelStyle: TextStyle(
            fontFamily: 'Poppins-Medium',
            fontSize: 14,
            color: Colors.black,
          ),
          selectedLabelStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: 'Poppins-SemiBold',
            fontSize: 14,
            color: Colors.black,
          ),
          selectedIconTheme: IconThemeData(opacity: 1, size: 25),
          unselectedIconTheme: IconThemeData(opacity: 0.5),
          currentIndex: _selectedItemIndex,
          onTap: (int i) {
            setState(() {
              _selectedItemIndex = i;
            });
          },
          backgroundColor: Colors.black,
          items: [
            new BottomNavigationBarItem(
              icon: Icon(Icons.home, color: Colors.white),
              label: "Home",
            ),
            new BottomNavigationBarItem(
              icon: Icon(Icons.business, color: Colors.white),
              label: "News",
            ),
            new BottomNavigationBarItem(
              icon: Icon(Icons.person_outline, color: Colors.white),
              label: "Profile",
            ),
          ],
        ),
      ),
      body: RefreshIndicator(
          onRefresh: () async {
            filmData();
          },
          child: tabs[_selectedItemIndex]),
    );
  }

  Widget bottomNavItem(IconData icon, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedItemIndex = index;
        });
      },
      child: Container(
        height: 60,
        width: MediaQuery.of(context).size.width / 3,
        decoration: index == _selectedItemIndex
            ? BoxDecoration(
                border:
                    Border(bottom: BorderSide(width: 4, color: Colors.white)))
            : BoxDecoration(),
        child: Icon(icon,
            color: index == _selectedItemIndex ? Colors.black : Colors.black45),
      ),
    );
  }

  void SearchMethod(String text) {
    DatabaseReference searchRef =
        FirebaseDatabase.instance.reference().child("Data").child("films");
    searchRef.once().then((DataSnapshot snapShot) {
      filmdataList.clear();
      var keys = snapShot.value.keys;
      var values = snapShot.value;
      for (var key in keys) {
        FilmData filmsearchData = new FilmData(
          values[key]['filmName'],
          values[key]['imgUrl'],
          values[key]['subTitle'],
          values[key]['date'],
          values[key]['imdb'],
          values[key]['category'],
          key,
          values[key]['year'],
        );
        if (filmsearchData.filmName.toLowerCase().contains(text)) {
          filmdataList.add(filmsearchData);
        }
      }
      Timer(Duration(milliseconds: 100), () {
        setState(() {});
      });
    });
  }
}

class FilmDetailCardUI extends StatefulWidget {
  String filmName;
  String imgUrl;
  String subTitle;
  String date;
  String imdb;
  String category;
  String uploadid;
  int index;
  List<bool> favList;
  String year;
  FilmDetailCardUI({
    @required this.filmName,
    @required this.imgUrl,
    @required this.subTitle,
    @required this.date,
    @required this.imdb,
    @required this.category,
    @required this.uploadid,
    @required this.index,
    @required this.favList,
    @required this.year,
  });

  @override
  _FilmDetailCardUIState createState() => _FilmDetailCardUIState();
}

class _FilmDetailCardUIState extends State<FilmDetailCardUI> {
  final LikeRef = FirebaseDatabase.instance.reference();
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.black,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      child: InkWell(
        highlightColor: Colors.blue[400],
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => FilmCritDetail(
                        filmName: widget.filmName,
                        imgUrl: widget.imgUrl,
                        subTitle: widget.subTitle,
                        date: widget.date,
                        imdb: widget.imdb,
                        category: widget.category,
                        year: widget.year,
                      )));
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                CachedNetworkImage(
                  width: 140,
                  height: 191,
                  imageUrl: widget.imgUrl,
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(2.0)),
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.fill,
                        colorFilter: ColorFilter.mode(
                            Colors.blue[150], BlendMode.colorBurn),
                      ),
                    ),
                  ),
                  placeholder: (context, url) => Center(
                      child: CircularProgressIndicator(
                    backgroundColor: Colors.white,
                  )),
                  errorWidget: (context, url, error) => Container(
                    decoration: BoxDecoration(
                      color: Colors.black,
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          colorFilter: new ColorFilter.mode(
                              Colors.black.withOpacity(0.5), BlendMode.dstATop),
                          alignment: FractionalOffset.topCenter,
                          image:
                              AssetImage("lib/assets/images/background.png")),
                    ),
                  ),
                ),
                widget.favList.length != 0
                    ? widget.favList[widget.index]
                        ? IconButton(
                            icon: Icon(
                              Icons.favorite,
                              color: Colors.red,
                            ),
                            onPressed: () {
                              DatabaseReference favRef = FirebaseDatabase
                                  .instance
                                  .reference()
                                  .child("Data")
                                  .child("films")
                                  .child(widget.uploadid)
                                  .child("Favorite")
                                  .child(FilmInn.sharedPreferences
                                      .getString("uid"))
                                  .child("state");
                              favRef.set("false");
                              setState(() {
                                FavoriteFunc();
                              });
                            })
                        : IconButton(
                            icon: Icon(
                              Icons.favorite,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              DatabaseReference favRef = FirebaseDatabase
                                  .instance
                                  .reference()
                                  .child("Data")
                                  .child("films")
                                  .child(widget.uploadid)
                                  .child("Favorite")
                                  .child(FilmInn.sharedPreferences
                                      .getString("uid"))
                                  .child("state");

                              favRef.set("true");
                              setState(() {
                                FavoriteFunc();
                              });
                              //likePlus();
                            })
                    : Container()
              ],
            ),
            SizedBox(
              height: 3,
            ),
            SizedBox(
              width: 140,
              child: Text(
                widget.filmName,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins-Bold',
                  fontSize: 14,
                  color: const Color(0xffffffff),
                ),
                textAlign: TextAlign.left,
              ),
            ),
            Text(
              widget.imdb,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins-Bold',
                fontSize: 14,
                color: Colors.blue,
              ),
              textAlign: TextAlign.right,
            )
          ],
        ),
      ),
    );
  }

  void FavoriteFunc() {
    DatabaseReference referenceData =
        FirebaseDatabase.instance.reference().child("Data").child("films");
    referenceData.once().then((DataSnapshot dataSnapshot) {
      widget.favList.clear();
      var keys = dataSnapshot.value.keys;
      for (var key in keys) {
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
              widget.favList.add(true);
            } else {
              widget.favList.add(false);
            }
          } else {
            widget.favList.add(false);
          }
        });
      }
      Timer(Duration(milliseconds: 100), () {
        setState(() {});
      });
    });
  }
}

class FilmListCardUI extends StatelessWidget {
  String date;
  String imgUrl1;
  String imgUrl2;
  String imgUrl3;
  String subTitle1;
  String subTitle2;
  String subTitle3;
  String title;
  FilmListCardUI({
    @required this.date,
    @required this.imgUrl1,
    @required this.imgUrl2,
    @required this.imgUrl3,
    @required this.subTitle1,
    @required this.subTitle2,
    @required this.subTitle3,
    @required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.black,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      child: InkWell(
        highlightColor: Colors.blue[400],
        onDoubleTap: () {},
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => FilmListDetail(
                        date: date,
                        imgUrl1: imgUrl1,
                        imgUrl2: imgUrl2,
                        imgUrl3: imgUrl3,
                        subTitle1: subTitle1,
                        subTitle2: subTitle2,
                        subTitle3: subTitle3,
                        title: title,
                      )));
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                CachedNetworkImage(
                  width: 240,
                  height: 150,
                  imageUrl: imgUrl1,
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(2.0)),
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.fitWidth,
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
              ],
            ),
            SizedBox(
              width: 240,
              child: Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins-Bold',
                  fontSize: 14,
                  color: const Color(0xffffffff),
                ),
                textAlign: TextAlign.left,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NewCardUI extends StatelessWidget {
  String author;
  String date;
  String imgUrl1;
  String imgUrl2;
  String newsDetail1;
  String newsDetail2;
  String title;

  NewCardUI({
    @required this.author,
    @required this.date,
    @required this.imgUrl1,
    @required this.imgUrl2,
    @required this.newsDetail1,
    @required this.newsDetail2,
    @required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.black,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      child: InkWell(
        highlightColor: Colors.blue[400],
        onDoubleTap: () {},
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => NewDetail(
                        author: author,
                        date: date,
                        imgUrl1: imgUrl1,
                        imgUrl2: imgUrl2,
                        newsDetail1: newsDetail1,
                        newsDetail2: newsDetail2,
                        title: title,
                      )));
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CachedNetworkImage(
              width: MediaQuery.of(context).size.width * 1.4 / 3,
              height: 110,
              imageUrl: imgUrl1,
              imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(2.0)),
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                    colorFilter:
                        ColorFilter.mode(Colors.blue[150], BlendMode.colorBurn),
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  SizedBox(
                    width: 128,
                    child: Text(
                      title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins-Bold',
                        fontSize: 14,
                        color: const Color(0xffffffff),
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  SizedBox(height: 5),
                  SizedBox(
                    width: 128,
                    child: Text(
                      date,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins-Bold',
                        fontSize: 14,
                        color: Colors.blue,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

final GoogleSignIn googleSignIn = GoogleSignIn();
void signOutGoogle() async {
  await googleSignIn.signOut();
  print("User Signed Out");
}

class UpcomingCardUI extends StatelessWidget {
  String imgUrl;
  String name;

  UpcomingCardUI({
    @required this.imgUrl,
    @required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.black,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      child: InkWell(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                CachedNetworkImage(
                  width: 140,
                  height: 200,
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
                )
              ],
            ),
            SizedBox(
              height: 3,
            ),
            SizedBox(
              width: 140,
              child: Text(
                name,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins-Bold',
                  fontSize: 14,
                  color: const Color(0xffffffff),
                ),
                textAlign: TextAlign.left,
              ),
            )
          ],
        ),
      ),
    );
  }
}
