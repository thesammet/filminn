import 'package:flutter/material.dart';

class ErrorAlertDialog extends StatelessWidget {
  final String errorMessage;
  const ErrorAlertDialog({Key key, this.errorMessage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      key: key,
      content: Text(errorMessage),
      actions: [
        RaisedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          color: Colors.red,
          child: Center(
            child: Text("OK"),
          ),
        )
      ],
    );
  }
}

class LoadingAlertDialog extends StatelessWidget {
  final String loadingMessage;
  const LoadingAlertDialog({Key key, this.loadingMessage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      key: key,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircularProgressIndicator(),
          SizedBox(
            height: 10,
          ),
          Center(child: Text(loadingMessage)),
        ],
      ),
    );
  }
}
