class FilmData {
  String filmName, imgUrl, subTitle, date, imdb, category, uploadid,year;
  FilmData(this.filmName, this.imgUrl, this.subTitle, this.date, this.imdb,
      this.category, this.uploadid, this.year);
}

class ListData {
  String date,
      imgUrl1,
      imgUrl2,
      imgUrl3,
      subTitle1,
      subTitle2,
      subTitle3,
      title;
  ListData(this.date, this.imgUrl1, this.imgUrl2, this.imgUrl3, this.subTitle1,
      this.subTitle2, this.subTitle3, this.title);
}

class UpcomingData {
  String imgUrl, name;
  UpcomingData(this.imgUrl, this.name);
}

class NewData {
  String author, date, imgUrl1, imgUrl2, newsDetail1, newsDetail2, title;
  NewData(this.author, this.date, this.imgUrl1, this.imgUrl2, this.newsDetail1,
      this.newsDetail2, this.title);
}
