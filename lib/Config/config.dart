import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FilmInn {
  static SharedPreferences sharedPreferences;
  static User firebaseuser;
  static FirebaseAuth auth;
  static FirebaseFirestore firestore;

  static final String userName = "username";
  static final String userAvatarUrl = "url";
  static final String userEmail = "email";
  static final String userUID = "uid";
  //static final String userCartList = "userCart";
}
