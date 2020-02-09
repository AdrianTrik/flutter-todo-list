import 'package:carrefour/constants.dart';
import 'package:carrefour/model/item.dart';
import 'package:carrefour/model/loading-flag.dart';
import 'package:carrefour/service/item-service.dart';
import 'package:carrefour/service/util-service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'alert-widget.dart';

class ItemListWidget extends StatefulWidget {
  @override
  _ItemListWidgetState createState() => _ItemListWidgetState();
}

class _ItemListWidgetState extends State<ItemListWidget> {
  ItemService itemService = ItemService();
  final firestore = Firestore.instance;

  deleteItem(Item item) async {
    Provider.of<LoadingFlag>(context, listen: false).toggleSaving();

    Navigator.of(context).pop();

    await itemService.delete(item);

    Provider.of<LoadingFlag>(context, listen: false).toggleSaving();

    UtilService.getFlushBar(context, 'Se elimino un producto');
  }

  @override
  Widget build(BuildContext context) {
    return Provider.of<LoadingFlag>(context).isSaving
        ? Center(child: CircularProgressIndicator())
        : StreamBuilder<QuerySnapshot>(
            stream:
                firestore.collection('items').orderBy('product').snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(
                    backgroundColor: kBlueCarrefour,
                  ),
                );
              }

              final items = snapshot.data.documents;
              List<Item> listItems = List<Item>();

              for (var item in items) {
                listItems.add(Item(
                  id: item.documentID,
                  product: item.data['product'],
                  quantity: item.data['quantity'],
                  checked: item.data['checked'],
                ));
              }

              return ListView.builder(
                itemBuilder: (context, index) {
                  final item = listItems[index];
                  return ListTile(
                    onLongPress: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertWidget(
                              title: 'Eliminar producto',
                              content: 'Seguro que desea eliminar el producto?',
                              acceptText: 'Eliminar',
                              acceptAction: () {
                                deleteItem(item);
                              },
                            );
                          });
                    },
                    title: Text(
                      item.product,
                      style: TextStyle(
                          decoration:
                              item.checked ? TextDecoration.lineThrough : null),
                    ),
                    subtitle: Text(
                      item.quantity != null ? item.quantity : '',
                      style: TextStyle(
                          decoration:
                              item.checked ? TextDecoration.lineThrough : null),
                    ),
                    trailing: Checkbox(
                        value: item.checked,
                        onChanged: (value) {
                          itemService.toggleCheck(item);
                        }),
                  );
                },
                itemCount: listItems.length,
              );
            },
          );
  }
}
