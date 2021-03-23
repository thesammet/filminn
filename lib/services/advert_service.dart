import 'dart:io';

class AdvertService {
  String getAdmobAppId() {
    if (Platform.isIOS) {
      return "ca-app-pub-6305131424598853~5585326373";
    } else if (Platform.isAndroid) {
      return "ca-app-pub-6305131424598853~9101258927";
    }
    return null;
  }

  String getABannerAdId() {
    if (Platform.isIOS) {
      return "ca-app-pub-6305131424598853/8810804251";
    } else if (Platform.isAndroid) {
      return "ca-app-pub-6305131424598853/3848932242";
    }
    return null;
  }
}
