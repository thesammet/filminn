import 'package:flutter/material.dart';

class DefaultButton extends StatelessWidget {
  final String text;

  const DefaultButton({
    Key key,
    @required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(9.0),
        gradient: LinearGradient(
          begin: Alignment(0.0, -1.0),
          end: Alignment(0.0, 1.0),
          colors: [const Color(0xff484dff), const Color(0xff242780)],
          stops: [0.0, 1.0],
        ),
      ),
      width: 285.0,
      height: 50.0,
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            fontFamily: 'Gotham',
            fontSize: 17,
            color: const Color(0xffffffff),
            fontWeight: FontWeight.w700,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
