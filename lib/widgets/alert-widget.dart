import 'package:flutter/material.dart';

class AlertWidget extends StatelessWidget {
  AlertWidget(
      {this.title,
      this.content,
      @required this.acceptText,
      @required this.acceptAction});

  final String title;
  final String content;
  final String acceptText;
  final Function acceptAction;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: title != null ? Text(title) : null,
      content: content != null ? Text(content) : null,
      actions: <Widget>[
        FlatButton(
          child: Text('Cancelar'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        FlatButton(
          child: Text(acceptText),
          onPressed: acceptAction,
        ),
      ],
    );
  }
}
