import 'dart:async';
import 'package:admob_flutter/admob_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import '../../Data.dart';
import 'film_crit_detail.dart';

class AllFilms extends StatefulWidget {
  List<FilmData> filmdataList = [];

  AllFilms({Key key, this.filmdataList}) : super(key: key);

  @override
  _AllFilmsState createState() => _AllFilmsState();
}

class _AllFilmsState extends State<AllFilms> {
  @override
  void initState() {
    super.initState();
    Admob.initialize();
  }

  bool searchState = false;
  FocusNode inputNode = FocusNode();

  TextEditingController searchTextController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: !searchState
            ? Text("All Movies")
            : TextField(
                focusNode: inputNode,
                autofocus: true,
                controller: searchTextController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(10.0),
                  hintText: "Search movie...",
                  hintStyle: TextStyle(
                    fontFamily: 'Nunito Sans',
                    fontSize: 17,
                    color: Colors.black26,
                  ),
                ),
                onChanged: (text) {
                  SearchMethod(text.toLowerCase());
                },
              ),
        actions: [
          !searchState
              ? IconButton(
                  icon: Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    setState(() {
                      searchState = !searchState;
                    });
                  })
              : IconButton(
                  icon: Icon(
                    Icons.cancel,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    searchTextController.text = "";
                    SearchMethod("");
                    setState(() {
                      searchState = !searchState;
                    });
                  })
        ],
        leading: IconButton(
          onPressed: () {
            setState(() {
              SearchMethod("");
              searchTextController.text = "";
            });

            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            size: 32,
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height-130,
            width: MediaQuery.of(context).size.width,
            child: GridView.builder(
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 100,
                  childAspectRatio: 1 / 1.5,
                ),
                itemCount: widget.filmdataList.length,
                itemBuilder: (_, index) {
                  return FilmDetailCardUI(
                    filmName: widget.filmdataList[index].filmName,
                    imgUrl: widget.filmdataList[index].imgUrl,
                    subTitle: widget.filmdataList[index].subTitle,
                    date: widget.filmdataList[index].date,
                    imdb: widget.filmdataList[index].imdb,
                    category: widget.filmdataList[index].category,
                    year: widget.filmdataList[index].year,
                  );
                }),
          ),
          AdmobBanner(
              adUnitId: "ca-app-pub-3940256099942544/6300978111",
              adSize: AdmobBannerSize.SMART_BANNER(context)),
        ],
      ),
      /*child: ListView.builder(
                                      itemCount: filmdataList.length,
                                      scrollDirection: Axis.vertical,
                                      shrinkWrap: true,
                                      itemBuilder: (_, index) {
                                        return FilmDetailCardUI(
                                          filmName: filmdataList[index].filmName,
                                          imgUrl: filmdataList[index].imgUrl,
                                          title: filmdataList[index].title,
                                          subTitle: filmdataList[index].subTitle,
                                          date: filmdataList[index].date,
                                          like: filmdataList[index].like,
                                          comments: filmdataList[index].comments,
                                          imdb: filmdataList[index].imdb,
                                          category: filmdataList[index].category,
                                        );
                                      }),*/
    );
  }

  void SearchMethod(String text) {
    DatabaseReference searchRef =
        FirebaseDatabase.instance.reference().child("Data").child("films");
    searchRef.once().then((DataSnapshot snapShot) {
      widget.filmdataList.clear();
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
            values[key]['year'],);
        if (filmsearchData.filmName.toLowerCase().contains(text)) {
          widget.filmdataList.add(filmsearchData);
        }
      }
      Timer(Duration(milliseconds: 100), () {
        if (mounted) {
          setState(() {});
        }
      });
    });
  }
}

class FilmDetailCardUI extends StatelessWidget {
  String filmName;
  String imgUrl;
  String subTitle;
  String date;
  String imdb;
  String category;
   String year;
  FilmDetailCardUI({
    @required this.filmName,
    @required this.imgUrl,
    @required this.subTitle,
    @required this.date,
    @required this.imdb,
    @required this.category,
    @required this.year,
  });

  @override
  Widget build(BuildContext context) {
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
                        year:year,
                      )));
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                CachedNetworkImage(
                  width: 120,
                  height: 123.2,
                  imageUrl: imgUrl,
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
                  errorWidget: (context, url, error) => Icon(
                    Icons.error,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
