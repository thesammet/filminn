import 'package:FilmInn/services/advert_service.dart';
import 'package:admob_flutter/admob_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class FilmCritDetail extends StatefulWidget {
  final String filmName;
  final String imgUrl;
  final String title;
  final String subTitle;
  final String date;
  final String imdb;
  final String category;
  final String year;
  const FilmCritDetail(
      {Key key,
      this.filmName,
      this.imgUrl,
      this.title,
      this.subTitle,
      this.date,
      this.imdb,
      this.category,
      this.year})
      : super(key: key);

  @override
  _FilmCritDetailState createState() => _FilmCritDetailState();
}

class _FilmCritDetailState extends State<FilmCritDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: Colors.black,
              floating: false,
              expandedHeight: 200,
              pinned: false,
              flexibleSpace: FlexibleSpaceBar(
                background: CachedNetworkImage(
                  imageUrl: widget.imgUrl,
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
                collapseMode: CollapseMode.pin,
                centerTitle: true,
              ),
              leading: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(
                  Icons.arrow_back,
                  size: 32,
                ),
              ),
            ),
            filmDetailContent(),
          ],
        ));
  }

  Widget filmDetailContent() => SliverToBoxAdapter(
          child: Container(
        decoration: BoxDecoration(color: Colors.black),
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 200,
                    child: Text(
                      widget.filmName + " (${widget.year})",
                      style: TextStyle(
                        fontFamily: 'Gotham',
                        fontSize: 20,
                        color: Colors.blue,
                        fontWeight: FontWeight.w500,
                        height: 1.368421052631579,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Text(
                    "IMDB: " + widget.imdb,
                    style: TextStyle(
                      fontFamily: 'Gotham',
                      fontSize: 15,
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(bottom: 10, right: 20, left: 20),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    widget.category,
                    style: TextStyle(
                      fontFamily: 'Gotham',
                      fontSize: 15,
                      color: const Color(0xffffffff),
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.left,
                  ),
                )),
            Padding(
              padding: const EdgeInsets.only(
                  top: 5, bottom: 20, right: 20, left: 20),
              child: Text(
                widget.subTitle,
                style: TextStyle(
                  fontFamily: 'Gotham',
                  fontSize: 15,
                  color: const Color(0xffcbcbcb),
                  fontWeight: FontWeight.w300,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10, right: 20, left: 20),
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  widget.date,
                  style: TextStyle(
                    fontFamily: 'Gotham',
                    fontSize: 15,
                    color: Colors.blue,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: AdmobBanner(
                  adUnitId: "ca-app-pub-6305131424598853/3848932242",
                  adSize: AdmobBannerSize.BANNER),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ));
}
