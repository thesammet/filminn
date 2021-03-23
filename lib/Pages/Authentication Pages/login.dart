import 'package:FilmInn/Config/config.dart';
import 'package:FilmInn/Pages/Authentication%20Pages/editor_login.dart';
import 'package:FilmInn/Pages/Authentication%20Pages/register.dart';
import 'package:FilmInn/Widgets/defaultButtons.dart';
import 'package:FilmInn/Widgets/defaultTextfield.dart';
import 'package:FilmInn/Widgets/dialogWidgets.dart';
import 'package:FilmInn/Widgets/logo.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../Main Pages/home.dart';
import 'package:adobe_xd/pinned.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Login extends StatefulWidget {
  Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  IconData passwordIconData = Icons.visibility;
  bool _obscureText = true;
  String _password;
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.black,
              image: DecorationImage(
                  fit: BoxFit.cover,
                  colorFilter: new ColorFilter.mode(
                      Colors.black.withOpacity(0.5), BlendMode.dstATop),
                  alignment: FractionalOffset.topCenter,
                  image: AssetImage("lib/assets/images/background.png")),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 50,
                ),
                Column(
                  children: [Logo()],
                ),
                SizedBox(
                  height: 50,
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40.0, vertical: 5),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'EMAIL',
                                  style: TextStyle(
                                    fontFamily: 'Gotham',
                                    fontSize: 15,
                                    color: const Color(0xffffffff),
                                    letterSpacing: 0.8400000000000001,
                                    fontWeight: FontWeight.w700,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                DefaultTextfield(
                                  controller: _emailController,
                                  hintText: "Ex. filminn@gmail.com",
                                  textInputType: TextInputType.emailAddress,
                                ),
                              ],
                            ),
                            SizedBox(height: 7),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'PASSWORD',
                                  style: TextStyle(
                                    fontFamily: 'Gotham',
                                    fontSize: 15,
                                    color: const Color(0xffffffff),
                                    letterSpacing: 0.8400000000000001,
                                    fontWeight: FontWeight.w700,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                                Container(
                                  width: 285.0,
                                  height: 50.0,
                                  decoration: BoxDecoration(
                                    color: const Color(0xff707070),
                                    borderRadius:
                                        new BorderRadius.circular(9.0),
                                  ),
                                  child: TextFormField(
                                    cursorColor: Colors.white,
                                    controller: _passwordController,
                                    decoration: new InputDecoration(
                                      suffixIcon: IconButton(
                                          color: Colors.white,
                                          onPressed: () {
                                            _toggle();
                                            _obscureText
                                                ? passwordIconData =
                                                    Icons.visibility
                                                : passwordIconData =
                                                    Icons.visibility_off;
                                          },
                                          icon: Icon(passwordIconData)),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(9.0),
                                        borderSide: BorderSide(
                                          color: Colors.black,
                                        ),
                                      ),
                                      hintText: "********",
                                      hintStyle: TextStyle(
                                        fontFamily: 'Gotham',
                                        fontSize: 17,
                                        color: const Color(0xffCBC9C9),
                                        fontWeight: FontWeight.w300,
                                      ),
                                      border: new OutlineInputBorder(
                                        borderRadius:
                                            new BorderRadius.circular(9.0),
                                      ),
                                    ),
                                    validator: (val) => val.length < 6
                                        ? 'Password too short.'
                                        : null,
                                    onSaved: (val) => _password = val,
                                    obscureText: _obscureText,
                                    style: TextStyle(
                                      fontFamily: 'Gotham',
                                      fontSize: 17,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        print("login tıklandı.");
                        _emailController.text.isNotEmpty &&
                                _passwordController.text.isNotEmpty
                            ? loginUser()
                            : showDialog(
                                context: context,
                                builder: (c) {
                                  return ErrorAlertDialog(
                                    errorMessage:
                                        "Please write email and password",
                                  );
                                });
                      },
                      child: DefaultButton(
                        text: "Login",
                      ),
                    ),

                    /*SizedBox(height: 30),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.string(
                              _svg_mlizdn,
                              allowDrawingOutsideViewBox: true,
                              fit: BoxFit.fill,
                            ),
                            SizedBox(width: 20),
                            Text(
                              'Google Login',
                              style: TextStyle(
                                fontFamily: 'Gotham',
                                fontSize: 15,
                                color: const Color(0xffffffff),
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(width: 20),
                            SvgPicture.string(
                              _svg_tvx9uj,
                              allowDrawingOutsideViewBox: true,
                              fit: BoxFit.fill,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                signInWithGoogle().then((result) {
                                  if (result != null) {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return Home();
                                        },
                                      ),
                                    );
                                  }
                                });
                                print("google sign in");
                              },
                              child: SvgPicture.string(
                                _svg_aabzhs,
                                allowDrawingOutsideViewBox: true,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 25,
                    ),*/
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      'Don’t have an account?',
                      style: TextStyle(
                        fontFamily: 'Gotham',
                        fontSize: 14,
                        color: const Color(0xa3ffffff),
                        fontWeight: FontWeight.w300,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    GestureDetector(
                      child: Text(
                        'REGISTER',
                        style: TextStyle(
                          fontFamily: 'Gotham',
                          fontSize: 14,
                          color: const Color(0xffffffff),
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Register()));
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: () async{
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => Home()));
                        await FilmInn.sharedPreferences.setString(
                            "uid", null);
                        await FilmInn.sharedPreferences.setString(
                            FilmInn.userEmail,
                           null);
                        await FilmInn.sharedPreferences.setString(
                            FilmInn.userName,
                            null);
                        await FilmInn.sharedPreferences.setString(
                            FilmInn.userAvatarUrl,
                            null);
                      },
                      child: Text(
                        'Continue without login ->',
                        style: TextStyle(
                          fontFamily: 'Gotham',
                          fontSize: 14,
                          color: Colors.blue[900],
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    SizedBox(
                      width: 150,
                      child: Divider(
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => EditorLogin()));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment(0.0, -1.0),
                            end: Alignment(0.0, 1.0),
                            colors: [
                              const Color(0xff484dff),
                              const Color(0xff242780)
                            ],
                            stops: [0.0, 1.0],
                          ),
                        ),
                        child: SizedBox(
                          height: 20,
                          width: 150,
                          child: Center(
                            child: Text(
                              'I\'m a Film Inn Editor',
                              style: TextStyle(
                                fontFamily: 'Gotham',
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        )
        /*SafeArea(
        child: Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 9,
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("Let's go to Film Inn !"),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40.0, vertical: 5),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      DefaultTextfield(
                        controller: _emailController,
                        data: Icons.email,
                        hintText: "Email",
                        textInputType: TextInputType.emailAddress,
                      ),
                      SizedBox(height: 7),
                      new TextFormField(
                        controller: _passwordController,
                        decoration: new InputDecoration(
                          suffixIcon: IconButton(
                              onPressed: () {
                                _toggle();
                                _obscureText
                                    ? passwordIconData = Icons.visibility
                                    : passwordIconData = Icons.visibility_off;
                              },
                              icon: Icon(passwordIconData)),
                          prefixIcon: Icon(
                            Icons.lock,
                            color: Theme.of(context).primaryColor,
                          ),
                          hintText: 'Password',
                          fillColor: Colors.white,
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(25.0),
                            borderSide: new BorderSide(),
                          ),
                          //fillColor: Colors.green
                        ),
                        validator: (val) =>
                            val.length < 6 ? 'Password too short.' : null,
                        onSaved: (val) => _password = val,
                        obscureText: _obscureText,
                      ),
                    ],
                  ),
                ),
              ),
              RaisedButton(
                onPressed: () {
                  _emailController.text.isNotEmpty &&
                          _passwordController.text.isNotEmpty
                      ? loginUser()
                      : showDialog(
                          context: context,
                          builder: (c) {
                            return ErrorAlertDialog(
                              errorMessage: "Please write email and password",
                            );
                          });
                },
                child: Text("Login"),
              ),
              GestureDetector(
                child: Text("Register Account"),
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => Register()));
                },
              )
            ],
          ),
        ),
      ),*/
        );
  }

  FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  Future<String> signInWithGoogle() async {
    await Firebase.initializeApp();
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final UserCredential authResult =
        await _auth.signInWithCredential(credential);
    final User user = authResult.user;

    if (user != null) {
      assert(!user.isAnonymous);
      assert(await user.getIdToken() != null);

      final User currentUser = _auth.currentUser;
      assert(user.uid == currentUser.uid);

      print('signInWithGoogle succeeded: $user');

      return '$user';
    }

    return null;
  }

  loginUser() async {
    showDialog(
        context: context,
        builder: (c) {
          return LoadingAlertDialog(
            loadingMessage: "Logging into your account...",
          );
        });

    User firebaseUser;

    await _auth
        .signInWithEmailAndPassword(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim())
        .then((authUser) {
      firebaseUser = authUser.user;
    }).catchError((onError) {
      Navigator.pop(context);
      showDialog(
          context: context,
          builder: (c) {
            return ErrorAlertDialog(
              errorMessage: onError.message.toString(),
            );
          });
    });
    if (firebaseUser != null) {
      readData(firebaseUser).then((s) {
        Navigator.pop(context);
        Route route = MaterialPageRoute(builder: (c) => Home());
        Navigator.pushReplacement(context, route);
      });
    }
  }

  Future readData(User fUser) async {
    FirebaseFirestore.instance
        .collection('users')
        .doc(fUser.uid)
        .get()
        .then((dataSnapshot) async {
      await FilmInn.sharedPreferences
          .setString("uid", dataSnapshot.data()[FilmInn.userUID]);
      await FilmInn.sharedPreferences
          .setString(FilmInn.userEmail, dataSnapshot.data()[FilmInn.userEmail]);
      await FilmInn.sharedPreferences
          .setString(FilmInn.userName, dataSnapshot.data()[FilmInn.userName]);
      await FilmInn.sharedPreferences.setString(
          FilmInn.userAvatarUrl, dataSnapshot.data()[FilmInn.userAvatarUrl]);
    });
  }
}

const String _svg_5dtx82 =
    '<svg viewBox="-223.5 -145.5 870.0 580.0" ><defs><pattern id="image" patternUnits="userSpaceOnUse" width="2592.0" height="1728.0"><image xlink:href="null" x="0" y="0" width="2592.0" height="1728.0" /></pattern></defs><path transform="translate(-223.5, -145.5)" d="M 0 0 L 870 0 L 870 580 L 0 580 L 0 0 Z" fill="url(#image)" fill-opacity="0.23" stroke="none" stroke-width="1" stroke-opacity="0.23" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_mlizdn =
    '<svg viewBox="44.6 589.0 80.4 1.0" ><path transform="translate(5061.0, 163.0)" d="M -4936 426 L -5016.4072265625 426" fill="none" fill-opacity="0.36" stroke="#ffffff" stroke-width="1" stroke-opacity="0.36" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_hytba7 =
    '<svg viewBox="0.0 0.0 43.8 43.8" ><defs><linearGradient id="gradient" x1="0.5" y1="0.0" x2="0.5" y2="1.0"><stop offset="0.0" stop-color="#ff252883"  /><stop offset="1.0" stop-color="#ff464bf9"  /></linearGradient></defs><path  d="M 21.90582084655762 0 C 9.827001571655273 0 0 9.826984405517578 0 21.90578269958496 C 0 33.98369979858398 9.827001571655273 43.81156539916992 21.90582084655762 43.81156539916992 C 33.98375701904297 43.81156539916992 43.81164169311523 33.98369979858398 43.81164169311523 21.90578269958496 C 43.81164169311523 9.826984405517578 33.98552322387695 0 21.90582084655762 0 Z M 27.35359764099121 22.67697715759277 L 23.7896900177002 22.67697715759277 C 23.7896900177002 28.37092781066895 23.7896900177002 35.37961578369141 23.7896900177002 35.37961578369141 L 18.50868034362793 35.37961578369141 C 18.50868034362793 35.37961578369141 18.50868034362793 28.43886947631836 18.50868034362793 22.67697715759277 L 15.99832725524902 22.67697715759277 L 15.99832725524902 18.18746566772461 L 18.50868034362793 18.18746566772461 L 18.50868034362793 15.28357791900635 C 18.50868034362793 13.20382499694824 19.49693870544434 9.954047203063965 23.83821868896484 9.954047203063965 L 27.75154876708984 9.969047546386719 L 27.75154876708984 14.32708644866943 C 27.75154876708984 14.32708644866943 25.37355041503906 14.32708644866943 24.91118621826172 14.32708644866943 C 24.44882202148438 14.32708644866943 23.79145240783691 14.55826663970947 23.79145240783691 15.55005359649658 L 23.79145240783691 18.1883487701416 L 27.81507682800293 18.1883487701416 L 27.35359764099121 22.67697715759277 Z" fill="url(#gradient)" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_tvx9uj =
    '<svg viewBox="249.6 589.0 80.4 1.0" ><path transform="translate(5266.0, 163.0)" d="M -4936 426 L -5016.4072265625 426" fill="none" fill-opacity="0.36" stroke="#ffffff" stroke-width="1" stroke-opacity="0.36" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_aabzhs =
    '<svg viewBox="200.2 613.0 43.8 43.8" ><defs><linearGradient id="gradient" x1="0.5" y1="0.0" x2="0.5" y2="1.0"><stop offset="0.0" stop-color="#ff252883"  /><stop offset="1.0" stop-color="#ff464bf9"  /></linearGradient></defs><path transform="translate(200.19, 613.0)" d="M 21.90419960021973 43.80839920043945 C 18.9470386505127 43.80839920043945 16.07839012145996 43.22927856445313 13.37790966033936 42.08712005615234 C 10.76953983306885 40.98392105102539 8.427029609680176 39.40457916259766 6.415419578552246 37.39297866821289 C 4.403819561004639 35.38137054443359 2.824479579925537 33.03886032104492 1.721279621124268 30.43049049377441 C 0.5791196227073669 27.73000907897949 -3.997802764388325e-07 24.86136054992676 -3.997802764388325e-07 21.90419960021973 C -3.997802764388325e-07 18.9472599029541 0.5791196227073669 16.0787296295166 1.721279621124268 13.37828922271729 C 2.824499607086182 10.76992988586426 4.403839588165283 8.427399635314941 6.415419578552246 6.415759563446045 C 8.427059173583984 4.404059410095215 10.76957988739014 2.824659585952759 13.37790966033936 1.721409559249878 C 16.07840919494629 0.5791695713996887 18.94705963134766 -3.997802764388325e-07 21.90419960021973 -3.997802764388325e-07 C 24.8613395690918 -3.997802764388325e-07 27.72999000549316 0.5791695713996887 30.43049049377441 1.721409559249878 C 33.038818359375 2.824659585952759 35.38134002685547 4.404059410095215 37.39297866821289 6.415759563446045 C 39.40456008911133 8.427399635314941 40.9838981628418 10.76992988586426 42.08712005615234 13.37828922271729 C 43.22927856445313 16.0787296295166 43.80839920043945 18.9472599029541 43.80839920043945 21.90419960021973 C 43.80839920043945 24.86136054992676 43.22927856445313 27.73000907897949 42.08712005615234 30.43049049377441 C 40.98392105102539 33.03886032104492 39.40457916259766 35.38137054443359 37.39297866821289 37.39297866821289 C 35.38137054443359 39.40457916259766 33.03886032104492 40.98392105102539 30.43049049377441 42.08712005615234 C 27.73000907897949 43.22927856445313 24.86136054992676 43.80839920043945 21.90419960021973 43.80839920043945 Z M 21.84930038452148 9.311399459838867 C 14.93587970733643 9.311399459838867 9.311399459838867 14.93587970733643 9.311399459838867 21.84930038452148 C 9.311399459838867 28.76272010803223 14.93587970733643 34.38719940185547 21.84930038452148 34.38719940185547 C 28.76272010803223 34.38719940185547 34.38719940185547 28.76272010803223 34.38719940185547 21.84930038452148 L 34.38719940185547 19.34189987182617 L 21.84930038452148 19.34189987182617 L 21.84930038452148 24.35669898986816 L 28.94309997558594 24.35669898986816 C 27.87813949584961 27.35727882385254 25.02697944641113 29.37240028381348 21.84930038452148 29.37240028381348 C 17.7010498046875 29.37240028381348 14.32619953155518 25.99754905700684 14.32619953155518 21.84930038452148 C 14.32619953155518 17.7010498046875 17.7010498046875 14.32619953155518 21.84930038452148 14.32619953155518 C 23.64753913879395 14.32619953155518 25.37798881530762 14.97119998931885 26.72189903259277 16.14239883422852 L 30.01679992675781 12.36059951782227 C 27.75935935974121 10.39479923248291 24.85871887207031 9.311399459838867 21.84930038452148 9.311399459838867 Z" fill="url(#gradient)" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_rrjtxt =
    '<svg viewBox="105.0 203.6 53.1 1.0" ><path transform="translate(105.0, 203.63)" d="M 0 0.372039794921875 L 53.1092529296875 0" fill="none" stroke="#ffffff" stroke-width="4" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_zdpvxp =
    '<svg viewBox="105.0 235.6 122.6 1.0" ><path transform="translate(105.0, 235.63)" d="M 0 0 L 122.6165161132813 0" fill="none" stroke="#ffffff" stroke-width="4" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
