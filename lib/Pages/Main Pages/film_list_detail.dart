import 'package:FilmInn/services/advert_service.dart';
import 'package:admob_flutter/admob_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class FilmListDetail extends StatefulWidget {
  final String date;
  final String imgUrl1;
  final String imgUrl2;
  final String imgUrl3;
  final String subTitle1;
  final String subTitle2;
  final String subTitle3;
  final String title;

  const FilmListDetail({
    Key key,
    this.date,
    this.imgUrl1,
    this.imgUrl2,
    this.imgUrl3,
    this.subTitle1,
    this.subTitle2,
    this.subTitle3,
    this.title,
  }) : super(key: key);

  @override
  _FilmListDetailState createState() => _FilmListDetailState();
}

class _FilmListDetailState extends State<FilmListDetail> {
  //ADMOB
  final _advertService = AdvertService();

  @override
  void initState() {
    super.initState();

    Admob.initialize();
  }

//sadffsaasd
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
                    width: MediaQuery.of(context).size.width - 40,
                    child: Text(
                      widget.title,
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
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 5, bottom: 20, right: 20, left: 20),
              child: Text(
                widget.subTitle1,
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
              padding: const EdgeInsets.only(
                right: 20.0,
                left: 20.0,
                bottom: 10,
              ),
              child: CachedNetworkImage(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width / 1.5,
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
                  const EdgeInsets.only(top: 5, bottom: 5, right: 20, left: 20),
              child: Text(
                widget.subTitle2,
                style: TextStyle(
                  fontFamily: 'Gotham',
                  fontSize: 15,
                  color: const Color(0xffcbcbcb),
                  fontWeight: FontWeight.w300,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            AdmobBanner(
                adUnitId: "ca-app-pub-6305131424598853/4846877623",
                adSize: AdmobBannerSize.BANNER),
            Padding(
              padding: const EdgeInsets.only(
                  top: 5, bottom: 20, right: 20, left: 20),
              child: Text(
                widget.subTitle3,
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
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 5,
              ),
              child: CachedNetworkImage(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width / 2,
                imageUrl: widget.imgUrl3,
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
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  "Date: " + widget.date,
                  style: TextStyle(
                    fontFamily: 'Gotham',
                    fontSize: 15,
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.right,
                ),
              ),
            ),
          ],
        ),
      ));
}
