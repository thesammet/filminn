import 'package:FilmInn/Config/config.dart';
import 'package:FilmInn/Pages/Main%20Pages/home.dart';
import 'package:FilmInn/Widgets/defaultButtons.dart';
import 'package:FilmInn/Widgets/defaultTextfield.dart';
import 'package:FilmInn/Widgets/dialogWidgets.dart';
import 'package:FilmInn/Widgets/logo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'login.dart';

class Register extends StatefulWidget {
  Register({Key key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String userImageUrl = "";
  File _imageFile;

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
    final double _screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.blue,
      resizeToAvoidBottomInset: false,
      body: Container(
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
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(
              height: 30,
            ),
            InkWell(
              onTap: _selectAndPickImage,
              child: CircleAvatar(
                radius: _screenWidth * 0.15,
                backgroundColor: Colors.white,
                backgroundImage:
                    _imageFile == null ? null : FileImage(_imageFile),
                child: _imageFile == null
                    ? Icon(
                        Icons.person,
                        size: _screenWidth * 0.15,
                        color: Colors.grey,
                      )
                    : null,
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
            Text(
              'Add profile picture',
              style: TextStyle(
                fontFamily: 'Gotham',
                fontSize: 15,
                color: const Color(0xffffffff),
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.left,
            ),
            SizedBox(
              height: 20.0,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 40.0, vertical: 5),
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
                            fontSize: 17,
                            color: const Color(0xffffffff),
                            letterSpacing: 0.8400000000000001,
                            fontWeight: FontWeight.w700,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        SizedBox(height: 3),
                        DefaultTextfield(
                          controller: _emailController,
                          hintText: "filminn@gmail.com",
                          textInputType: TextInputType.emailAddress,
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'USERNAME',
                          style: TextStyle(
                            fontFamily: 'Gotham',
                            fontSize: 17,
                            color: const Color(0xffffffff),
                            letterSpacing: 0.8400000000000001,
                            fontWeight: FontWeight.w700,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        SizedBox(height: 3),
                        DefaultTextfield(
                          controller: _usernameController,
                          hintText: "FilmInn Username",
                          textInputType: TextInputType.multiline,
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'PASSWORD',
                          style: TextStyle(
                            fontFamily: 'Gotham',
                            fontSize: 17,
                            color: const Color(0xffffffff),
                            letterSpacing: 0.8400000000000001,
                            fontWeight: FontWeight.w700,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        SizedBox(height: 3),
                        Container(
                          width: 285.0,
                          height: 50.0,
                          decoration: BoxDecoration(
                            color: const Color(0xff707070),
                            borderRadius: new BorderRadius.circular(9.0),
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
                                        ? passwordIconData = Icons.visibility
                                        : passwordIconData =
                                            Icons.visibility_off;
                                  },
                                  icon: Icon(passwordIconData)),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(9.0),
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
                                borderRadius: new BorderRadius.circular(9.0),
                              ),
                            ),
                            validator: (val) =>
                                val.length < 6 ? 'Password too short.' : null,
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
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "By clicking create an account",
                      style: TextStyle(
                        fontFamily: 'Gotham',
                        fontSize: 13,
                        color: const Color(0xffffffff),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "you accept the ",
                          style: TextStyle(
                            fontFamily: 'Gotham',
                            fontSize: 13,
                            color: const Color(0xffffffff),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            print("user agreement");
                            _showMyDialog();
                          },
                          child: Text(
                            'Privacy Policy.',
                            style: TextStyle(
                              fontFamily: 'Gotham',
                              fontSize: 14,
                              color: const Color(0xff484dff),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            GestureDetector(
              onTap: () {
                print("register tıklandı.");
                uploadAndSaveImage();
              },
              child: DefaultButton(
                text: "Create Account",
              ),
            ),
            SizedBox(
              height: 15,
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => Login()));
              },
              child: Text("I already have an account !",
                  style: TextStyle(
                    color: Colors.white,
                  )),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.black,
          title: Text(
            'Privacy Policy',
            style: TextStyle(
              fontFamily: 'Gotham',
              fontSize: 17,
              color: const Color(0xff484dff),
              fontWeight: FontWeight.w500,
            ),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  "Privacy Policy for Film Inn\n" +
                      "Privacy Policy\n" +
                      "Last updated: March 13, 2021\n" +
                      "This Privacy Policy describes Our policies and procedures on the collection, use and disclosure of Your information when You use the Service and tells You about Your privacy rights and how the law protects You.\n" +
                      "We use Your Personal data to provide and improve the Service. By using the Service, You agree to the collection and use of information in accordance with this Privacy Policy. This Privacy Policy has been created with the help of the Privacy Policy Generator.\n" +
                      "Interpretation and Definitions\n" +
                      "Interpretation\n" +
                      "The words of which the initial letter is capitalized have meanings defined under the following conditions. The following definitions shall have the same meaning regardless of whether they appear in singular or in plural.\n" +
                      "Definitions\n" +
                      "For the purposes of this Privacy Policy:\n" +
                      "Account means a unique account created for You to access our Service or parts of our Service.\n" +
                      "Affiliate means an entity that controls, is controlled by or is under common control with a party, where control means ownership of 50% or more of the shares, equity interest or other securities entitled to vote for election of directors or other managing authority.\n" +
                      "Application means the software program provided by the Company downloaded by You on any electronic device, named Film Inn\n" +
                      "Company (referred to as either the Company, We, Us, Our in this Agreement) refers to Film Inn.\n" +
                      "Country refers to: Turkey\n" +
                      "Device means any device that can access the Service such as a computer, a cellphone or a digital tablet.\n" +
                      "Personal Data is any information that relates to an identified or identifiable individual.\n" +
                      "Service refers to the Application.\n" +
                      "Service Provider means any natural or legal person who processes the data on behalf of the Company. It refers to third-party companies or individuals employed by the Company to facilitate the Service, to provide the Service on behalf of the Company, to perform services related to the Service or to assist the Company in analyzing how the Service is used.\n" +
                      "Third-party Social Media Service refers to any website or any social network website through which a User can log in or create an account to use the Service.\n" +
                      "Usage Data refers to data collected automatically, either generated by the use of the Service or from the Service infrastructure itself (for example, the duration of a page visit).\n" +
                      "You means the individual accessing or using the Service, or the company, or other legal entity on behalf of which such individual is accessing or using the Service, as applicable.\n" +
                      "Collecting and Using Your Personal Data\n" +
                      "Types of Data Collected\n" +
                      "Personal Data\n" +
                      "While using Our Service, We may ask You to provide Us with certain personally identifiable information that can be used to contact or identify You. Personally identifiable information may include, but is not limited to:\n" +
                      "Email address\n" +
                      "First name and last name\n" +
                      "Usage Data\n" +
                      "Usage Data\n" +
                      "Usage Data is collected automatically when using the Service.\n" +
                      "Usage Data may include information such as Your Device's Internet Protocol address (e.g. IP address), browser type, browser version, the pages of our Service that You visit, the time and date of Your visit, the time spent on those pages, unique device identifiers and other diagnostic data.\n" +
                      "When You access the Service by or through a mobile device, We may collect certain information automatically, including, but not limited to, the type of mobile device You use, Your mobile device unique ID, the IP address of Your mobile device, Your mobile operating system, the type of mobile Internet browser You use, unique device identifiers and other diagnostic data.\n" +
                      "We may also collect information that Your browser sends whenever You visit our Service or when You access the Service by or through a mobile device.\n" +
                      "Information Collected while Using the Application\n" +
                      "While using Our Application, in order to provide features of Our Application, We may collect, with Your prior permission:\n" +
                      "Pictures and other information from your Device's camera and photo library\n" +
                      "We use this information to provide features of Our Service, to improve and customize Our Service. The information may be uploaded to the Company's servers and/or a Service Provider's server or it may be simply stored on Your device.\n" +
                      "You can enable or disable access to this information at any time, through Your Device settings.\n" +
                      "Use of Your Personal Data\n" +
                      "The Company may use Personal Data for the following purposes:\n" +
                      "To provide and maintain our Service, including to monitor the usage of our Service.\n" +
                      "To manage Your Account: to manage Your registration as a user of the Service. The Personal Data You provide can give You access to different functionalities of the Service that are available to You as a registered user.\n" +
                      "For the performance of a contract: the development, compliance and undertaking of the purchase contract for the products, items or services You have purchased or of any other contract with Us through the Service.\n" +
                      "To contact You: To contact You by email, telephone calls, SMS, or other equivalent forms of electronic communication, such as a mobile application's push notifications regarding updates or informative communications related to the functionalities, products or contracted services, including the security updates, when necessary or reasonable for their implementation.\n" +
                      "To provide You with news, special offers and general information about other goods, services and events which we offer that are similar to those that you have already purchased or enquired about unless You have opted not to receive such information.\n" +
                      "To manage Your requests: To attend and manage Your requests to Us.\n" +
                      "For business transfers: We may use Your information to evaluate or conduct a merger, divestiture, restructuring, reorganization, dissolution, or other sale or transfer of some or all of Our assets, whether as a going concern or as part of bankruptcy, liquidation, or similar proceeding, in which Personal Data held by Us about our Service users is among the assets transferred.\n" +
                      "For other purposes: We may use Your information for other purposes, such as data analysis, identifying usage trends, determining the effectiveness of our promotional campaigns and to evaluate and improve our Service, products, services, marketing and your experience.\n" +
                      "We may share Your personal information in the following situations:\n" +
                      "With Service Providers: We may share Your personal information with Service Providers to monitor and analyze the use of our Service, to contact You.\n" +
                      "For business transfers: We may share or transfer Your personal information in connection with, or during negotiations of, any merger, sale of Company assets, financing, or acquisition of all or a portion of Our business to another company.\n" +
                      "With Affiliates: We may share Your information with Our affiliates, in which case we will require those affiliates to honor this Privacy Policy. Affiliates include Our parent company and any other subsidiaries, joint venture partners or other companies that We control or that are under common control with Us.\n" +
                      "With business partners: We may share Your information with Our business partners to offer You certain products, services or promotions.\n" +
                      "With other users: when You share personal information or otherwise interact in the public areas with other users, such information may be viewed by all users and may be publicly distributed outside. If You interact with other users or register through a Third-Party Social Media Service, Your contacts on the Third-Party Social Media Service may see Your name, profile, pictures and description of Your activity. Similarly, other users will be able to view descriptions of Your activity, communicate with You and view Your profile.\n" +
                      "With Your consent: We may disclose Your personal information for any other purpose with Your consent.\n" +
                      "Retention of Your Personal Data\n" +
                      "The Company will retain Your Personal Data only for as long as is necessary for the purposes set out in this Privacy Policy. We will retain and use Your Personal Data to the extent necessary to comply with our legal obligations (for example, if we are required to retain your data to comply with applicable laws), resolve disputes, and enforce our legal agreements and policies.\n" +
                      "The Company will also retain Usage Data for internal analysis purposes. Usage Data is generally retained for a shorter period of time, except when this data is used to strengthen the security or to improve the functionality of Our Service, or We are legally obligated to retain this data for longer time periods.\n" +
                      "Transfer of Your Personal Data\n" +
                      "Your information, including Personal Data, is processed at the Company's operating offices and in any other places where the parties involved in the processing are located. It means that this information may be transferred to — and maintained on — computers located outside of Your state, province, country or other governmental jurisdiction where the data protection laws may differ than those from Your jurisdiction.\n" +
                      "Your consent to this Privacy Policy followed by Your submission of such information represents Your agreement to that transfer.\n" +
                      "The Company will take all steps reasonably necessary to ensure that Your data is treated securely and in accordance with this Privacy Policy and no transfer of Your Personal Data will take place to an organization or a country unless there are adequate controls in place including the security of Your data and other personal information.\n" +
                      "Disclosure of Your Personal Data\n" +
                      "Business Transactions\n" +
                      "If the Company is involved in a merger, acquisition or asset sale, Your Personal Data may be transferred. We will provide notice before Your Personal Data is transferred and becomes subject to a different Privacy Policy.\n" +
                      "Law enforcement\n" +
                      "Under certain circumstances, the Company may be required to disclose Your Personal Data if required to do so by law or in response to valid requests by public authorities (e.g. a court or a government agency).\n" +
                      "Other legal requirements\n" +
                      "The Company may disclose Your Personal Data in the good faith belief that such action is necessary to:\n" +
                      "Comply with a legal obligation\n" +
                      "Protect and defend the rights or property of the Company\n" +
                      "Prevent or investigate possible wrongdoing in connection with the Service\n" +
                      "Protect the personal safety of Users of the Service or the public\n" +
                      "Protect against legal liability\n" +
                      "Security of Your Personal Data\n" +
                      "The security of Your Personal Data is important to Us, but remember that no method of transmission over the Internet, or method of electronic storage is 100% secure. While We strive to use commercially acceptable means to protect Your Personal Data, We cannot guarantee its absolute security.\n" +
                      "Children's Privacy\n" +
                      "Our Service does not address anyone under the age of 13. We do not knowingly collect personally identifiable information from anyone under the age of 13. If You are a parent or guardian and You are aware that Your child has provided Us with Personal Data, please contact Us. If We become aware that We have collected Personal Data from anyone under the age of 13 without verification of parental consent, We take steps to remove that information from Our servers.\n" +
                      "If We need to rely on consent as a legal basis for processing Your information and Your country requires consent from a parent, We may require Your parent's consent before We collect and use that information.\n" +
                      "Links to Other Websites\n" +
                      "Our Service may contain links to other websites that are not operated by Us. If You click on a third party link, You will be directed to that third party's site. We strongly advise You to review the Privacy Policy of every site You visit.\n" +
                      "We have no control over and assume no responsibility for the content, privacy policies or practices of any third party sites or services.\n" +
                      "Changes to this Privacy Policy\n" +
                      "We may update Our Privacy Policy from time to time. We will notify You of any changes by posting the new Privacy Policy on this page.\n" +
                      "We will let You know via email and/or a prominent notice on Our Service, prior to the change becoming effective and update the Last updated date at the top of this Privacy Policy.\n" +
                      "You are advised to review this Privacy Policy periodically for any changes. Changes to this Privacy Policy are effective when they are posted on this page.\n" +
                      "Contact Us\n" +
                      "If you have any questions about this Privacy Policy, You can contact us:\n" +
                      "By email: filminnapp@gmail.com\n" +
                      "Privacy Policy for Film Inn",
                  style: TextStyle(
                    fontFamily: 'Gotham',
                    fontSize: 14,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'Approve',
                style: TextStyle(
                  fontFamily: 'Gotham',
                  fontSize: 14,
                  color: const Color(0xff484dff),
                  fontWeight: FontWeight.w500,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _selectAndPickImage() async {
    _imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
  }

  Future<void> uploadAndSaveImage() async {
    if (_imageFile == null) {
      showDialog(
          context: context,
          builder: (c) {
            return ErrorAlertDialog(
              errorMessage: "Please select an image",
            );
          });
    } else {
      _emailController.text.isNotEmpty &&
              _passwordController.text.length >= 6 &&
              _usernameController.text.isNotEmpty
          ? uploadToStorage()
          : displayDialog(
              "Please fill the registiration form!\n\nPassword must contain 6 characters.");
    }
  }

  displayDialog(String msg) {
    showDialog(
        context: context,
        builder: (c) {
          return ErrorAlertDialog(
            errorMessage: msg,
          );
        });
  }

  Future<void> uploadToStorage() async {
    showDialog(
        context: context,
        builder: (c) {
          return LoadingAlertDialog(
            loadingMessage: "Your account is being created. Please wait...",
          );
        });

    String imageFileName = DateTime.now().millisecondsSinceEpoch.toString();

    Reference stroageReference =
        FirebaseStorage.instance.ref().child(imageFileName);

    UploadTask storageUploadTask =
        stroageReference.putFile(await compressFile(_imageFile));

    TaskSnapshot taskSnapshot = await storageUploadTask;

    await taskSnapshot.ref.getDownloadURL().then((urlImage) {
      userImageUrl = urlImage;

      _registerUser();
    });
  }

  FirebaseAuth _auth = FirebaseAuth.instance;
  void _registerUser() async {
    User firebaseUser;

    await _auth
        .createUserWithEmailAndPassword(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim())
        .then((auth) {
      firebaseUser = auth.user;
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
      saveUserInfoToFirestore(firebaseUser).then((value) {
        Navigator.pop(context);
        Route route = MaterialPageRoute(builder: (c) => Home());
        Navigator.pushReplacement(context, route);
      });
    }
  }

  saveUserInfoToFirestore(User fUser) async {
    FirebaseFirestore.instance.collection('users').doc(fUser.uid).set({
      "email": fUser.email,
      "username": _usernameController.text.trim(),
      "url": userImageUrl,
      "uid": fUser.uid,
    });
    await FilmInn.sharedPreferences.setString("uid", fUser.uid);
    await FilmInn.sharedPreferences.setString(FilmInn.userEmail, fUser.email);
    await FilmInn.sharedPreferences
        .setString(FilmInn.userName, _usernameController.text.trim());
    await FilmInn.sharedPreferences
        .setString(FilmInn.userAvatarUrl, userImageUrl);
  }
}

Future<File> compressFile(File file) async {
  File compressedFile = await FlutterNativeImage.compressImage(
    file.path,
    quality: 15,
  );
  return compressedFile;
}
