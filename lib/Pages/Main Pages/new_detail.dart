import 'package:admob_flutter/admob_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class NewDetail extends StatefulWidget {
  final String author;
  final String date;
  final String imgUrl1;
  final String imgUrl2;
  final String newsDetail1;
  final String newsDetail2;
  final String title;

  const NewDetail({
    Key key,
    this.author,
    this.date,
    this.imgUrl1,
    this.imgUrl2,
    this.newsDetail1,
    this.newsDetail2,
    this.title,
  }) : super(key: key);

  @override
  _NewDetailState createState() => _NewDetailState();
}

class _NewDetailState extends State<NewDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        SliverAppBar(
          backgroundColor: Colors.black,
          floating: false,
          expandedHeight: 200,
          pinned: false,
          flexibleSpace: FlexibleSpaceBar(
            background: CachedNetworkImage(
              imageUrl: widget.imgUrl1,
              imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(2.0)),
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.fitWidth,
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
            collapseMode: CollapseMode.pin,
            centerTitle: true,
          ),
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
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
            SizedBox(
              height: 4,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 40,
                    child: Text(
                      widget.title,
                      style: TextStyle(
                        fontFamily: 'Gotham',
                        fontSize: 20,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        height: 1.368421052631579,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 5, bottom: 20, right: 20, left: 20),
              child: Text(
                widget.newsDetail1,
                style: TextStyle(
                  fontFamily: 'Gotham',
                  fontSize: 15,
                  color: const Color(0xffcbcbcb),
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: AdmobBanner(
                  adUnitId: "ca-app-pub-6305131424598853/6447733904",
                  adSize: AdmobBannerSize.MEDIUM_RECTANGLE),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
              child: Text(
                widget.newsDetail2,
                style: TextStyle(
                  fontFamily: 'Gotham',
                  fontSize: 15,
                  color: const Color(0xffcbcbcb),
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 10,
              ),
              child: CachedNetworkImage(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width / 2,
                imageUrl: widget.imgUrl2,
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
            ),
            Padding(
              padding:
                  const EdgeInsets.only(bottom: 20.0, left: 20.0, right: 20.0),
              child: Divider(
                color: Colors.blue,
                thickness: 3.5,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20, right: 20, left: 20),
              child: Row(
                children: [
                  Text(
                    widget.author,
                    style: TextStyle(
                      fontFamily: 'Gotham',
                      fontSize: 15,
                      color: const Color(0xffcbcbcb),
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  Text(
                    widget.date,
                    style: TextStyle(
                      fontFamily: 'Gotham',
                      fontSize: 15,
                      color: const Color(0xffcbcbcb),
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ],
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
              ),
            )
          ],
        ),
      ));
}
