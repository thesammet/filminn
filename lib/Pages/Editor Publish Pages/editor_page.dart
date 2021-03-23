import 'package:FilmInn/Widgets/logo.dart';
import 'package:flutter/material.dart';
import 'editor_publish_film.dart';
import 'editor_publish_list.dart';
import 'editor_publish_new.dart';
import 'editor_publish_upcoming.dart';

class EditorUploadPage extends StatefulWidget {
  final String editorName;

  const EditorUploadPage({
    Key key,
    this.editorName,
  }) : super(key: key);

  @override
  _EditorUploadPageState createState() => _EditorUploadPageState();
}

class _EditorUploadPageState extends State<EditorUploadPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Editor Publish Page',
            style: TextStyle(
              fontFamily: 'Gotham',
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.left,
          ),
          backgroundColor: const Color(0xff484dff),
        ),
        backgroundColor: Colors.black,
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Logo(),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                child: Text(
                  'Dear editor ' +
                      widget.editorName +
                      ",\n" +
                      'People wait your great reviews.',
                  style: TextStyle(
                    fontFamily: 'Gotham',
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              SizedBox(
                height: 45,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return EditorPublishFilm();
                      },
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
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
                    height: 50,
                    width: 220,
                    child: Center(
                      child: Text(
                        'Publish Film',
                        style: TextStyle(
                          fontFamily: 'Gotham',
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return EditorPublishList();
                      },
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
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
                    height: 50,
                    width: 220,
                    child: Center(
                      child: Text(
                        'Publish Film List',
                        style: TextStyle(
                          fontFamily: 'Gotham',
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return EditorPublishNew();
                      },
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
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
                    height: 50,
                    width: 220,
                    child: Center(
                      child: Text(
                        'Publish News',
                        style: TextStyle(
                          fontFamily: 'Gotham',
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return EditorPublishUpcoming();
                      },
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
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
                    height: 50,
                    width: 220,
                    child: Center(
                      child: Text(
                        'Publish Upcoming',
                        style: TextStyle(
                          fontFamily: 'Gotham',
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
