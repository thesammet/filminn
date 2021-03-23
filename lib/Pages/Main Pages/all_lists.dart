import 'dart:async';
import 'package:admob_flutter/admob_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import '../../Data.dart';
import 'film_crit_detail.dart';
import 'film_list_detail.dart';

class AllLists extends StatefulWidget {
  List<ListData> filmGroupList2 = [];

  AllLists({Key key, this.filmGroupList2}) : super(key: key);

  @override
  _AllListsState createState() => _AllListsState();
}

class _AllListsState extends State<AllLists> {
  bool searchState = false;
  FocusNode inputNode3 = FocusNode();

  TextEditingController searchTextControllerList = new TextEditingController();
  @override
  void initState() {
    super.initState();
    Admob.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: !searchState
            ? Text("All Lists")
            : TextField(
                focusNode: inputNode3,
                autofocus: true,
                controller: searchTextControllerList,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(10.0),
                  hintText: "Search movie lists...",
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
                    searchTextControllerList.text = "";
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
              searchTextControllerList.text = "";
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: MediaQuery.of(context).size.height - 130,
            width: MediaQuery.of(context).size.width,
            child: GridView.builder(
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  childAspectRatio: 1.6,
                ),
                itemCount: widget.filmGroupList2.length,
                itemBuilder: (_, index) {
                  return FilmListCardUI(
                    date: widget.filmGroupList2[index].date,
                    imgUrl1: widget.filmGroupList2[index].imgUrl1,
                    imgUrl2: widget.filmGroupList2[index].imgUrl2,
                    imgUrl3: widget.filmGroupList2[index].imgUrl3,
                    subTitle1: widget.filmGroupList2[index].subTitle1,
                    subTitle2: widget.filmGroupList2[index].subTitle2,
                    subTitle3: widget.filmGroupList2[index].subTitle3,
                    title: widget.filmGroupList2[index].title,
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
        FirebaseDatabase.instance.reference().child("Data").child("lists");
    searchRef.once().then((DataSnapshot snapShot) {
      widget.filmGroupList2.clear();
      var keys = snapShot.value.keys;
      var values = snapShot.value;
      for (var key in keys) {
        ListData listsearchData2 = new ListData(
          values[key]['date'],
          values[key]['imgUrl1'],
          values[key]['imgUrl2'],
          values[key]['imgUrl3'],
          values[key]['subTitle1'],
          values[key]['subTitle2'],
          values[key]['subTitle3'],
          values[key]['title'],
        );
        if (listsearchData2.title.toLowerCase().contains(text)) {
          widget.filmGroupList2.add(listsearchData2);
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
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: InkWell(
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
                  height: 100,
                  imageUrl: imgUrl1,
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
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
          ],
        ),
      ),
    );
  }
}
