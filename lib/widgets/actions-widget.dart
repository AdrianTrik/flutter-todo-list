import 'package:carrefour/model/loading-flag.dart';
import 'package:carrefour/service/item-service.dart';
import 'package:carrefour/service/util-service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'alert-widget.dart';

enum Opciones { Delete }

class ActionsWidget extends StatefulWidget {
  @override
  _ActionsWidgetState createState() => _ActionsWidgetState();
}

class _ActionsWidgetState extends State<ActionsWidget> {
  final itemService = ItemService();

  deleteAll() async {
    Provider.of<LoadingFlag>(context, listen: false).toggleSaving();

    Navigator.of(context).pop();

    await itemService.deleteAll();

    Provider.of<LoadingFlag>(context, listen: false).toggleSaving();

    UtilService.getFlushBar(context, 'Se eliminaron todos los productos');
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      onSelected: (value) {
        switch (value) {
          case Opciones.Delete:
            showDialog(
                context: context,
                builder: (context) {
                  return AlertWidget(
                    title: 'Eliminar todo',
                    content:
                        'Esta seguro que desea eliminar todos los productos?',
                    acceptText: 'Eliminar todo',
                    acceptAction: () async {
                      await deleteAll();
                    },
                  );
                });
        }
      },
      offset: Offset(100.0, 100.0),
      itemBuilder: (BuildContext context) {
        return <PopupMenuEntry>[
          PopupMenuItem(
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.delete,
                  color: Colors.black,
                ),
                Text('Eliminar todo'),
              ],
            ),
            value: Opciones.Delete,
            height: 20.0,
          ),
        ];
      },
    );
  }
}
